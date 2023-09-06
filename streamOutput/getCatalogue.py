# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/8/15 19:26
# @Author : FanShu
# @Site :
# @File : getCatalogue.py
# @Software: PyCharm
import requests
import json
import os
from package_open import create_package
from package_open import Open


class cataLogue():

    def __init__(self):
        self.Cookie = 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-09-08+10%3A37%3A05; sysLoginType=%7B%22sysId%22%3A1%2C%22sysType%22%3A0%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5NDM5OTgyNSwiaWF0IjoxNjkzODgxNDM1fQ.AhjEwy2X47gc0vYdtRTsHIVKi5-7nORl7jUYcxLA9g4; dt_is_tenant_admin=true; dt_is_tenant_creator=false; dt_product_code=RDOS; JSESSIONID=A891C73C2FB3E9423207427E3600038D; DT_SESSION_ID=c0237161-9124-46da-a5ec-b5065baebc20'
        self.request_url = "http://172.16.82.4/"
        self.nodePid = 79
        self.project_id = 11
        self.headers = {
            'Accept': '*/*',
            'Accept-Language': 'zh-CN,zh;q=0.9',
            'Cache-Control': 'no-cache',
            'Connection': 'keep-alive',
            'Content-Type': 'text/plain;charset=UTF-8',
            'Cookie': self.Cookie,
            'Pragma': 'no-cache',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
            'X-Project-ID': f'{self.project_id}'
        }
        self.new_body = None
        self.new_list = None
        self.current_path = '/Users/four/Downloads/four_git/jenkins-tools/jenkins-tools/streamOutput/test/'

    def getCatalogue(self, nodePid=None):
        """
        :return: 获取跟目录下所有文件夹信息
        """
        if nodePid is None:
            nodePid = self.nodePid
        url = f"{self.request_url}api/streamapp/service/streamCatalogue/getCatalogue"
        payload = "{\"nodePid\":%s,\"catalogueType\":\"TaskDevelop\",\"isGetFile\":true}" % nodePid
        response = requests.request("POST", url, headers=self.headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']['children']
        return data

    def getTaskInfo(self):
        """
        :return: 获取getCatalogue接口任务信息
        """
        cataLogue = self.getCatalogue()
        id_list = [x['id'] for x in cataLogue if x['type'] == 'folder']
        new_list = [dict(id=x['id'], name=x['name'], parentId=x['parentId']) for x in cataLogue if
                    x['type'] == 'folder']
        for _ in id_list:
            low_catalogue = self.getCatalogue(_)[0]
            if low_catalogue['type'] == "folder":
                id_list.append(low_catalogue['id'])
                new_list.append(
                    dict(id=low_catalogue['id'], name=low_catalogue['name'], parentId=low_catalogue['parentId']))
                print(f"low_catalogue:{_}")
                level_3_catalogue = self.getCatalogue(low_catalogue['id'])[0]
                if level_3_catalogue['type'] == "folder":
                    print(f"not support this level:{level_3_catalogue}")
                    break
                else:
                    task_id = level_3_catalogue['id']
                    task_name = level_3_catalogue['name']
                    print(f"level_3_catalogue id:{task_id}, name:{task_name}")
                continue
        self.new_list = new_list
        return id_list

    def getTaskList(self):
        """
        :return: 获取全部任务列表信息
        """
        id_list = self.getTaskInfo()
        task_list = []
        new_task_list = []
        for _ in id_list:
            catalogue = self.getCatalogue(_)
            for i in catalogue:
                if i['type'] == "folder":
                    continue
                else:
                    task_id = i['id']
                    task_name = i['name']
                    parent_id = i['parentId']
                    print(f"last_catalogue id:{task_id}, name:{task_name}")
                    task_list.append(task_id)
                    new_task_list.append(dict(task_id=task_id, task_name=task_name, parentId=parent_id))
        return new_task_list

    def getTaskById(self, task_id):
        """
        :return: 获取任务参数信息
        """
        payload = "{\"id\":34157}"
        # payload = "{\"id\":%s}" % task_id
        url = f"{self.request_url}api/streamapp/service/streamTask/getTaskById"
        response = requests.request("POST", url, headers=self.headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']
        sideParams = data['sideParams']
        sinkParams = data['sinkParams']
        sourceParams = data['sourceParams']
        sqlText = data['sqlText']
        dict_params = dict(sideParams=sideParams, sinkParams=sinkParams, sourceParams=sourceParams, sqlText=sqlText)
        print('dict_params:', dict_params)
        return dict_params

    def creatFileTask(self):
        """
        :return: 调用创建本地存储文件夹
        """
        self.getTaskInfo()
        new_body = []
        # 循环构建文件夹
        for _ in self.new_list:
            if _['parentId'] == self.nodePid:
                print("this is first leven")
                path = os.path.join(self.current_path, _['name'])
                create_package(path)
                new_body.append(dict(id=_['id'], name=_['name'], parentId=_['parentId'], path=path))
            else:
                c = [x['name'] for x in self.new_list if x['id'] == _['parentId']]
                print("this is second leven")
                path = os.path.join(self.current_path, c[0], _['name'])
                create_package(path)
                new_body.append(dict(id=_['id'], name=_['name'], parentId=_['parentId'], path=path))
        self.new_body = new_body
        return new_body

    def createTaskText(self):
        """
        :return: 创建本地文件
        """
        self.creatFileTask()
        print('new_body', self.new_body, '\n')
        task_list = self.getTaskList()
        for _ in task_list:
            task_info = self.getTaskById(_['task_id'])
            path = [x['path'] for x in self.new_body if _['parentId'] == x['id']]
            open_path = os.path.join(path[0], _['task_name']+'.sql', )
            o = Open(open_path)
            if task_info['sourceParams'] is not None:
                o.write(task_info['sourceParams'])
            if task_info['sideParams'] is not None:
                o.write(task_info['sideParams'])
            if task_info['sinkParams'] is not None:
                o.write(task_info['sinkParams'])
            if task_info['sqlText'] is not None:
                o.write(task_info['sqlText'])
            print(o.read())


if __name__ == '__main__':
    logue = cataLogue()
    # logue.getCatalogue()
    # logue.getTaskById()
    # logue.getTaskInfo()
    # logue.getTaskList()
    # logue.creatFileTask()
    logue.createTaskText()

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
        self.Cookie = 'dt_expire_cycle=0; dt_user_id=1; dt_username=admin%40dtstack.com; dt_can_redirect=false; dt_cookie_time=2023-09-08+10%3A25%3A00; dt_tenant_id=1; dt_tenant_name=DT_demo; dt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0ZW5hbnRfaWQiOiIxIiwidXNlcl9pZCI6IjEiLCJ1c2VyX25hbWUiOiJhZG1pbkBkdHN0YWNrLmNvbSIsImV4cCI6MTY5NDM5OTEwMCwiaWF0IjoxNjkzODgwNzA0fQ.iXFOvABg7GvF5-qgKIguKcue9xSz3J6i82GIZbJRAlA; dt_is_tenant_admin=true; dt_is_tenant_creator=false; sysLoginType=%7B%22sysType%22%3A0%2C%22sysId%22%3A1%2C%22sysName%22%3A%22UIC%u8D26%u53F7%u767B%u5F55%22%7D; JSESSIONID=EFABF81E40FD1645696B6A58FB0AE79C; DT_SESSION_ID=5771ca8c-df52-4a18-8f21-7aebeb58b729'
        self.request_url = "http://uic.dttestenv.cn/"
        self.nodePid = 719
        self.project_id = 27
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
        self.current_path = '/Users/four/Downloads/four_git/jenkins-tools/jenkins-tools/streamOutput/test_5.3/stream_ui_test/'
        self.cp_flink_task = None

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
        print('getCatalogue', data)
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
            if len(self.getCatalogue(_)) < 1:
                continue
            else:
                low_catalogue = self.getCatalogue(_)[0]
            if low_catalogue['type'] == "folder":
                id_list.append(low_catalogue['id'])
                new_list.append(
                    dict(id=low_catalogue['id'], name=low_catalogue['name'], parentId=low_catalogue['parentId']))
                print(f"low_catalogue:{low_catalogue}")
                if len(self.getCatalogue(low_catalogue['id'])) < 1:
                    continue
                else:
                    level_3_catalogue = self.getCatalogue(low_catalogue['id'])[0]
                if level_3_catalogue['type'] == "folder":
                    print(f"level_3_catalogue this level:{level_3_catalogue}")
                    id_list.append(low_catalogue['id'])
                    new_list.append(
                        dict(id=low_catalogue['id'], name=low_catalogue['name'], parentId=low_catalogue['parentId']))
                    continue
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
                    create_model = i['createModel']
                    task_type = i['taskType']
                    print(f"last_catalogue id:{task_id}, name:{task_name}, parent_id:{parent_id},"
                          f" create_model:{create_model}, task_type{task_type}")
                    task_list.append(task_id)
                    new_task_list.append(dict(task_id=task_id, task_name=task_name, parentId=parent_id,
                                              create_model=create_model, task_type=task_type))
        return new_task_list

    def getTaskById(self, task_id):
        """
        :return: 获取任务参数信息
        """
        payload = "{\"id\":%s}" % task_id
        url = f"{self.request_url}api/streamapp/service/streamTask/getTaskById"
        response = requests.request("POST", url, headers=self.headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']
        sideParams = data['sideParams']
        sinkParams = data['sinkParams']
        sourceParams = data['sourceParams']
        sqlText = data['sqlText']
        componentVersion = data['componentVersion']
        readWriteLockVO = json.dumps(data['readWriteLockVO'])
        version = data['version']
        lockVersion = json.dumps(data['lockVersion'])
        createModel = data['createModel']
        dict_params = dict(sideParams=sideParams, sinkParams=sinkParams, sourceParams=sourceParams, sqlText=sqlText,
                           componentVersion=componentVersion, readWriteLockVO=readWriteLockVO, version=version,
                           lockVersion=lockVersion, createModel=createModel)
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

    def copyTask(self, task_id, task_name, node_pid):
        """
        :return: 复制任务
        """
        url = f"{self.request_url}api/streamapp/service/streamTask/cloneTask"
        cp_task_name = "cp_" + f"{task_name}"
        node_pid = node_pid
        task_id = task_id
        payload = "{\"taskName\":\"%s\",\"nodePid\":%s,\"taskDesc\":null,\"taskId\":%s}" % (
        cp_task_name, node_pid, task_id)
        response = requests.request("POST", url, headers=self.headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']
        taskId = data['id']
        return taskId

    def guideToTemplate(self, task_id, task_name, node_pid):
        """
        :return: 向导模式转脚本模式
        """
        url = f"{self.request_url}api/streamapp/service/streamTask/guideToTemplate"
        cp_task_id = self.copyTask(task_id, task_name, node_pid)
        cp_task_info = self.getTaskById(task_id=cp_task_id)

        payload = "{\"id\":%s," \
                  "\"createModel\":%s," \
                  "\"lockVersion\":%s," \
                  "\"version\":%s," \
                  "\"readWriteLockVO\":%s," \
                  "\"componentVersion\":\"%s\"}" % (
                      cp_task_id, cp_task_info['createModel'], cp_task_info['lockVersion'],
                      cp_task_info['version'], cp_task_info['readWriteLockVO'], cp_task_info['componentVersion']
                  )
        print("payload:", payload)
        response = requests.request("POST", url, headers=self.headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']

    def deleteCopyFlinkTask(self, task_id):
        """
        :return: 删除
        """
        url = f"{self.request_url}api/streamapp/service/streamTask/deleteTask"
        payload = "{\"id\":%s}" % task_id
        response = requests.request("POST", url, headers=headers, data=payload)
        response_text = json.loads(response.text)
        data = response_text['data']
        print('deleteCopyFlinkTask', data)

    def flinkXTask(self):
        """
        :return: 实时采集任务复制后转脚本
        type: 11
        createModel: 0
        """
        all_task = self.getTaskList()
        flink_task = [x for x in all_task if x['task_type'] == 11 and x['create_model'] == 0]

        for _ in flink_task:
            print('flink_task:', _)
            self.guideToTemplate(_['task_id'], _['task_name'], _['parentId'])

        self.cp_flink_task = flink_task

    def createTaskText(self):
        """
        :return: 创建本地文件
        """
        self.creatFileTask()
        task_list = self.getTaskList()
        # 循环写入文件
        for _ in task_list:
            task_info = self.getTaskById(_['task_id'])
            path = [x['path'] for x in self.new_body if _['parentId'] == x['id']]
            open_path = os.path.join(path[0], _['task_name'] + '.sql', )
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

        for _ in self.cp_flink_task:
            self.deleteCopyFlinkTask(_)


if __name__ == '__main__':
    logue = cataLogue()
    # logue.getCatalogue()
    # logue.getTaskById()
    # logue.getTaskInfo()
    # logue.getTaskList()
    # logue.creatFileTask()
    logue.createTaskText()
    # logue.copyTask()
    # logue.guideToTemplate()
    logue.flinkXTask()

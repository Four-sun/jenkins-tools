# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/3/4 11:39
# @Author : FanShu
# @Site :
# @File : Jenkins_api1.py
# @Software: PyCharm

import sys
import jenkins

group = "%s" % sys.argv[1]
project = "%s" % sys.argv[2]
feature_branch = "%s" % sys.argv[3]
server = "%s" % sys.argv[4]
mysqlBase = "%s" % sys.argv[5]
incrementSql = "%s" % sys.argv[6]


class jenkinsFile:

    def __init__(self):
        self.jenkinsUrl = "http://172.16.101.151:8080"
        self.userName = "fanshu"
        self.passWord = "fanshu123"
        self.jobName = "IncrementalSQL-dev"
        self.build_param = {
            "group": "%s" % group,
            "project": "%s" % project,
            "feature_branch": "%s" % feature_branch,
            "server": "%s" % server,
            "mysql_base": "%s" % mysqlBase,
            "increment_sql": "%s" % incrementSql
        }

    def jenkins_server(self):
        try:
            server = jenkins.Jenkins(url="%s" % self.jenkinsUrl, username="%s" % self.userName,
                                     password="%s" % self.passWord, timeout=10)
            user = server.get_whoami()
            jenkins_version = server.get_version()
            print("当前登录用户: %s \n当前登录版本: %s" % (user['fullName'], jenkins_version))
            return server
        except Exception as Error:
            return Error

    def build_info(self):
        try:
            jenkinsServer = jenkinsFile().jenkins_server()
            job_info = jenkinsServer.get_job_info(self.jobName)
            get_last_build_number = jenkinsServer.get_job_info(self.jobName)['lastBuild']['number']
            print("当前最新打包数量: %s \n当前任务配置信息: %s" % (get_last_build_number, job_info))
        except Exception as Error:
            return Error

    def build_job(self):
        try:
            print("group:%s \nproject:%s \nfeature_branch:%s \nserver:%s \nmysqlBase:%s \nincrementSql:%s "
                  % (group, project, feature_branch, server, mysqlBase, incrementSql))
            jenkinsServer = jenkinsFile().jenkins_server()
            server_build_job = jenkinsServer.build_job(self.jobName, self.build_param)
            print("server_build_job: %s" % server_build_job)
        except Exception as Error:
            return Error

    def load_build_job(self):
        try:
            jenkinsServer = jenkinsFile().jenkins_server()

            # 获取job名为job_name的job的相关信息
            jenkinsServer.get_job_info(self.jobName)

            # 获取job名为job_name的job的最后次构建号
            build_number = jenkinsServer.get_job_info(self.jobName)['lastBuild']['number']
            print("最后次构建号", build_number)

            # 判断job名为job_name的job的某次构建是否还在构建中
            for i in range(1):
                building = jenkinsServer.get_build_info(self.jobName, build_number)['building']
                print("是否还在构建中", building)

            # 获取job名为job_name的job的某次构建的执行结果状态
            build_result = jenkinsServer.get_build_info(self.jobName, build_number)['result']
            print("执行结果状态", build_result)

        except Exception as Error:
            return Error


if __name__ == '__main__':
    JenkinsFile = jenkinsFile()
    JenkinsFile.build_job()
    # JenkinsFile.load_build_job()

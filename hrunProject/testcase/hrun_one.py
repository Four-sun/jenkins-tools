# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/4/1 17:05
# @Author : FanShu
# @Site :
# @File : hrun_one.py
# @Software: PyCharm

from httprunner import HttpRunner, Config, Step, RunRequest


class TestCaseLogin(HttpRunner):

    config = Config('hrun3_demo').base_url('http://uic.insight.net/uic/api/v2/account').export(*['vars_name'])

    teststeps = [
        Step(
            RunRequest('login')
                .post('/login')
                # .with_headers(**{'X-Requested-With': 'XMLHttpRequest'})
                .with_data({'username': 'admin@dtstack.com', 'password': 'YhnQKlqiWaY+1u5r7CdYOF3k/PGdzm32icgxN+lvA4p2kPT6RgubEst55PFvaKV9O1IqDi+UnaeIb/Rm8YCtzcx/zbIarvaD9e3ZCXSM17VvT+UBLNQuDgvf4e4xudl22+cHYO7AfdiFTTettM0d53KA/Wy+S/sqfYH0uViPZUs=', "verify_code": "0000"})
                .extract()
                    .with_jmespath('message', 'vars_name')
                .validate()
                    .assert_equal('body.message', "执行成功")
                    .assert_equal('body.success', True)
        ),

        Step(
            RunRequest('login')
                .post('/login')
                .with_cookies()
                # .with_headers(**{'X-Requested-With': 'XMLHttpRequest'})
                .with_data({'username': 'admin@dtstack.com',
                            'password': 'YhnQKlqiWaY+1u5r7CdYOF3k/PGdzm32icgxN+lvA4p2kPT6RgubEst55PFvaKV9O1IqDi+UnaeIb/Rm8YCtzcx/zbIarvaD9e3ZCXSM17VvT+UBLNQuDgvf4e4xudl22+cHYO7AfdiFTTettM0d53KA/Wy+S/sqfYH0uViPZUs=',
                            "verify_code": "0000"})
                .extract()
                .with_jmespath('message', 'vars_name')
                .validate()
                .assert_equal('body.message', "执行成功")
                .assert_equal('body.success', True)
        )
    ]


if __name__ == '__main__':
    TestCaseLogin().test_start()

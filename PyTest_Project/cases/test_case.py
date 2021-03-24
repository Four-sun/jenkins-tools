# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/1/25 21:31
# @Author : FanShu
# @Site : 
# @File : test_case.py
# @Software: PyCharm

import pytest


@pytest.fixture()
# 定义一个测试数据
def data():
    str = "python"
    assert "test" in str
    return str


def test_pass(data):
    assert data == "python"


if __name__ == '__main__':
    pytest.main(["-q", "test_case.py"])
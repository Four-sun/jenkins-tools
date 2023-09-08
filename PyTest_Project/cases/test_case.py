# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/1/25 21:31
# @Author : FanShu
# @Site :
# @File : test_case.py
# @Software: PyCharm
from collections import Counter
import random
import pytest


# @pytest.fixture()
# # 定义一个测试数据
# def data():
#     str = "python"
#     assert "ci_5.3" in str
#     return str

#
# def test_pass(data):
#     assert data == "python"


@pytest.mark.flaky(reruns=2, reruns_delay=1)
def test_retry():
    n = random.randint(1, 5)
    print(f"random list {n}")
    print(n)
    assert n == 2


if __name__ == '__main__':
    # pytest.main(["-q", "test_case.py"])
    pytest.main(["-q", "test_case.py"])

# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/1/25 20:26
# @Author : FanShu
# @Site : 
# @File : cases.py
# @Software: PyCharm

import pytest

@pytest.mark.me
def test_a():
    print("test1")
def test_b():
    print("test2")
def test_c():
    print("test3")
# class Dtstream_case:
#     # @pytest.fixture()
#     def setup(self):
#         print("this is setup")
#
#     def teardown(self):
#         print("this is teardown")
#
#     def test_a(self):  # test开头的测试函数
#         print("------->test_a")
#         assert 1 == 2  # 断言成功
#     @pytest.mark.parametrize("a", [3,4])
#     def test_b(self, a):
#         print("------->test_b")
#         assert a % 3 == 0
#
#
# if __name__ == '__main__':
#     pytest.main(["-s", "cases.py"])
    # pytest.main("-s cases.py")


# import pytest
#
# def division(a, b):
#     return int(a / b)
#
# @pytest.mark.parametrize('a, b, c', [(4, 2, 2), (0, 2, 0), (1, 0, 0), (6, 3, 2)])
# def test_2(a, b, c):
#     res = division(a, b)
#     assert res == c
#
# @pytest.mark.parametrize('a', [100])
# @pytest.mark.parametrize('b, c', [(4,25),(3,25)])
# def test_1(a, b, c):
#     res = division(a, b)
#     assert res == c
#
# if __name__ == '__main__':
#     pytest.main(["-q","--pdb"])
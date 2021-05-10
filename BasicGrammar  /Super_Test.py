# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/4/29 07:38
# @Author : FanShu
# @Site : 
# @File : Super_Test.py
# @Software: PyCharm

class fooParent(object):
    def __init__(self):
        self.parent = "this is parent"
        print("Parent")

    def bar(self, message):
        print("%s from Parent" % message)


class childParent(fooParent):
    def __init__(self):
        super(childParent, self).__init__()
        print("Child")

    def bar(self, message):
        super(childParent, self).bar(message)
        print("Child bar function")
        print(self.parent)


if __name__ == '__main__':
    fooChild = childParent()
    fooChild.bar("HEllO")
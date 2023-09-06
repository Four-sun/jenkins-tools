# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/8/24 10:34
# @Author : FanShu
# @Site :
# @File : package_open.py
# @Software: PyCharm

import os


def create_package(path):
    if os.path.exists(path):
        print('%s已经存在,不可创建:' % path)
        return
    os.makedirs(path)
    init_path = os.path.join(path, '__init__.py')
    f = open(init_path, 'w', encoding='utf-8')
    f.write('# coding: utf-8\n')
    f.close()


class Open(object):
    def __init__(self, path, mode='a', is_return=True):
        self.path = path
        self.mode = mode
        self.is_return = is_return

    def write(self, message):
        f = open(self.path, mode=self.mode, encoding='utf-8')
        try:
            message = '%s\n' % message
            f.write(message)
        except Exception as e:
            print(e)
        finally:
            f.close()

    def read(self, is_strip=True):
        result = []
        with open(self.path, mode='r', encoding='utf-8') as f:
            data = f.readlines()

        for line in data:
            if is_strip:
                temp = line.strip()
                if temp != '':
                    result.append(temp)
                else:
                    if line != '':
                        result.append(line)
        return result


if __name__ == '__main__':
    current_path = os.getcwd()
    path = os.path.join(current_path, 'fanshu2')
    create_package(path)
    open_path = os.path.join(path, 'insert.sql')
    o = Open(open_path)
    o.write('你好~')
    o.write('你好~')
    print(o.read())


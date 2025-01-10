# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2024/12/19 10:49
# @Author : FanShu
# @Site :
# @File : json_file_update.py
# @Software: PyCharm

import json

json_file_name = "index_1.json"
transform_file = "fanyi.txt"


def json_file_update(json_file_name,old_name,new_name):
    # 读取JSON文件
    with open(json_file_name, 'r', encoding='utf-8') as file:
        data = json.load(file)

    # 递归函数来替换字典中的所有匹配项
        def replace_in_dict(d, old, new):
            for k, v in list(d.items()):
                if isinstance(v, dict):
                    replace_in_dict(v, old, new)
                elif isinstance(v, list):
                    for item in v:
                        if isinstance(item, dict):
                            replace_in_dict(item, old, new)
                        elif isinstance(item, str) and item == old:
                            item.replace(old, new)
                elif isinstance(v, str) and v == old:
                    d[k] = new

        replace_in_dict(data, old_name, new_name)

        # 将修改后的数据写回JSON文件
        with open(json_file_name, 'w', encoding='utf-8') as file:
            json.dump(data, file, indent=4, ensure_ascii=False)


# 打开文件并逐行读取
with open(transform_file, 'r', encoding='utf-8') as file:

    for line in file:
        # 去除每行的首尾空白符（包括换行符）
        line = line.strip()
        # 检查行是否不为空
        if line:
            # 按照":"分割字符串
            parts = line.split(':')
            # 检查分割后是否正好有两个部分
            if len(parts) == 2:
                old_name = parts[0].strip().strip('"')  # 去除可能的引号和空白符
                new_name = parts[1].strip().strip('"').strip('",')  # 去除可能的引号和空白符
                # 输出old_name和new_name
                print(f'Old Name: {old_name}, New Name: {new_name}')

                json_file_update(json_file_name,old_name,new_name)

            else:
                print(f'Line format error: {line}')









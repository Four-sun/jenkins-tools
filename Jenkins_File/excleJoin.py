# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/9/13 17:20
# @Author : FanShu
# @Site :
# @File : excelJoin.py
# @Software: PyCharm
# import pandas as pd
# import os
#
# folder_path = "/Users/four/Desktop/test/"  # 文件夹路径
# excel_files = [f for f in os.listdir(folder_path) if f.endswith('xlsx')]
# dfs = []
#
# for file in excel_files:
#     df = pd.read_excel(os.path.join(folder_path, file))
#     dfs.append(df)
#     combined_df = pd.concat(dfs, ignore_index=True)
#     combined_df.to_excel(f'{folder_path}combined.xlsx', index_label=False)


# n = int(input())
# if n == 1:
#     print("1不是质数也不是合数")
# else:
#     for i in range(2, n):
#         if n % i == 0:
#             print("合数")
#             break
#     else:
#         print("质数")
#

# 有n个人围坐在一圈，从编号为1的人开始报数，报到m的人出列，然后从出列的下一个人开始重新报数，直到所有人都出列为止。求最后剩下的人的编号。
#
# **算法：**
#
# **双约瑟夫递推算法**
#
# **步骤：**
#
# 1. 初始化一个数组`result`，长度为$n$，表示每个人的出列顺序。
# 2. 设置当前报数的人为1，当前出列的人数为0。
# 3. 循环，直到所有人都出列：
#    - 如果当前报数的人不出列，则将其编号添加到`result`数组中。
#    - 否则，将其编号添加到`result`数组中，并将其出列。
#    - 将当前报数的人更新为出列的下一个人。
#    - 将当前出列的人数加1。
# 4. 返回`result`数组中最后一个编号。


# def josephus_double(n, m):
#   """
#   双约瑟夫问题。
#
#   参数：
#     n: 人数。
#     m: 报数到 m 的人出列。
#
#   返回：
#     最后剩下的人的编号。
#   """
#
#   result = []
#   current_person = 1
#   count = 0
#
#   while count < n:
#     if (current_person + m - 1) % n + 1 not in result:
#       result.append((current_person + m - 1) % n + 1)
#       count += 1
#     else:
#         current_person = (current_person + m) % n + 1
#
#   return result[0]

#
# n = 10
# m = 3
# result = josephus_double(n, m)
# print(result)  # 输出：4




# def Josephus(n, m):
#     if n == 1:
#         return 1
#     else:
#         s = (Josephus(n - 1, m) + m - 1) % n + 1
#         return s
#
# # 示例
# n = 10  # 总人数
# m = 3 # 报数间隔
# last_one = Josephus(n, m)
# print(f"The last person's number is {last_one}")


def Josephus(n, m):
    # 初始化编号为1的人为活动的人
    active_person = 1
    # 当只剩下一个人时，循环结束
    while n > 1:
      # 从当前活动的人开始报数
      for i in range(1, m):
        # 计算下一个活动的人的编号
        active_person = (active_person + 1) % n
      # 出列的人是报数到m的人，减少人数
      n -= 1
      # 更新活动的人的编号
      active_person = (active_person - 1) % n + 1  # 确保编号在1到n之间
    return active_person


# 示例
n = 10  # 总人数
m = 3  # 报数间隔
last_one = Josephus(n, m)
print(f"The last person's number is {last_one}")


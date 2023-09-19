# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2023/9/13 17:20
# @Author : FanShu
# @Site :
# @File : excelJoin.py
# @Software: PyCharm
import pandas as pd
import os

folder_path = "/Users/four/Desktop/test/"  # 文件夹路径
excel_files = [f for f in os.listdir(folder_path) if f.endswith('xlsx')]
dfs = []

for file in excel_files:
    df = pd.read_excel(os.path.join(folder_path, file))
    dfs.append(df)
    combined_df = pd.concat(dfs, ignore_index=True)
    combined_df.to_excel(f'{folder_path}combined.xlsx', index_label=False)


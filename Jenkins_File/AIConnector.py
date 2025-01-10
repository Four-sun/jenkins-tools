# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2025/1/10 10:19
# @Author : FanShu
# @Site : AI Connector Test
# @File : AIConnector.py
# @Software: PyCharm
import json

from openai import OpenAI

# 初始化OpenAI客户端，传入API Key和基础URL
client = OpenAI(
    api_key="sk-RjIFhpNJvI8GNx7F9e9n3uM6J65dvMQTI9e4fu3n5TJbYXiX",  # 将YOUR_API_KEY替换为你从Kimi开放平台申请的API Key
    base_url="https://api.moonshot.cn/v1",
)

transform_file = "./json_en.txt"  # Json中文需要翻译的文件路径

file_path = './output.txt'  # 指定要写入的文件路径,json_file_update使用需要

trans_line = []  # 初始化列表来存储读取的行

start_line = 1  # 从第几行开始读取

cycle_line = 7  # 读取到哪一行结束


def kimi_chat(trans_file=None):

    # 创建聊天完成请求
    trans_after = trans_file

    completion = client.chat.completions.create(
        model="moonshot-v1-8k",  # 选择合适的模型，如moonshot-v1-8k、moonshot-v1-32k、moonshot-v1-128k等
        messages=[
            {
                "role": "system",
                "content": "你是Kimi，由Moonshot AI提供的人工智能助手，你更擅长中文和英文的对话。你会为用户提供安全、有帮助、准确的回答。同时，你会拒绝一切涉及恐怖主义、种族歧视、黄色暴力等问题的回答。Moonshot AI为专有名词，不可翻译成其他语言。"
            },
            {
                "role": "user",
                "content": f"翻译的内容：{trans_after} 。翻译成英文，需要根据Flink官网的关键字输出，输出Json格式为 \"key\": \"value\" key为原翻译的字段名称，value为翻译成功后字段名称 "
            }
        ],
        temperature=0.3,  # 设置温度参数，控制生成内容的随机性
    )

    return completion.choices[0].message.content


with open(transform_file, 'r', encoding='utf-8') as file:  # 打开文件并逐行读取
    for line_number, line in enumerate(file, start=1):  # 使用enumerate来获取行号，从1开始计数
        if start_line <= line_number <= cycle_line:
            line = line.strip()  # 去除每行的首尾空白符（包括换行符）
            print(f'Line format : \'{line}\' ')
            trans_line.append(line)
        elif line_number > cycle_line:
            break  # 当读取到第20行时停止


# 获取Kimi大模型的回复消息

answer = kimi_chat(trans_file=trans_line)

json_str = answer.split('```')[1]

r_json = json_str.replace("json", "")

data = json.loads(r_json)  # 使用json.loads()将JSON字符串转换为Python字典

with open(file_path, 'a', encoding='utf-8') as file:  # 以追加模式打开文件，并写入JSON字符串

    output_txt = ""

    for key, value in data.items():

        output_txt += f'\"{key}\": \"{value}\",\n'

        print(f'\"{key}\": \"{value}\",')

    file.write(output_txt)  # 添加换行符以便每次追加时内容都在新一行

    print(f'JSON数据已追加写入到文件：{file_path}')

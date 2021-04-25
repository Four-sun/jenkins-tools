# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/4/25 11:12
# @Author : FanShu
# @Site : 
# @File : picture_file.py
# @Software: PyCharm
import shutil


list_han = [4991, 5001, 4948, 4972, 4972, 4976, 5003, 5007, 5011, 5020, 5043, 5051, 5070, 5073, 5077, 5102, 5121, 5122,
            5138, 5202,
            5210, 5228, 5261, 5267, 5278, 5301, 5306, 5309, 5331, 5348, 5384, 5406, 5468, 5460, 5428, 5419, 5512, 5536,
            5639, 5757, 5782,
            5895, 5897, 5900, 5927, 5718, 5862, 5868, 5934, 5799, 5818, 5831, 5841, 5847, 5848, 5853]

list_fanshu = [4923, 4931, 4945, 4948, 4969, 4972, 4992, 5102, 5121, 5122, 5132, 5138, 5003, 5008, 5011, 5020, 5043,
               5048, 5051, 5054, 5067, 5073, 5078, 5094, 5096, 5210, 5224, 5228, 5247, 5261, 5267, 5280, 5281, 5308,
               5309, 5326, 5328, 5331, 5348, 5384, 5406, 5428, 5419, 5460, 5465, 5468, 5471, 5477, 5491, 5512, 5536,
               5580, 5639, 5688, 5718, 5757, 5782, 5799, 5814, 5824, 5831, 5841, 5847, 5848, 5853, 5862, 5868, 5897,
               5900, 5918, 5926, 5934, 5939, 5944, 5967, 5969]


class picture(object):

    def __init__(self):
        self.file_path = "/Users/four/Documents/personal_information/marryFile/"
        self.common_picture_file = "/Users/four/Documents/personal_information/commonFIle/"
        self.fanshu_picture_file = "/Users/four/Documents/personal_information/fanshu/"
        self.han_picture_file = "/Users/four/Documents/personal_information/hanlaoshi/"

    def common_file(self):

        common_picture = list((set(list(list_fanshu)) & set(list(list_han))))
        common_picture.sort()
        print("%s张图片相同" % len(common_picture))
        return common_picture

    def fanshu_file(self):

        common_picture = list((set(list(list_fanshu)) - set(list(list_han))))
        common_picture.sort()
        print("%s番薯个人总共照片" % len(list_fanshu))
        print("%s番薯个人想法照片" % len(common_picture))
        print("%s番薯个人想法照片集合" % (common_picture))
        return common_picture

    def han_file(self):

        common_picture = list((set(list(list_han)) - set(list(list_fanshu))))
        common_picture.sort()
        print("%s韩老师个人总共照片" % len(list_han))
        print("%s韩老师个人想法照片" % len(common_picture))
        print("%s韩老师个人想法照片集合" % (common_picture))
        return common_picture

    def for_pic(self):
        common_picture = picture.han_file(self)
        print(common_picture)
        for i in range(len(common_picture)):
            file_name = "%s" % self.file_path + "DSC_%s.JPG" % common_picture[i]
            common_picture_name = "%s" % self.han_picture_file + "DSC_%s.JPG" % common_picture[i]
            shutil.copyfile(file_name, common_picture_name)
            print(file_name)


if __name__ == '__main__':
    picture().common_file()






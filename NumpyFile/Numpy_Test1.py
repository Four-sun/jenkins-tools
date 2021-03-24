"""
import numpy as np  # 导入NumPy工具包

data = np.arange(16).reshape(4, 4)

# print(type(data))

data1 = np.array([1, 2, 3])  # 创建一个一维数组
print(data1)

data2 = np.array([[1, 2], [3, 4]])  # 创建一个二位数组[[1 2][3 4]]
print(data2)

# 创建一个全为0的数组
date3 = np.zeros((5, 2), dtype=int)
# [[0 0]
#  [0 0]
#  [0 0]
#  [0 0]
#  [0 0]]

# date3 = np.zeros((5,),) #[0. 0. 0. 0. 0.]
print(date3)

# 创建全为1的数组
date4 = np.ones(4)  # [1. 1. 1. 1.]
date4 = np.ones((4, 2))
print(date4)

# 创建全空数组，其实每个值都接近于零的数
date5 = np.empty((3, 2))
print(
    date5
)

date6 = np.arange(1, 20, 2)  # 1-20 相加2的数组
print(date6)

date7 = np.array([1, 2, 3, 4, 5], float)  # 创建1-5数组，float类型
print(date7)

date8 = np.ones((2, 3), dtype='int')
print(date8)
# [[1 1 1]
# [1 1 1]]


# ndarry对象的数据类型

date_one = np.array([[1, 2, 3], [4, 5, 6]])
print(date_one.dtype)

# 转类型 astype
float_one = date_one.astype(np.float64)
print(float_one.dtype)

# float  转 int
float_data = np.array([1.2, 3.4, 5.2])
print(float_data)
int_date = float_data.astype(np.int64)
print(int_date)

# str  转 int
str_data = np.array(['2', '5', '6'])
print(str_data)
int_date1 = str_data.astype(np.int64)
print(int_date1)


# 数组运算

# 向量化运算

import numpy as np

#  数组相加 减 乘 除 （+ - * /）
date1 = np.array([[1, 2, 3], [4, 5, 6]])
date2 = np.array([[1, 2, 3], [4, 5, 6]])
date3 = date1 + date2
# print(date3)

# 数组广播
# 数组间基础的运算一对一关系，关系a.shape==b.shape，当两者不一样时候触发广播机制

arr1 = np.array([[0], [2], [4], [6]])
print(arr1)

arr2 = np.array([1, 2, 3])
print(arr2.shape)

arr3 = arr1 + arr2
print(arr3)

# 数组与标量之间的相加 减 乘 除

array1 = np.array([[10, 11, 12], [13, 14, 15]])
array2 = 10
print(array1 + array2)
# [[20 21 22]
#  [23 24 25]]

mask = np.array([1, 0, 1, 0, 0, 1], dtype=bool)
print(mask)
"""
# 数组的索引和切片
import numpy as np

sArr1 = np.arange(8)
print('一维all%s' % sArr1)
print("从二开始到最后，跳2 %s" % sArr1[2::2])
print('1-2 %s' % sArr1[1:2])
print('1-6 跳2 %s' % sArr1[1:6:2])

# 二位数组索引

arr2d = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
print('二位数组第1组 %s' % arr2d[1])

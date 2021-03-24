import numpy as np

data1 = np.array([1, 2, 3, 4])
print(data1)

date2 = np.array([[1, 2], [3, 4]])
date3 = np.array([[1, 2], [3, 4]])
date2 = date2.astype(np.str)
print(date2)

date4 = np.arange(1, 10, 1)
print(date4.dtype)

# 一对多的关系

aShip = np.array([[1], [2], [3], [4]])
bShip = np.array([1, 2, 3, 4])
cShip = aShip + bShip
print(cShip)




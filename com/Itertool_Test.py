import itertools

a = (0.9,0.1,0.2)
b = (100,200)
c = (0.1,0.01)
d = (3,)
e = (1,)
f = (0.1,0.2,0.9)
g = (0.8,)
h = (0.1,)
# point = itertools.product(a, b, c, d, e)
point = itertools.product(a, b, c, d, e, f, g, h)
number = 0
for i in point:
    print(i, end=",")
    number += 1
print('\t')
print(number)


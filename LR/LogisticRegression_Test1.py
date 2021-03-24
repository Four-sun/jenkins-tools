# 导入LogisticRegression方法
from sklearn.linear_model import LogisticRegression
# 导入数据生成器
from sklearn.datasets.samples_generator import make_blobs
# 生成2维数据，类别是2类
X, y = make_blobs(n_samples=100, centers=2, n_features=2, random_state=1)
# 训练模型
model = LogisticRegression()
model.fit(X, y)

# 生成新的预测数据集，有3个实例。这里的新实例可以为1个或多个
Xnew, _ = make_blobs(n_samples=3, centers=2, n_features=2, random_state=1)
# 开始预测
ynew = model.predict(Xnew)
# 展示类别的预测结果
print('预测类别：')
for i in range(len(Xnew)):
    print("X=%s, Predicted=%s" % (Xnew[i], ynew[i]))
# 展示数据集真实类别
print('真实类别：')
for i in range(len(Xnew)):
    print("X=%s, Predicted=%s" % (Xnew[i], _[i]))
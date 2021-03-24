# 概率预测案例
from sklearn.linear_model import LogisticRegression
from sklearn.datasets.samples_generator import make_blobs
# 生成数据集，有100个实列即100行，目标类别有2个:(0,1)
X, y = make_blobs(n_samples=100, centers=2, n_features=2, random_state=1)
# 训练模型
model = LogisticRegression()
model.fit(X, y)

# 生成新的预测集，有3个实例即3行
Xnew, _ = make_blobs(n_samples=3, centers=2, n_features=2, random_state=1)
# 开始预测
ynew = model.predict_proba(Xnew)
# 展示预测的类别概率，分别生成为0的概率和为1的概率
print('预测的类别概率：')
for i in range(len(Xnew)):
	print("X=%s, Predicted=%s" % (Xnew[i], ynew[i]))
print('真实类别：')
for i in range(len(Xnew)):
	print("X=%s, Predicted=%s" % (Xnew[i], _[i]))
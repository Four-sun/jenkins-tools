insert into science_task_template (`task_type`, `type`, `task_desc`, `content`)
values (6, 1, '简单的线性回归模型，用于预测波士顿房价', '#name LR
#type Python
#author admin@dtstack.com
#create time 2020-08-24 16:38:56
#coding=utf-8
#模型部署函数：save_python_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

import pandas as pd
from sklearn import linear_model
from sklearn.datasets import load_iris

# 建模
iris = load_iris()
x = pd.DataFrame(iris.data, columns=iris.feature_names)
y = iris.target

lr = linear_model.LinearRegression()
lr.fit(x[[''sepal length (cm)'', ''sepal width (cm)'', ''petal length (cm)'']], y)

class TestModel:
    def __init__(self, model, col):
        self.model = model
        self.col = col

    def predict(self, data: pd.DataFrame):
        return self.model.predict(data[self.col])

my_model = TestModel(model=lr, col=[''sepal length (cm)'', ''sepal width (cm)'', ''petal length (cm)''])

# 保存模型
from aiworks_plugins.hdfs_plugins import save_python_model_to_hdfs
save_python_model_to_hdfs(my_model)'),

       (6, 2, '随机森林模型，用于预测波士顿房价', '#name RandomForest
#type Python
#author admin@dtstack.com
#create time 2020-08-27 11:41:57
#coding=utf-8
#模型部署函数：save_python_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.datasets import load_iris

# 建模
iris = load_iris()
x = pd.DataFrame(iris.data, columns=iris.feature_names)
y = iris.target

rf = RandomForestRegressor()
rf.fit(x[[''sepal length (cm)'', ''sepal width (cm)'', ''petal length (cm)'']], y)

class TestModel:
    def __init__(self, model, col):
        self.model = model
        self.col = col

    def predict(self, data: pd.DataFrame):
        return self.model.predict(data[self.col])

my_model = TestModel(model=rf, col=[''sepal length (cm)'', ''sepal width (cm)'', ''petal length (cm)''])

# 保存模型
from aiworks_plugins.hdfs_plugins import save_python_model_to_hdfs
save_python_model_to_hdfs(my_model)
'),

       (6, 3, '支持向量机模型，用于识别手写数字', '#name SVM
#type Python
#author admin@dtstack.com
#create time 2020-08-27 12:05:57
#coding=utf-8
#模型部署函数：save_python_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

import pandas as pd
from sklearn.svm import LinearSVC
from sklearn.datasets import load_digits

# 建模
digits = load_digits()
x = pd.DataFrame(digits.data, columns=[str(i) for i in range(digits.data.shape[1])])
y = digits.target

svc = LinearSVC()
svc.fit(x, y)

class TestModel:
    def __init__(self, model, col):
        self.model = model
        self.col = col

    def predict(self, data: pd.DataFrame):
        return self.model.predict(data[self.col])

my_model = TestModel(model=svc, col=[str(i) for i in range(digits.data.shape[1])])

# 保存模型
from aiworks_plugins.hdfs_plugins import save_python_model_to_hdfs
save_python_model_to_hdfs(my_model)'),

       (23, 4, '基于keras构建的两层全连接网络，用于识别手写数字', '#name keras_number
#type Keras
#author admin@dtstack.com
#create time 2020-08-27 14:13:27
#coding=utf-8
#模型部署函数：save_keras_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

from sklearn import datasets
from keras import models
from keras import layers
from keras.utils import to_categorical

digits = datasets.load_digits()
n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))

train_images = data[:n_samples // 2]
train_images = train_images.astype(''float32'') / 255

test_images = data[n_samples // 2:]
test_images = test_images.astype(''float32'') / 255

train_labels = to_categorical(digits.target[:n_samples // 2])

test_labels = to_categorical(digits.target[n_samples // 2:])
network = models.Sequential()
network.add(layers.Dense(35, activation=''relu'', input_shape=(8 * 8,)))
network.add(layers.Dense(10, activation=''softmax''))
network.compile(optimizer=''rmsprop'', loss=''categorical_crossentropy'', metrics=[''accuracy''])
network.fit(train_images, train_labels, epochs=300, batch_size=100,verbose=0)

# 模型结果输出
from aiworks_plugins.tf_plugins import save_keras_model_to_hdfs
save_keras_model_to_hdfs(network)'),

       (6, 5, 'k均值聚类', '#name kmeans
#type Python
#author admin@dtstack.com
#create time 2020-08-27 14:18:01
#coding=utf-8
#模型部署函数：save_python_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

import pandas as pd
from sklearn.cluster import KMeans
from sklearn.datasets import load_iris

# 建模
iris = load_iris()
x = pd.DataFrame(iris.data, columns=iris.feature_names)

kmeans = KMeans(n_clusters=3)
kmeans.fit(x)

class TestModel:
    def __init__(self, model, col):
        self.model = model
        self.col = col

    def predict(self, data: pd.DataFrame):
        return self.model.predict(data[self.col])

my_model = TestModel(model=kmeans, col=iris.feature_names)

# 保存模型
from aiworks_plugins.hdfs_plugins import save_python_model_to_hdfs
save_python_model_to_hdfs(my_model)'),

(22, 6, '自定义TF模型，用于解决乳腺癌数据集', '#name TensorFlow
#type TensorFlow 1.x
#author admin@dtstack.com
#create time 2020-08-27 14:36:16
#coding=utf-8
#模型部署函数：save_tf_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
#desc

import tensorflow as tf
from sklearn.datasets import load_breast_cancer

tf.reset_default_graph()

bc = load_breast_cancer()

x = tf.placeholder(tf.float32, [None, 30], name="x")
y = tf.placeholder(tf.int32, [None], name="y")
out = tf.layers.dense(x, 32, activation=tf.nn.relu)
out = tf.layers.dense(out, 32, activation=tf.nn.relu)
logits = tf.layers.dense(out, 2)
out = tf.nn.softmax(logits)
out = tf.argmax(out, axis=1, name="output")

loss = tf.losses.sparse_softmax_cross_entropy(y, logits)
loss = tf.identity(loss, "loss")

optimizer = tf.train.AdamOptimizer(0.0001).minimize(loss)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for i in range(1000):
    sess.run([optimizer], feed_dict={x: bc.data, y: bc.target})

from aiworks_plugins.tf_plugins import save_tf_model_to_hdfs

save_tf_model_to_hdfs(sess, ["output", "loss"])'),


(3, 7, '自定义pyspark模型，用于iris数据集的GBDT模型', '#name pyspark
#type PySpark
#author admin@dtstack.com
#create time 2020-08-27 14:37:38
#coding=utf-8
#模型保存函数：save_pyspark_model_to_hdfs()，将模型保存后进行在线部署，在函数中定义相关函数即可，具体方法可查看帮助文档
#desc

from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession, DataFrame
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import GBTClassifier
from sklearn.datasets import load_iris
import pandas as pd

# spark session 初始化
conf = SparkConf().setAppName("pyspark_test")
sc = SparkContext(conf=conf)
spark = SparkSession.builder.config(conf=conf).enableHiveSupport().getOrCreate()

# 训练数据
iris = load_iris()
col = iris.feature_names
label = ''label''
data = pd.DataFrame(iris.data, columns=col)
data[label] = iris.target
data[label] = data[label].map(lambda x: 1 if x > 1 else 0)

# 转为pyspark的dataframe
data = spark.createDataFrame(data)
# 转为向量形式
vecAssembler = VectorAssembler(inputCols=col, outputCol="features")
train_data = vecAssembler.transform(data).select([''features'', label])

# 定义模型并训练
gbdt = GBTClassifier(featuresCol=''features'',
                     labelCol=label)
gbdt_model = gbdt.fit(train_data)


class TestModel:
    def __init__(self, model, col):
        self.model = model
        self.col = col
        # 下面一行不可缺少
        self.__estimator__ = str(model.__class__).split(''.'')[-1].split("""''""")[0]

    def predict(self, data: DataFrame):

        from pyspark.ml.feature import VectorAssembler
        vecAssembler = VectorAssembler(inputCols=self.col,
                                       outputCol="features")
        test_data = vecAssembler.transform(data).select([''features''])

        df_res = self.model.transform(test_data).select(''prediction'').toPandas()
        return df_res



model = TestModel(model=gbdt_model,
                  col=[''sepal length (cm)'', ''sepal width (cm)'',
                       ''petal length (cm)'', ''petal width (cm)''])

from aiworks_plugins.hdfs_plugins import save_pyspark_model_to_hdfs

save_pyspark_model_to_hdfs(model,sc)');
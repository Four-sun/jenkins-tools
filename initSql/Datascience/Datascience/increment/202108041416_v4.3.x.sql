-- v4.3.1 修改 python,pyspark 代码注释，增加 pipeline 部署函数提示

update science_task_template
set content = '#name pyspark
#type PySpark
#author admin@dtstack.com
#create time 2020-08-27 14:37:38
#coding=utf-8
#单个模型保存函数：save_pyspark_model_to_hdfs(model_name)，pipeline保存函数：save_pyspark_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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

save_pyspark_model_to_hdfs(model,sc, model_name="pyspark")'
where type = 7;

update science_task_template
set content = '#name LR
#type Python
#author admin@dtstack.com
#create time 2020-08-24 16:38:56
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="LR")'
where type = 1;


update science_task_template
set content = '#name RandomForest
#type Python
#author admin@dtstack.com
#create time 2020-08-27 11:41:57
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="RandomForest")'
where type = 2;


update science_task_template
set content = '#name SVM
#type Python
#author admin@dtstack.com
#create time 2020-08-27 12:05:57
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="SVM")'
where type = 3;


update science_task_template
set content = '#name kmeans
#type Python
#author admin@dtstack.com
#create time 2020-08-27 14:18:01
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="kmeans")'
where type = 5;


update science_task
set sql_text = '#name pyspark
#type PySpark
#author admin@dtstack.com
#create time 2020-08-27 14:37:38
#coding=utf-8
#单个模型保存函数：save_pyspark_model_to_hdfs(model_name)，pipeline保存函数：save_pyspark_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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

save_pyspark_model_to_hdfs(model,sc, model_name="pyspark")'
where name = 'pyspark' and is_deleted=0 and task_type = 3;


update science_task
set sql_text = '#name LR
#type Python
#author admin@dtstack.com
#create time 2020-08-24 16:38:56
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="LR")'
where name = 'LR' and is_deleted=0 and task_type = 6;


update science_task
set sql_text = '#name RandomForest
#type Python
#author admin@dtstack.com
#create time 2020-08-27 11:41:57
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="RandomForest")'
where name = 'RandomForest' and is_deleted=0 and task_type = 6;


update science_task
set sql_text = '#name SVM
#type Python
#author admin@dtstack.com
#create time 2020-08-27 12:05:57
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="SVM")'
where name = 'SVM' and is_deleted=0 and task_type = 6;


update science_task
set sql_text = '#name kmeans
#type Python
#author admin@dtstack.com
#create time 2020-08-27 14:18:01
#coding=utf-8
#单个模型保存函数：save_python_model_to_hdfs(model_name)，pipeline保存函数：save_python_pipeline_to_hdfs(model_name)，将模型保存后进行在线部署，在函数中定义相关内容即
#可，具体方法可查看帮助文档
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
save_python_model_to_hdfs(my_model, model_name="kmeans")'
where name = 'kmeans' and is_deleted=0 and task_type = 6;







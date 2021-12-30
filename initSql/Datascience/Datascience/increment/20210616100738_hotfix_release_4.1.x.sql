update science_task
set sql_text = '#name pyspark
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

save_pyspark_model_to_hdfs(model,sc)'
where name = 'pyspark' and is_deleted=0 and task_type = 3;

update science_task_template
set content = '#name pyspark
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

save_pyspark_model_to_hdfs(model,sc)'
where type = 7;

ALTER TABLE science_model_version MODIFY COLUMN model_file varchar(255) default null comment '模型文件路径';
ALTER TABLE science_model_version MODIFY COLUMN file_size int(11) default 0 comment '模型文件大小';

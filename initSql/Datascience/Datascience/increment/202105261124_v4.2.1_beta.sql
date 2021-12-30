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

save_pyspark_model_to_hdfs(model,sc, model_name="pyspark")'
where name = 'pyspark' and is_deleted=0 and task_type = 3;

INSERT INTO science_task (`tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`)
select `tenant_id`, `project_id`, `node_pid`, 'PyTorch', 25, 3, `compute_type`,
       '# name PyTorch
#type PyTorch
# author admin@dtstack.com
# create time 2020-08-27 14:37:38
# coding=utf-8
# 模型部署函数：save_torch_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
# desc

from sklearn.datasets import load_breast_cancer
import numpy as np
import torch

bc = load_breast_cancer()

data = torch.from_numpy(bc.data)
data = data.to(torch.float32)
label = torch.from_numpy(bc.target)
label = label.to(torch.long)


def get_fit_data(batch, dataset, label):
    for i in range(int(np.floor(len(dataset) / batch))):
        if (i + 1) * batch < len(dataset):
            yield (dataset[i * batch: (i + 1) * batch], label[i * batch: (i + 1) * batch])
        else:
            yield (dataset[i * batch:], label[i * batch:])


model = torch.nn.Sequential(torch.nn.BatchNorm1d(num_features=30),
                            torch.nn.Linear(in_features=30, out_features=32),
                            torch.nn.ReLU(),
                            torch.nn.Linear(in_features=32, out_features=2),
                            torch.nn.Softmax()
                            )

loss_func = torch.nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(params=model.parameters(), lr=0.1)

epochs = 50
for epoch in range(1, epochs + 1):

    model.train()
    loss_sum = 0.0
    metric_sum = 0.0
    step = 1
    batch = 50

    get_data = get_fit_data(batch, data, label)

    for train_data, train_label in get_data:
        # 正向传播求损失
        predictions = model(train_data)
        loss = loss_func(predictions, train_label)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

from aiworks_plugins.tf_plugins import save_torch_model_to_hdfs

save_torch_model_to_hdfs(model, data[:1], model_name=''torch_model'')',
       '## 每个worker所占内存，比如512m
worker.memory=1024m

## worker的数量
worker.num=1

## 每个worker所占的cpu核的数量
worker.cores=1

## 任务优先级, 值越小，优先级越高，范围:1-1000
job.priority=10', `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, '自定义pytorch模型，用于乳腺癌数据集中预测得病概率', `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`
from science_task where name = 'LR' and is_deleted=0;


INSERT INTO science_task_template(id, task_type, `type`, task_desc, content, gmt_create, gmt_modified, is_deleted)
VALUES (14, 25, 8,
        '自定义pytorch模型，用于乳腺癌数据集中预测得病概率',
        '# name PyTorch
# type PyTorch
# author admin@dtstack.com
# create time 2020-08-27 14:37:38
# coding=utf-8
# 模型部署函数：save_torch_model_to_hdfs()，可进行模型的在线部署，在该函数中定义模型相关内容即可，具体方法可查看帮助文档
# desc

from sklearn.datasets import load_breast_cancer
import numpy as np
import torch

bc = load_breast_cancer()

data = torch.from_numpy(bc.data)
data = data.to(torch.float32)
label = torch.from_numpy(bc.target)
label = label.to(torch.long)


def get_fit_data(batch, dataset, label):
    for i in range(int(np.floor(len(dataset) / batch))):
        if (i + 1) * batch < len(dataset):
            yield (dataset[i * batch: (i + 1) * batch], label[i * batch: (i + 1) * batch])
        else:
            yield (dataset[i * batch:], label[i * batch:])


model = torch.nn.Sequential(torch.nn.BatchNorm1d(num_features=30),
                            torch.nn.Linear(in_features=30, out_features=32),
                            torch.nn.ReLU(),
                            torch.nn.Linear(in_features=32, out_features=2),
                            torch.nn.Softmax()
                            )

loss_func = torch.nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(params=model.parameters(), lr=0.1)

epochs = 50
for epoch in range(1, epochs + 1):

    model.train()
    loss_sum = 0.0
    metric_sum = 0.0
    step = 1
    batch = 50

    get_data = get_fit_data(batch, data, label)

    for train_data, train_label in get_data:
        # 正向传播求损失
        predictions = model(train_data)
        loss = loss_func(predictions, train_label)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

from aiworks_plugins.tf_plugins import save_torch_model_to_hdfs

save_torch_model_to_hdfs(model, data[:1], model_name=''torch_model'')',
        '2020-08-27 16:23:54', '2020-08-27 16:23:54', 0);

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

save_pyspark_model_to_hdfs(model,sc, model_name="pyspark")'
where type = 7;
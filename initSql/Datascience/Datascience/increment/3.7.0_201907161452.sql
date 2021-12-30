-- 增加资源管理模块
INSERT INTO `science_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`,
                           `gmt_modified`, `is_deleted`)
VALUES ('12', 'Resource', '5', '资源管理', 'resource', '5', now(), now(), '0'),
       ('13', 'Resource', '5', '资源管理', 'resource', '1', now(), now(), '0')
on duplicate key update gmt_create=values(gmt_create);

insert into science_catalogue
(node_name, tenant_id, project_id, node_pid, order_val, level, gmt_create, gmt_modified, create_user_id, is_deleted)
select '资源管理',
       tenant_id,
       project_id,
       node_pid,
       5,
       level,
       gmt_create,
       gmt_modified,
       create_user_id,
       is_deleted
from science_catalogue
where node_name = 'Notebook'
  and node_pid = 0
  and is_deleted = 0
GROUP BY project_id;

insert into science_catalogue
(node_name, tenant_id, project_id, order_val, level, gmt_create, gmt_modified, create_user_id, is_deleted, node_pid)
select '资源管理',
       tenant_id,
       project_id,
       1,
       level + 1,
       gmt_create,
       gmt_modified,
       create_user_id,
       is_deleted,
       id
from science_catalogue
where node_name = '资源管理'
  and node_pid = 0
  and is_deleted = 0
GROUP BY project_id;



CREATE TABLE `science_resource`
(
    `id`               int(11)       NOT NULL AUTO_INCREMENT,
    `tenant_id`        int(11)       NOT NULL COMMENT '租户id',
    `project_id`       int(11)       NOT NULL COMMENT '项目id',
    `node_pid`         int(11)       NOT NULL COMMENT '父文件夹id',
    `url`              varchar(1028) NOT NULL COMMENT '资源路径',
    `resource_type`    tinyint(1)    NOT NULL DEFAULT '1' COMMENT '资源类型 1,jar 2 shell,3:py',
    `resource_name`    varchar(256)  NOT NULL COMMENT '资源名称',
    `origin_file_name` varchar(256)  NOT NULL COMMENT '源文件名',
    `resource_desc`    varchar(256)  NOT NULL COMMENT '源文描述',
    `target_id`        int(11) COMMENT '发布Id',
    `gmt_create`       datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`     datetime      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_user_id`   int(11)       NOT NULL COMMENT '新建资源的用户',
    `modify_user_id`   int(11)       NOT NULL COMMENT '修改人',
    `is_deleted`       tinyint(1)    NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    KEY `index_resource_name` (`project_id`, `resource_name`(128)),
    KEY `index_resource_type` (`resource_type`, `is_deleted`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 15
  DEFAULT CHARSET = utf8;


CREATE TABLE `science_task_resource`
(
    `id`            int(11)    NOT NULL AUTO_INCREMENT,
    `task_id`       int(11)    NOT NULL COMMENT 'batch 任务id',
    `resource_id`   int(11)             DEFAULT NULL COMMENT '对应batch资源的id',
    `resource_type` int(11) COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
    `project_id`    int(11)    NOT NULL COMMENT '项目id',
    `tenant_id`     int(11)    NOT NULL COMMENT '租户id',
    `gmt_create`    datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`    tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `index_project_task_resource_id` (`project_id`, `task_id`, `resource_id`, `resource_type`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


-- 更新notebook任务类型为python
update science_task
set task_type = 6
where task_type = 13;


-- 更新notebook模版文件
update science_task_template
set content = '#name kmeans
#type Python3
#author admin@dtstack.com
#create time 2019-05-10 09:50:30
#desc
from time import time
import numpy as np

from sklearn.cluster import KMeans
from sklearn.datasets import load_digits
from sklearn.preprocessing import scale

np.random.seed(42)
digits = load_digits()
data = scale(digits.data)

n_samples, n_features = data.shape
n_digits = len(np.unique(digits.target))
labels = digits.target

sample_size = 300
n_clusters = 5
km = KMeans(n_clusters=n_clusters)
km.fit(data)


# 模型结果输出

from pyhdfs import HdfsClient
import os
from sklearn.externals import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = localPath +''/model.pkl''
remote_file_name= remotePath + ''/model.pkl''
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(km,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where type = 5;

update science_task_template
set content = '#name keras_number
#type Python3
#author admin@dtstack.com
#create time 2019-05-10 09:52:35
#desc
from sklearn import datasets
from keras import models
from keras import layers

digits = datasets.load_digits()
n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))

train_images = data[:n_samples // 2]
train_images = train_images.astype(''float32'') / 255

test_images = data[n_samples // 2:]
test_images = test_images.astype(''float32'') / 255

from keras.utils import to_categorical

train_labels = to_categorical(digits.target[:n_samples // 2])

test_labels = to_categorical(digits.target[n_samples // 2:])
network = models.Sequential()
network.add(layers.Dense(35, activation=''relu'', input_shape=(8 * 8,)))
network.add(layers.Dense(10, activation=''softmax''))
network.compile(optimizer=''rmsprop'', loss=''categorical_crossentropy'', metrics=[''accuracy''])

network.fit(train_images, train_labels, epochs=900, batch_size=50)

test_loss, test_acc = network.evaluate(test_images, test_labels)
print(''test_acc:'', test_acc)
print (network.predict(train_images))

# 模型结果输出

from pyhdfs import HdfsClient
import os
from sklearn.externals import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = localPath +''/model.pkl''
remote_file_name= remotePath + ''/model.pkl''
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(network,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where type = 6;

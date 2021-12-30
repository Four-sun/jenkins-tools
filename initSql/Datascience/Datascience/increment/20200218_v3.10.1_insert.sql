-- 允许项目表中的离线id为null
ALTER TABLE science_project MODIFY ref_project_id INT(11) null;
ALTER TABLE science_project MODIFY target_project_id INT(11) null;
ALTER TABLE science_project MODIFY ref_project_name varchar(26) null;

-- 项目引擎映射
insert into science_project_engine(id, project_id, tenant_id, engine_type, engine_identity, status, is_deleted)
select rpe.id, sp.id, sp.tenant_id, rpe.engine_type, rpe.engine_identity, rpe.status, rpe.is_deleted
from ide.rdos_project_engine rpe left join science_project sp on rpe.project_id = sp.ref_project_id WHERE sp.id is not null;

-- 数据源表
insert into science_data_source_aiworks(id, data_name, data_desc, data_json, type, active, link_state, tenant_id, project_id, create_user_id, modify_user_id, is_deleted, is_default)
select rbds.id, rbds.data_name, rbds.data_desc, rbds.data_json, rbds.type, rbds.active, rbds.link_state, sp.tenant_id, sp.id, sp.create_user_id, sp.create_user_id, rbds.is_deleted, rbds.is_default
from ide.rdos_batch_data_source rbds left join science_project sp on rbds.project_id = sp.ref_project_id where rbds.type = 7 and is_default = 1 and sp.id is not null;

-- hive数据表信息
insert IGNORE science_hive_table_info(id, project_id, tenant_id, table_name, table_type, table_desc, life_day, life_status, table_size, grade, subject, refresh_rate, incre_type, is_ignore, check_result, user_id, charge_user_id, modify_user_id, path, location, delim, store_type, catalogue_id, is_deleted, is_dirty_data_table)
select rhti.id, sp.id, st.id, rhti.table_name, rhti.table_type, rhti.table_desc, rhti.life_day, rhti.life_status, rhti.table_size, rhti.grade, rhti.subject, rhti.refresh_rate, rhti.incre_type,rhti.is_ignore, rhti.check_result, sp.create_user_id, sp.create_user_id, sp.create_user_id, rhti.path, rhti.location, rhti.delim, rhti.store_type, rhti.catalogue_id, rhti.is_deleted, rhti.is_dirty_data_table
from ide.rdos_hive_table_info rhti left join science_project sp on rhti.project_id = sp.ref_project_id LEFT JOIN science_tenant st on sp.tenant_id = st.id LEFT JOIN ide.rdos_tenant rrt on st.dtuic_tenant_id = rrt.dtuic_tenant_id  WHERE rhti.project_id <= (SELECT ref_project_id from science_project p ORDER BY p.ref_project_id desc limit 1) and sp.id is not null;

-- hive数据表分区
insert into science_hive_table_partition(id, project_id, tenant_id, table_id, `partition`, store_size, is_deleted)
select rbhtp.id, sp.id, sp.tenant_id, rbhtp.table_id, rbhtp.partition, rbhtp.store_size, rbhtp.is_deleted
from ide.rdos_batch_hive_table_partition rbhtp left join science_project sp on rbhtp.project_id = sp.ref_project_id where sp.id is not null;

-- hive数据表字段
insert into science_hive_table_column(id, project_id, tenant_id, table_id, column_name, column_type, column_desc, column_index, check_result, is_ignore, is_deleted)
select rbhtc.id, sp.id, sp.tenant_id, rbhtc.table_id, rbhtc.column_name, rbhtc.column_type, rbhtc.column_desc, rbhtc.column_index, rbhtc.check_result, rbhtc.is_ignore, rbhtc.is_deleted
from ide.rdos_batch_hive_table_column rbhtc left join science_project sp on rbhtc.project_id = sp.ref_project_id where sp.id is not null;

update science_task_template
set content = 'from sklearn import datasets
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
print(''start fitting.'')
network.fit(train_images, train_labels, epochs=300, batch_size=100,verbose=0)
print(''finish fitting.'')
test_loss, test_acc = network.evaluate(test_images, test_labels)
print(''test_acc:'', test_acc)
print (network.predict(train_images))'
where type = 6;

update science_task
set sql_text = 'from sklearn import datasets
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
print(''start fitting.'')
network.fit(train_images, train_labels, epochs=300, batch_size=100,verbose=0)
print(''finish fitting.'')
test_loss, test_acc = network.evaluate(test_images, test_labels)
print(''test_acc:'', test_acc)
print (network.predict(train_images))'
where name = 'kmeans';

update science_task_template
set content = 'import numpy as np
from sklearn.utils import shuffle
from sklearn import datasets, linear_model
from sklearn.metrics import mean_absolute_error, r2_score
# #############################################################################
# Load data
boston = datasets.load_boston()
X, y = shuffle(boston.data, boston.target*1000, random_state=13)
X = X.astype(np.float32)
offset = int(X.shape[0] * 0.9)
X_train, y_train = X[:offset], y[:offset]
X_test, y_test = X[offset:], y[offset:]

regr = linear_model.LinearRegression()

regr.fit(X_train, y_train)

# Make predictions using the testing set
y_pred = regr.predict(X_test)
#结果
print("LR模型结果输出")
MAE = round(mean_absolute_error(y_test,y_pred),4)
print("MAE:", MAE)
r2 = round(r2_score(y_test,y_pred),4)
print("R2:", r2)

# LR模型结果输出
# MAE: 2797.5312
# R2: 0.717
from pyhdfs import HdfsClient
import os
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = localPath +''/model.pkl''
remote_file_name= remotePath + ''/model.pkl''
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(regr,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where type = 1;

update science_task
set sql_text = 'import numpy as np
from sklearn.utils import shuffle
from sklearn import datasets, linear_model
from sklearn.metrics import mean_absolute_error, r2_score
# #############################################################################
# Load data
boston = datasets.load_boston()
X, y = shuffle(boston.data, boston.target*1000, random_state=13)
X = X.astype(np.float32)
offset = int(X.shape[0] * 0.9)
X_train, y_train = X[:offset], y[:offset]
X_test, y_test = X[offset:], y[offset:]

regr = linear_model.LinearRegression()

regr.fit(X_train, y_train)

# Make predictions using the testing set
y_pred = regr.predict(X_test)
#结果
print("LR模型结果输出")
MAE = round(mean_absolute_error(y_test,y_pred),4)
print("MAE:", MAE)
r2 = round(r2_score(y_test,y_pred),4)
print("R2:", r2)

# LR模型结果输出
# MAE: 2797.5312
# R2: 0.717
from pyhdfs import HdfsClient
import os
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = localPath +''/model.pkl''
remote_file_name= remotePath + ''/model.pkl''
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(regr,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where name = 'LR';



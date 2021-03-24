import os
from tensorflow import keras
from tensorflow.keras.layers import Dense
from sklearn.datasets import load_breast_cancer
# from aiworks_plugins.tf_plugins import save_keras_model_to_hdfs


model = keras.Sequential()
model.add(Dense(units=32, activation='relu', input_dim=30))
model.add(Dense(units=32, activation='relu'))
model.add(Dense(units=2))
model.compile(loss=keras.losses.sparse_categorical_crossentropy,
              optimizer=keras.optimizers.Adam(lr=0.0001))

bc = load_breast_cancer()

model.fit(bc.data, bc.target, epochs=100, batch_size=32)


# 保存模型到hdfs
# 本地缓存路径
localPath = '${bdp.system.localPath}/${bdp.system.cyctime}'
local_file_name = os.path.join(localPath, "model.h5")
# hdfs路径
remotePath = '${bdp.system.remotePath}${bdp.system.cyctime}'
remote_file_name = os.path.join(remotePath, "model.h5")
# hdfs hosts
hosts = '${bdp.system.hdfsServer}'
user_name = "${bdp.system.hadoopUserName}"

save_keras_model_to_hdfs(model, local_file_name, remote_file_name, hosts, user_name)




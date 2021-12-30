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
local_file_name = os.path.join(localPath, "model.pkl")
remote_file_name= os.path.join(remotePath, "model.pkl")
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(regr,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where id = 1;

update science_task_template
set content = '#name RandomForest
#type Python3
#author admin@dtstack.com
#create time 2019-05-10 09:51:40
#desc
import numpy as np
from sklearn import datasets
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, r2_score
from sklearn.utils import shuffle
# #############################################################################
# Load data
boston = datasets.load_boston()
X, y = shuffle(boston.data, boston.target*1000, random_state=13)
X = X.astype(np.float32)
offset = int(X.shape[0] * 0.9)
X_train, y_train = X[:offset], y[:offset]
X_test, y_test = X[offset:], y[offset:]

#模型参数
max_depth = 30
regr_rf = RandomForestRegressor(n_estimators=100, max_depth=max_depth,
                                random_state=2)

regr_rf.fit(X_train, y_train)
y_rf = regr_rf.predict(X_test)

#结果
print("随机森林模型结果输出")
MAE = round(mean_absolute_error(y_test,y_rf),4)
print("MAE:", MAE)
r2 = round(r2_score(y_test,y_rf),4)
print("R2:", r2)

# 随机森林模型结果输出
# MAE: 1879.7255
# R2: 0.8788


# append code
from pyhdfs import HdfsClient
import os
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = os.path.join(localPath, "model.pkl")
remote_file_name= os.path.join(remotePath, "model.pkl")
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(regr_rf,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where id = 2;

update science_task_template
set content = '#name SVM
#type Python3
#author admin@dtstack.com
#create time 2019-05-10 09:51:16
#desc
print(__doc__)

# Author: Gael Varoquaux <gael dot varoquaux at normalesup dot org>
# License: BSD 3 clause

# Standard scientific Python imports

# Import datasets, classifiers and performance metrics
from sklearn import datasets, svm, metrics

# The digits dataset
digits = datasets.load_digits()
print(digits.target)
import numpy as np


n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))
print(data[0])
print(digits.images[0])
print(n_samples)
# Create a classifier: a support vector classifier
classifier = svm.SVC(kernel=''rbf'', gamma=0.001)

# We learn the digits on the first half of the digits
classifier.fit(data[:n_samples // 2], digits.target[:n_samples // 2])

# Now predict the value of the digit on the second half:
expected = digits.target[n_samples // 2:]
predicted = classifier.predict(data[n_samples // 2:])

print("Classification report for classifier %s:\n%s\n"
      % (classifier, metrics.classification_report(expected, predicted)))
print("Confusion matrix:\n%s" % metrics.confusion_matrix(expected, predicted))

# append code
from pyhdfs import HdfsClient
import os
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''/home/admin/app/dt-center-dataScience/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = os.path.join(localPath, "model.pkl")
remote_file_name= os.path.join(remotePath, "model.pkl")
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(classifier,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where id = 3;

update science_task_template
set content = '#name dbscan
#type Python3
#author admin@dtstack.com
#create time 2019-05-10 09:50:08
#desc
import numpy as np

from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn.datasets.samples_generator import make_blobs
from sklearn.preprocessing import StandardScaler


# #############################################################################
# Generate sample data
centers = [[1, 1], [-1, -1], [1, -1]]
X, labels_true = make_blobs(n_samples=750, centers=centers, cluster_std=0.4,
                            random_state=0)

X = StandardScaler().fit_transform(X)

# #############################################################################
# Compute DBSCAN
db = DBSCAN(eps=0.3, min_samples=10).fit(X)
core_samples_mask = np.zeros_like(db.labels_, dtype=bool)
core_samples_mask[db.core_sample_indices_] = True
labels = db.labels_

# Number of clusters in labels, ignoring noise if present.
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)

print(''Estimated number of clusters: %d'' % n_clusters_)
print(''Estimated number of noise points: %d'' % n_noise_)
print("Homogeneity: %0.3f" % metrics.homogeneity_score(labels_true, labels))
print("Completeness: %0.3f" % metrics.completeness_score(labels_true, labels))
print("V-measure: %0.3f" % metrics.v_measure_score(labels_true, labels))
print("Adjusted Rand Index: %0.3f"
      % metrics.adjusted_rand_score(labels_true, labels))
print("Adjusted Mutual Information: %0.3f"
      % metrics.adjusted_mutual_info_score(labels_true, labels))
print("Silhouette Coefficient: %0.3f"
      % metrics.silhouette_score(X, labels))'
where id = 4;

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
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = os.path.join(localPath, "model.pkl")
remote_file_name= os.path.join(remotePath, "model.pkl")
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(km,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where id = 5;

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
import joblib
fs = HdfsClient(hosts=''${bdp.system.hdfsServer}'')
localPath = ''${bdp.system.localPath}/${bdp.system.cyctime}''
remotePath =  ''${bdp.system.remotePath}${bdp.system.cyctime}''
local_file_name = os.path.join(localPath, "model.pkl")
remote_file_name= os.path.join(remotePath, "model.pkl")
os.makedirs(localPath, exist_ok=True)
fs.mkdirs(remotePath)
if "model.pkl" in os.listdir(localPath):
    os.remove(local_file_name)
joblib.dump(network,local_file_name)
fs.delete(remote_file_name)
fs.copy_from_local(localsrc=local_file_name, dest=remote_file_name)'
where id = 6;
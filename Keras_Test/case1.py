
import os
local_path = '/home/admin/app/dt-center-dataScience/upload'
cyc_time = 'yyyyMMddHHmmss'

# 保存模型到hdfs
# 本地缓存路径
localPath = "%s/%s" % (local_path, cyc_time)
local_file_name = os.path.join(localPath, "model.h5")
print(localPath)
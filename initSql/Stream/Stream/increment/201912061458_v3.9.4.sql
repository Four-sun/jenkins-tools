--  还需要运维同学下载 hdfs上 /rdos/stream 目录下的资源到 sftp组件配置的/data/sftp/stream/resource路径下
UPDATE rdos_stream_resource SET url=REPLACE(url,'hdfs://ns1/rdos/stream','/data/sftp/stream/resource');
UPDATE rdos_stream_resource SET url=REPLACE(url,'hdfs://ns1/dtInsight/stream','/data/sftp/stream/resource');

{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "groupId" : "default",
          "topic" : "fanshu2",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false
        },
        "name" : "kafkareader"
      },
      "writer" : {
        "parameter" : {
          "fileName" : "",
          "writeMode" : "append",
          "maxFileSize" : 10485760,
          "fieldDelimiter" : "\u0001",
          "partitionType" : "DAY",
          "path" : "hdfs://ns1/dtInsight/hive/warehouse/a",
          "tablesColumn" : "{\"a\":[{\"part\":false,\"comment\":\"\",\"type\":\"int\",\"key\":\"id\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"name\"}]}",
          "hadoopConfig" : {
            "dfs.ha.namenodes.ns1" : "nn1,nn2",
            "fs.defaultFS" : "hdfs://ns1",
            "dfs.namenode.rpc-address.ns1.nn2" : "172.16.21.253:9000",
            "dfs.client.failover.proxy.provider.ns1" : "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider",
            "dfs.namenode.rpc-address.ns1.nn1" : "172.16.20.255:9000",
            "dfs.nameservices" : "ns1",
            "fs.hdfs.impl.disable.cache" : "true",
            "fs.hdfs.impl" : "org.apache.hadoop.hdfs.DistributedFileSystem"
          },
          "jdbcUrl" : "jdbc:hive2://172.16.20.255:10004/default",
          "defaultFS" : "hdfs://ns1",
          "table" : "a",
          "fileType" : "orc",
          "charsetName" : "utf-8"
        },
        "name" : "hivewriter",
        "type" : 7
      }
    } ],
    "setting" : {
      "restore" : {
        "isRestore" : true,
        "isStream" : true
      },
      "errorLimit" : { },
      "speed" : {
        "readerChannel" : 1,
        "writerChannel" : 1,
        "bytes" : -1048576,
        "channel" : 1
      }
    }
  }
}

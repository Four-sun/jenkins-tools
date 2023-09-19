{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "port" : 3306,
          "cat" : "insert,update,delete",
          "host" : "172.16.100.186",
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/test",
          "start" : { },
          "pavingData" : true,
          "table" : [ "name" ],
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "schema" : "default",
          "fileName" : "",
          "writeMode" : "append",
          "maxFileSize" : 10485760,
          "fieldDelimiter" : "\u0001",
          "partitionType" : "DAY",
          "path" : "",
          "analyticalRules" : "stream_${schema}_${table}",
          "tablesColumn" : "{\"name\":[{\"part\":false,\"comment\":\"\",\"type\":\"BIGINT\",\"key\":\"before_id\"},{\"comment\":\"\",\"type\":\"BIGINT\",\"key\":\"after_id\",\"part\":false},{\"part\":false,\"precision\":255,\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"before_name\"},{\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"after_name\",\"part\":false,\"precision\":255},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"type\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"schema\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"table\"},{\"comment\":\"\",\"type\":\"bigint\",\"key\":\"ts\"}]}",
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

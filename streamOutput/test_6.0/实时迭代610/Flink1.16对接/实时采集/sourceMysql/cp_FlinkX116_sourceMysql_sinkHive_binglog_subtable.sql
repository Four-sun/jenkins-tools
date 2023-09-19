{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "port" : 3306,
          "cat" : "insert,update,delete",
          "host" : "172.16.100.186",
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/automation",
          "start" : { },
          "pavingData" : true,
          "table" : [ "stream_mysql_ogg_one" ],
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "schema" : "default",
          "fileName" : "pt",
          "writeMode" : "append",
          "maxFileSize" : 1048576,
          "fieldDelimiter" : "\u0001",
          "partitionType" : "DAY",
          "path" : "",
          "analyticalRules" : "stream_${schema}_${table}_fanshu001",
          "password" : "******",
          "tablesColumn" : "{\"stream_mysql_ogg_one\":[{\"part\":false,\"comment\":\"\",\"type\":\"INT\",\"key\":\"before_id\"},{\"comment\":\"\",\"type\":\"INT\",\"key\":\"after_id\",\"part\":false},{\"part\":false,\"precision\":255,\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"before_varchar_data\"},{\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"after_varchar_data\",\"part\":false,\"precision\":255},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"type\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"schema\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"table\"},{\"comment\":\"\",\"type\":\"bigint\",\"key\":\"ts\"}]}",
          "partition" : "pt",
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
          "fileType" : "text",
          "charsetName" : "utf-8",
          "username" : "admin"
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

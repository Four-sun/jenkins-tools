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
          "start" : {
          },
          "pavingData" : true,
          "table" : [ "stream_mysql_ogg_one", "stream_mysql_ogg_two" ],
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
          "analyticalRules" : "stream_${schema}_${table}_dtstack",
          "password" : "******",
          "tablesColumn" : "{\"stream_two\":[{\"part\":false,\"comment\":\"\",\"type\":\"INT\",\"key\":\"before_id\"},{\"comment\":\"\",\"type\":\"INT\",\"key\":\"after_id\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"TINYINT\",\"key\":\"before_boolean_data\"},{\"comment\":\"\",\"type\":\"TINYINT\",\"key\":\"after_boolean_data\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"TINYINT\",\"key\":\"before_tinyint_data\"},{\"comment\":\"\",\"type\":\"TINYINT\",\"key\":\"after_tinyint_data\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"INT\",\"key\":\"before_int_data\"},{\"comment\":\"\",\"type\":\"INT\",\"key\":\"after_int_data\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"BIGINT\",\"key\":\"before_bigint_data\"},{\"comment\":\"\",\"type\":\"BIGINT\",\"key\":\"after_bigint_data\",\"part\":false},{\"part\":false,\"precision\":10,\"scale\":0,\"comment\":\"\",\"type\":\"decimal(10,0)\",\"key\":\"before_decimal_data\"},{\"part\":false,\"precision\":10,\"scale\":0,\"comment\":\"\",\"type\":\"decimal(10,0)\",\"key\":\"after_decimal_data\"},{\"part\":false,\"precision\":22,\"scale\":31,\"comment\":\"\",\"type\":\"DOUBLE\",\"key\":\"before_double_data\"},{\"part\":false,\"precision\":22,\"scale\":31,\"comment\":\"\",\"type\":\"DOUBLE\",\"key\":\"after_double_data\"},{\"part\":false,\"precision\":1,\"comment\":\"\",\"type\":\"CHAR\",\"key\":\"before_char_data\"},{\"comment\":\"\",\"type\":\"CHAR\",\"key\":\"after_char_data\",\"part\":false,\"precision\":1},{\"part\":false,\"precision\":255,\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"before_varchar_data\"},{\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"after_varchar_data\",\"part\":false,\"precision\":255},{\"part\":false,\"comment\":\"\",\"type\":\"DATE\",\"key\":\"before_date_data\"},{\"comment\":\"\",\"type\":\"DATE\",\"key\":\"after_date_data\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"TIME\",\"key\":\"before_time_data\"},{\"comment\":\"\",\"type\":\"TIME\",\"key\":\"after_time_data\",\"part\":false},{\"part\":false,\"comment\":\"\",\"type\":\"TIMESTAMP\",\"key\":\"before_timestamp_data\"},{\"comment\":\"\",\"type\":\"TIMESTAMP\",\"key\":\"after_timestamp_data\",\"part\":false},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"type\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"schema\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"table\"},{\"comment\":\"\",\"type\":\"bigint\",\"key\":\"ts\"}],\"stream_one\":[{\"part\":false,\"comment\":\"\",\"type\":\"INT\",\"key\":\"before_id\"},{\"comment\":\"\",\"type\":\"INT\",\"key\":\"after_id\",\"part\":false},{\"part\":false,\"precision\":255,\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"before_varchar_data\"},{\"comment\":\"\",\"type\":\"VARCHAR(255) \",\"key\":\"after_varchar_data\",\"part\":false,\"precision\":255},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"type\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"schema\"},{\"comment\":\"\",\"type\":\"varchar\",\"key\":\"table\"},{\"comment\":\"\",\"type\":\"bigint\",\"key\":\"ts\"}]}",
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
          "distributeTable" : "{\"stream_two\":[\"stream_mysql_ogg_two\"],\"stream_one\":[\"stream_mysql_ogg_one\"]}",
          "fileType" : "orc",
          "charsetName" : "utf-8",
          "username" : ""
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
      "errorLimit" : {
      },
      "speed" : {
        "readerChannel" : 1,
        "writerChannel" : 1,
        "bytes" : -1048576,
        "channel" : 1
      }
    }
  }
}

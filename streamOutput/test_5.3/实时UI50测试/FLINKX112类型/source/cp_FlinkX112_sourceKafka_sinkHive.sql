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
          "fileName" : "pt",
          "writeMode" : "append",
          "maxFileSize" : 10485760,
          "fieldDelimiter" : "\u0001",
          "partitionType" : "DAY",
          "path" : "hdfs://ns1/dtInsight/hive/warehouse/stream_default_4tablejoin_resulttable1_dtstack_fanshu",
          "password" : "******",
          "tablesColumn" : "{\"stream_default_4tablejoin_resulttable1_dtstack_fanshu\":[{\"part\":false,\"comment\":\"\",\"type\":\"int\",\"key\":\"before_sink_id\"},{\"part\":false,\"comment\":\"\",\"type\":\"int\",\"key\":\"after_sink_id\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"before_sink_name\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"after_sink_name\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"before_sink_start_time\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"after_sink_start_time\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"before_sink_school\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"after_sink_school\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"before_sink_message\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"after_sink_message\"},{\"part\":false,\"comment\":\"\",\"type\":\"timestamp\",\"key\":\"before_sink_end_time\"},{\"part\":false,\"comment\":\"\",\"type\":\"timestamp\",\"key\":\"after_sink_end_time\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"type\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"schema\"},{\"part\":false,\"comment\":\"\",\"type\":\"string\",\"key\":\"table\"},{\"part\":false,\"comment\":\"\",\"type\":\"bigint\",\"key\":\"ts\"}]}",
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
          "table" : "stream_default_4tablejoin_resulttable1_dtstack_fanshu",
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

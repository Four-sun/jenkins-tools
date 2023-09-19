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
          "table" : [ "stream_mysql_ogg_two" ],
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "path" : "/stream/resource/fanshu",
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
          "column" : [ {
            "name" : "message",
            "index" : 0,
            "type" : "string"
          } ],
          "defaultFS" : "hdfs://ns1",
          "writeMode" : "APPEND",
          "fieldDelimiter" : ",",
          "fileType" : "text",
          "charsetName" : "utf-8"
        },
        "name" : "hdfswriter"
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

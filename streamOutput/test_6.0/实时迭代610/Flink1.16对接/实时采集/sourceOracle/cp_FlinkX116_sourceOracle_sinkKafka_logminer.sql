{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "split" : false,
          "cat" : "insert,update,delete",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
          "readPosition" : "current",
          "pavingData" : true,
          "table" : [ "SHIXIAO.FLINKX_CDC_ALL_TYPE_ONE", "SHIXIAO.FLINKX_CDC_ALL_TYPE_TWO", "SHIXIAO.FLINKX_CDC_ALL_TYPE_THREE" ],
          "username" : "shixiao"
        },
        "name" : "oraclelogminerreader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.21.237:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "fanshu2"
        },
        "name" : "kafkawriter",
        "type" : 37
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

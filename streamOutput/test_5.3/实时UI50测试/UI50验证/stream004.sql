{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "port" : 3306,
          "cat" : "insert,update,delete",
          "host" : "172.16.82.39",
          "jdbcUrl" : [ "jdbc:mysql://172.16.82.39:3306/automation" ],
          "start" : {
          },
          "pavingData" : true,
          "table" : [ "112_mysql_oracle_manual_upper_state_recover" ],
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "test_topic_name_wtzaudhp"
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

{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "0",
          "increColumn" : "ID",
          "column" : [ {
            "name" : "ID",
            "type" : "BIGINT",
            "key" : "ID"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:db2://172.16.101.246:50002/DT_TEST" ],
            "table" : [ "QIU_TEST.QIU_01" ]
          } ],
          "polling" : true,
          "username" : "db2inst1"
        },
        "name" : "db2reader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID" ],
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "fanshu7"
        },
        "name" : "kafkawriter",
        "type" : 37
      }
    } ],
    "setting" : {
      "restore" : {
        "isRestore" : true,
        "isStream" : true,
        "restoreColumnName" : "ID",
        "restoreColumnIndex" : 0
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

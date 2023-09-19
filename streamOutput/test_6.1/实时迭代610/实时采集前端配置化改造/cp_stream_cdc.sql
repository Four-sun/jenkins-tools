{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "0",
          "increColumn" : "id",
          "column" : [ {
            "name" : "id",
            "type" : "BIGINT",
            "key" : "id"
          }, {
            "name" : "name",
            "type" : "VARCHAR(255) ",
            "key" : "name"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:mysql://172.16.100.186:3306/test" ],
            "table" : [ "test.name" ]
          } ],
          "polling" : true,
          "username" : "drpeco"
        },
        "name" : "mysqlreader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "id", "name" ],
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
        "restoreColumnName" : "id",
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

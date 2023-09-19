{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "increColumn" : "id",
          "column" : [ {
            "name" : "id",
            "type" : "int",
            "key" : "id"
          }, {
            "name" : "idcard",
            "type" : "nvarchar",
            "key" : "idcard"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:sqlserver://172.16.101.246:1433;database=TestDB" ],
            "table" : [ "dbo.fanshu_1" ]
          } ],
          "polling" : true,
          "username" : "sa"
        },
        "name" : "sqlserverreader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "id", "idcard" ],
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.21.237:9092"
          },
          "dataCompelOrder" : true,
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

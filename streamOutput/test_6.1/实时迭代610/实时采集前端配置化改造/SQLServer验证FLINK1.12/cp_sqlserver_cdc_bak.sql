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
            "type" : "int",
            "key" : "id"
          }, {
            "name" : "name",
            "type" : "varchar",
            "key" : "name"
          }, {
            "name" : "age",
            "type" : "int",
            "key" : "age"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:sqlserver://172.16.101.246:1433;database=TestDB" ],
            "table" : [ "dbo.tiezhu_one" ]
          } ],
          "polling" : true,
          "username" : "sa"
        },
        "name" : "sqlserverreader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "id", "name", "age" ],
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

{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "databaseName" : "TestDB",
          "cat" : "insert,update,delete",
          "tableList" : [ "[dbo].[source_112_sqlserver_to_kafka_custom_sql_1]" ],
          "url" : "jdbc:sqlserver://172.16.101.246:1433;database=TestDB",
          "username" : "sa"
        },
        "name" : "sqlservercdcreader"
      },
      "writer" : {
        "parameter" : {
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

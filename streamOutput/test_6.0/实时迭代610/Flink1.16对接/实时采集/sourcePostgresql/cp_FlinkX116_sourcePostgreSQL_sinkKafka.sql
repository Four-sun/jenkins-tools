{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "temporary" : true,
          "password" : "******",
          "databaseName" : "public",
          "cat" : "insert,update,delete",
          "tableList" : [ "public.stream_pg_one" ],
          "allowCreateSlot" : true,
          "pavingData" : true,
          "url" : "jdbc:postgresql://172.16.101.246:5432/postgres",
          "username" : "dtstack_rep"
        },
        "name" : "pgwalreader"
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.21.237:9092"
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

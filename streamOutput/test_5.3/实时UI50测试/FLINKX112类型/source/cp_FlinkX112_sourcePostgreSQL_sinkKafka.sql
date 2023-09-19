{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "slotName" : "flinkx_flink_job",
          "password" : "******",
          "databaseName" : "public",
          "cat" : "insert,update,delete",
          "tableList" : [ "public.fanshutestone" ],
          "allowCreateSlot" : true,
          "pavingData" : true,
          "url" : "jdbc:postgresql://172.16.101.246:5432/postgres?stringtype=unspecified",
          "username" : "postgres"
        },
        "name" : "pgwalreader"
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

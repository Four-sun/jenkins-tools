{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "identifierMappings" : {
          "fanshu2" : "fanshu7",
          "fanshu3" : "fanshu5"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "topics" : [ "fanshu2", "fanshu3" ],
          "groupId" : "default",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false
        },
        "name" : "kafkareader"
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "topics" : [ "fanshu7", "fanshu5" ],
          "dataCompelOrder" : false
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

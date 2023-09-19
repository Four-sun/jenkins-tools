{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "header" : [ {
            "value" : "4F67F9E23855C1D2812FAB72834E6F29",
            "key" : "API-TOKEN"
          } ],
          "requestMode" : "POST",
          "body" : [ ],
          "decode" : "text",
          "strategy" : [ ],
          "url" : "http://172.16.23.253:81/api/gateway/test/testtesttest/xxxcs",
          "intervalTime" : 5000
        },
        "name" : "restapireader"
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

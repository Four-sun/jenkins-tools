{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "header" : [ {
            "value" : "20B8F017989C1CCA88402AA8193403157D47970DE136D07DB7F54874C846F68E",
            "key" : "API-TOKEN"
          } ],
          "requestMode" : "GET",
          "decode" : "json",
          "strategy" : [ ],
          "url" : "http://172.16.82.4:81/api/gateway/test/auto_test/fanshutest1",
          "intervalTime" : 10000
        },
        "name" : "restapireader"
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

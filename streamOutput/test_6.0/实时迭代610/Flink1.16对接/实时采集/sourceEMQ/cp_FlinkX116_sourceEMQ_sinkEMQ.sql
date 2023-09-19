{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "codec" : "plain",
          "qos" : 2,
          "isCleanSession" : true,
          "topic" : "fanshu001",
          "broker" : "tcp://172.16.100.186:1883"
        },
        "name" : "emqxreader"
      },
      "writer" : {
        "parameter" : {
          "qos" : 2,
          "isCleanSession" : true,
          "topic" : "fanshu002",
          "broker" : "tcp://172.16.100.186:1883"
        },
        "name" : "emqxwriter"
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

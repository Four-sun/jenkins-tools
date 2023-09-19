{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "columnMappings" : {
          "test.name" : {
            "name" : "name",
            "id" : "id"
          }
        },
        "identifierMappings" : {
          "test.name" : "test.name"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "nullReplaceNotExistsField" : false,
          "groupId" : "default",
          "deserialization" : "ogg",
          "topic" : "fanshu2",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.21.237:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false,
          "tableSchema" : {
            "test.name" : [ {
              "name" : "id",
              "type" : "string"
            }, {
              "name" : "name",
              "type" : "string"
            } ]
          }
        },
        "name" : "kafkareader"
      },
      "writer" : {
        "parameter" : {
          "password" : "******",
          "isFullColumnUpdateInReduction" : false,
          "allReplace" : true,
          "connection" : [ {
            "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/test",
            "column" : [ "*" ],
            "table" : [ "*" ]
          } ],
          "writeMode" : "insert",
          "username" : "drpeco"
        },
        "name" : "mysqlwriter"
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

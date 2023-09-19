{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "columnMappings" : {
          "null" : {
            "varchar_data" : "varchar_data",
            "id" : "id"
          }
        },
        "identifierMappings" : {
          "null" : "automation.stream_mysql_ogg_three"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "nullReplaceNotExistsField" : false,
          "topics" : [ "fanshu2", "fanshu3" ],
          "groupId" : "default",
          "deserialization" : "ogg",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false,
          "tableSchema" : {
            "null" : [ {
              "name" : "id",
              "type" : "string"
            }, {
              "name" : "varchar_data",
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
            "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/automation",
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

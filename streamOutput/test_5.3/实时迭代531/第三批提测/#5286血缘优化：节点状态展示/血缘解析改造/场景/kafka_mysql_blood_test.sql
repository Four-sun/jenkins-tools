{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "columnMappings" : {
          "test_topic_name_gcwfybte" : {
            "id" : "id"
          },
          "test_topic_name_wtzaudhp" : {
            "id" : "id"
          }
        },
        "identifierMappings" : {
          "test_topic_name_gcwfybte" : "automation.111aaa",
          "test_topic_name_wtzaudhp" : "automation.1_test"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "nullReplaceNotExistsField" : false,
          "topicSchema" : {
            "test_topic_name_gcwfybte" : [ {
              "name" : "id",
              "type" : "VARCHAR"
            } ],
            "test_topic_name_wtzaudhp" : [ {
              "name" : "id",
              "type" : "INT"
            } ]
          },
          "topics" : [ "test_topic_name_gcwfybte", "test_topic_name_wtzaudhp" ],
          "groupId" : "default",
          "useTopicReplaceTableName" : true,
          "deserialization" : "ogg",
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

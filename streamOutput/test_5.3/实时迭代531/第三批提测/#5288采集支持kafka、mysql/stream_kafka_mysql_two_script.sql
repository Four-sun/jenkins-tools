{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "columnMappings" : {
          "fanshu2" : {
            "decimal_data" : "decimal_data",
            "tinyint_data" : "tinyint_data",
            "varchar_data" : "varchar_data",
            "bigint_data" : "bigint_data",
            "double_data" : "double_data",
            "time_data" : "time_data",
            "date_data" : "date_data",
            "id" : "id",
            "int_data" : "int_data",
            "timestamp_data" : "timestamp_data"
          }
        },
        "identifierMappings" : {
          "fanshu2" : "automation.stream_mysql_ogg_two"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "nullReplaceNotExistsField" : false,
          "topicSchema" : {
            "fanshu2" : [ {
              "name" : "decimal_data",
              "type" : "DECIMAL(10,0)"
            }, {
              "name" : "tinyint_data",
              "type" : "TINYINT"
            }, {
              "name" : "varchar_data",
              "type" : "VARCHAR"
            }, {
              "name" : "bigint_data",
              "type" : "BIGINT"
            }, {
              "name" : "double_data",
              "type" : "DOUBLE"
            }, {
              "name" : "time_data",
              "type" : "TIME"
            }, {
              "name" : "date_data",
              "type" : "DATE"
            }, {
              "name" : "id",
              "type" : "INT"
            }, {
              "name" : "int_data",
              "type" : "INT"
            }, {
              "name" : "timestamp_data",
              "type" : "TIMESTAMP"
            } ]
          },
          "groupId" : "default",
          "useTopicReplaceTableName" : true,
          "deserialization" : "ogg",
          "topic" : "fanshu2",
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

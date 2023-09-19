{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "select id,name from FLINKX_CDC_TWO",
          "startLocation" : "0",
          "increColumn" : "ID",
          "column" : [ {
            "name" : "ID",
            "type" : "NUMBER"
          }, {
            "name" : "NAME",
            "type" : "VARCHAR2"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:oracle:thin:@172.16.100.243:1521:orcl" ]
          } ],
          "polling" : true,
          "username" : "shixiao"
        },
        "name" : "oraclereader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID", "NAME" ],
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
        "isStream" : true,
        "restoreColumnName" : "ID",
        "restoreColumnIndex" : 0
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

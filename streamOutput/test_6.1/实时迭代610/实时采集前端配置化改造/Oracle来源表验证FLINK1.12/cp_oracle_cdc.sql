{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "0",
          "increColumn" : "ID",
          "column" : [ {
            "name" : "ID",
            "type" : "NUMBER",
            "key" : "ID"
          }, {
            "name" : "NAME",
            "type" : "VARCHAR2",
            "key" : "NAME"
          }, {
            "name" : "ADDRESS",
            "type" : "VARCHAR2",
            "key" : "ADDRESS"
          }, {
            "name" : "SCHOOL",
            "type" : "VARCHAR2",
            "key" : "SCHOOL"
          }, {
            "name" : "MESSAGE",
            "type" : "VARCHAR2",
            "key" : "MESSAGE"
          }, {
            "name" : "START_TIME",
            "type" : "TIMESTAMP(6)",
            "key" : "START_TIME"
          }, {
            "name" : "END_TIME",
            "type" : "TIMESTAMP(6)",
            "key" : "END_TIME"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:oracle:thin:@172.16.100.243:1521:orcl" ],
            "table" : [ "SHIXIAO.FLINKX_CDC_TWO" ]
          } ],
          "polling" : true,
          "username" : "shixiao"
        },
        "name" : "oraclereader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID", "NAME", "ADDRESS", "SCHOOL", "MESSAGE", "START_TIME", "END_TIME" ],
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

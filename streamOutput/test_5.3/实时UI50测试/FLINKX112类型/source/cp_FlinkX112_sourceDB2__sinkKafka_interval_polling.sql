{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "1",
          "increColumn" : "ID",
          "column" : [ {
            "name" : "ID",
            "type" : "BIGINT",
            "key" : "ID"
          }, {
            "name" : "SOURCE",
            "type" : "SMALLINT",
            "key" : "SOURCE"
          }, {
            "name" : "GRADE",
            "type" : "INTEGER",
            "key" : "GRADE"
          }, {
            "name" : "USERNAME",
            "type" : "CHAR",
            "key" : "USERNAME"
          }, {
            "name" : "CREATE_DATE",
            "type" : "DATE",
            "key" : "CREATE_DATE"
          }, {
            "name" : "DEC_VAL",
            "type" : "DECIMAL",
            "key" : "DEC_VAL"
          }, {
            "name" : "DOU_VAL",
            "type" : "DOUBLE",
            "key" : "DOU_VAL"
          }, {
            "name" : "FLO_VAL",
            "type" : "DOUBLE",
            "key" : "FLO_VAL"
          }, {
            "name" : "VAR_VAL",
            "type" : "VARCHAR(256) ",
            "key" : "VAR_VAL"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:db2://172.16.101.246:50002/DT_TEST" ],
            "table" : [ "QIU_TEST.TEST_00001" ]
          } ],
          "polling" : true,
          "username" : "db2inst1"
        },
        "name" : "db2reader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID", "SOURCE", "GRADE", "USERNAME", "CREATE_DATE", "DEC_VAL", "DOU_VAL", "FLO_VAL", "VAR_VAL" ],
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

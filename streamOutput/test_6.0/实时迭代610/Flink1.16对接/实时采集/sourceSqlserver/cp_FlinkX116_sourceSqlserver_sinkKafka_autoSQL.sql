{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "select id, name, idcard, birthday, mobile, email, gender, create_time from fanshu_1",
          "startLocation" : "0",
          "increColumn" : "id",
          "column" : [ {
            "name" : "id",
            "type" : "int",
            "key" : "id"
          }, {
            "name" : "name",
            "type" : "nvarchar",
            "key" : "name"
          }, {
            "name" : "idcard",
            "type" : "nvarchar",
            "key" : "idcard"
          }, {
            "name" : "birthday",
            "type" : "date",
            "key" : "birthday"
          }, {
            "name" : "mobile",
            "type" : "nvarchar",
            "key" : "mobile"
          }, {
            "name" : "email",
            "type" : "nvarchar",
            "key" : "email"
          }, {
            "name" : "gender",
            "type" : "tinyint",
            "key" : "gender"
          }, {
            "name" : "create_time",
            "type" : "datetime",
            "key" : "create_time"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:sqlserver://172.16.101.246:1433;database=TestDB" ]
          } ],
          "polling" : true,
          "username" : "sa"
        },
        "name" : "sqlserverreader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "id", "name", "idcard", "birthday", "mobile", "email", "gender", "create_time" ],
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
        "isStream" : true,
        "restoreColumnName" : "id",
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

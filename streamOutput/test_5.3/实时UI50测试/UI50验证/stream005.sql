{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "column" : [ {
            "name" : "id",
            "type" : "int"
          }, {
            "name" : "name",
            "type" : "VARCHAR"
          }, {
            "name" : "-name",
            "type" : "VARCHAR"
          } ],
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:mysql://172.16.82.209:3306/tiezhu" ],
            "table" : [ "test-one" ]
          } ],
          "splitPk" : "id",
          "username" : "root"
        },
        "name" : "mysqlreader"
      },
      "writer" : {
        "parameter" : {
          "password" : "******",
          "column" : [ {
            "name" : "id",
            "type" : "BIGINT"
          }, {
            "name" : "name",
            "type" : "varchar"
          }, {
            "name" : "age",
            "type" : "varchar"
          } ],
          "connection" : [ {
            "schema" : "TIEZHU",
            "jdbcUrl" : "jdbc:phoenix:172.16.83.242:2181",
            "table" : [ "STU" ]
          } ],
          "writeMode" : "upsert",
          "username" : ""
        },
        "name" : "phoenix5writer"
      }
    } ],
    "setting" : {
      "errorLimit" : {
        "record" : 0
      },
      "speed" : {
        "bytes" : 0,
        "channel" : 2
      }
    }
  }
}

{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "identifierMappings" : {
          "SHIXIAO.*" : "public.public.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "split" : true,
          "cat" : "insert,update,delete",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
          "readPosition" : "current",
          "pavingData" : false,
          "table" : [ "SHIXIAO.FLINKX_CDC_ALL_TYPE_ONE" ],
          "username" : "shixiao"
        },
        "name" : "oraclelogminerreader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "password" : "******",
          "connection" : [ {
            "jdbcUrl" : "jdbc:postgresql://172.16.101.246:5432/postgres",
            "table" : [ "*" ]
          } ],
          "writeMode" : "APPEND",
          "username" : "postgres"
        },
        "name" : "postgresqlwriter"
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

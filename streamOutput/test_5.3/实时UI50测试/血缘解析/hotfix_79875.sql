{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "identifierMappings" : {
          "BAIXI.*" : "public.a12.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "BAIXI",
          "password" : "******",
          "split" : true,
          "cat" : "insert,update,delete",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:ORCL",
          "readPosition" : "current",
          "pavingData" : false,
          "table" : [ "BAIXI.A" ],
          "username" : "oracle"
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
          "username" : "dtstack_rep"
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

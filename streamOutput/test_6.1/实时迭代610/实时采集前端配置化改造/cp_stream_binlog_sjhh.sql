{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UPPER",
        "identifierMappings" : {
          "test.*" : "SHIXIAO.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "ddlSkip" : false,
          "enableFetchAll" : false,
          "start" : { },
          "pavingData" : false,
          "password" : "******",
          "split" : true,
          "port" : 3306,
          "cat" : "insert,update,delete",
          "host" : "172.16.100.186",
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/test",
          "table" : [ "name" ],
          "initialTableStructure" : true,
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "executeDdlAble" : true,
          "connection" : [ {
            "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
            "table" : [ "*" ]
          } ],
          "username" : "shixiao"
        },
        "name" : "oraclewriter"
      },
      "restoration" : {
        "cache" : {
          "cacheTimeout" : 60000,
          "cacheSize" : 1000,
          "maxBytes" : 102400,
          "type" : "mysql",
          "properties" : {
            "database" : "test",
            "password" : "******",
            "table" : "transaction_data_cp_stream_binlog_sjhh",
            "url" : "jdbc:mysql://172.16.100.186:3306/test",
            "username" : "drpeco"
          }
        },
        "workerMax" : 3,
        "workerSize" : 3,
        "stateRecover" : {
          "type" : "mysql",
          "properties" : {
            "database" : "test",
            "password" : "******",
            "table" : "cp_stream_binlog_sjhh_state_recover",
            "url" : "jdbc:mysql://172.16.100.186:3306/test",
            "username" : "drpeco"
          }
        },
        "workerNum" : 2,
        "ddl" : {
          "fetchInterval" : 3000,
          "type" : "mysql",
          "properties" : {
            "database" : "test",
            "password" : "******",
            "table" : "ddl_change_cp_stream_binlog_sjhh",
            "url" : "jdbc:mysql://172.16.100.186:3306/test",
            "username" : "drpeco"
          }
        }
      }
    } ],
    "setting" : {
      "restore" : {
        "isRestore" : true,
        "isStream" : true
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

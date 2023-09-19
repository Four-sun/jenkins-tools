{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UNCHANGE",
        "identifierMappings" : {
          "test.*" : "test.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "password" : "******",
          "split" : true,
          "port" : 3306,
          "ddlSkip" : false,
          "cat" : "",
          "enableFetchAll" : false,
          "host" : "172.16.100.186",
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/test",
          "start" : { },
          "table" : [ "name02" ],
          "initialTableStructure" : true,
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "parameter" : {
          "password" : "******",
          "executeDdlAble" : true,
          "connection" : [ {
            "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/test",
            "table" : [ "*" ]
          } ],
          "writeMode" : "insert",
          "username" : "drpeco"
        },
        "name" : "mysqlwriter"
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
            "table" : "transaction_data_cp_sjhh_test",
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
            "table" : "cp_sjhh_test_state_recover",
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
            "table" : "ddl_change_cp_sjhh_test",
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

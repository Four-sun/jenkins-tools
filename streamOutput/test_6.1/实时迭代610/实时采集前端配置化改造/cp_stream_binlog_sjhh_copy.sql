{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "LOWER",
        "identifierMappings" : {
          "test.*" : "test.${tableName}_name_1"
        }
      },
      "reader" : {
        "parameter" : {
          "fetchFilterSql" : "id > 1",
          "ddlSkip" : false,
          "enableFetchAll" : true,
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
          "cacheSize" : 100000,
          "maxBytes" : 104857600,
          "type" : "mysql",
          "properties" : {
            "database" : "test",
            "password" : "******",
            "table" : "transaction_data_cp_stream_binlog_sjhh_copy",
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
            "table" : "cp_stream_binlog_sjhh_copy_state_recover",
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
            "table" : "ddl_change_cp_stream_binlog_sjhh_copy",
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

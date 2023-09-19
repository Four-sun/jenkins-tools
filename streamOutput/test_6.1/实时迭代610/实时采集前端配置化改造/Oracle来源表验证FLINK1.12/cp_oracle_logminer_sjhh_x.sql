{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UNCHANGE",
        "identifierMappings" : {
          "SHIXIAO.*" : "test.name${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "fetchFilterSql" : "id>1",
          "split" : true,
          "ddlSkip" : false,
          "cat" : "",
          "enableFetchAll" : "true",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
          "table" : [ "SHIXIAO.FLINKX_CDC_ONE" ],
          "initialTableStructure" : true,
          "username" : "shixiao"
        },
        "name" : "oraclelogminerreader",
        "type" : 2
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
            "table" : "transaction_data_cp_oracle_logminer_sjhh_x",
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
            "table" : "cp_oracle_logminer_sjhh_x_state_recover",
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
            "table" : "ddl_change_cp_oracle_logminer_sjhh_x",
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

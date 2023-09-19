{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UNCHANGE",
        "identifierMappings" : {
          "SHIXIAO.*" : "yctest.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "split" : true,
          "ddlSkip" : false,
          "cat" : "insert,update,delete",
          "enableFetchAll" : "false",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
          "readPosition" : "current",
          "pavingData" : false,
          "table" : [ "SHIXIAO.FLINKX_CDC_ALL_TYPE_FOUR" ],
          "initialTableStructure" : true,
          "username" : "shixiao"
        },
        "name" : "oraclelogminerreader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "schema" : "yctest",
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
            "database" : "automation",
            "password" : "******",
            "table" : "transaction_data_CDC_ORACLE_ORACLE",
            "url" : "jdbc:mysql://172.16.100.186:3306/automation",
            "username" : "drpeco"
          }
        },
        "workerMax" : 3,
        "workerSize" : 3,
        "stateRecover" : {
          "type" : "mysql",
          "properties" : {
            "database" : "automation",
            "password" : "******",
            "table" : "CDC_ORACLE_ORACLE_state_recover",
            "url" : "jdbc:mysql://172.16.100.186:3306/automation",
            "username" : "drpeco"
          }
        },
        "workerNum" : 2,
        "ddl" : {
          "fetchInterval" : 3000,
          "type" : "mysql",
          "properties" : {
            "database" : "automation",
            "password" : "******",
            "table" : "ddl_change_CDC_ORACLE_ORACLE",
            "url" : "jdbc:mysql://172.16.100.186:3306/automation",
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

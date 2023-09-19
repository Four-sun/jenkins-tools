{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "LOWER",
        "identifierMappings" : {
          "SHIXIAO.*" : "automation.stream_${schemaName}_${tableName}"
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
          "table" : [ "SHIXIAO.ORACLE_FLINKX_CDC_TEST_ONE" ],
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
            "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/automation",
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
            "database" : "a_qiyun",
            "password" : "******",
            "table" : "transaction_data_cp_112_ORACLE_MYSQL_MANUAL_LOWER",
            "url" : "jdbc:mysql://172.16.23.23:3306/a_qiyun?useSSL=false",
            "username" : "drpeco"
          }
        },
        "workerMax" : 3,
        "workerSize" : 3,
        "stateRecover" : {
          "type" : "mysql",
          "properties" : {
            "database" : "a_qiyun",
            "password" : "******",
            "table" : "cp_112_ORACLE_MYSQL_MANUAL_LOWER_state_recover",
            "url" : "jdbc:mysql://172.16.23.23:3306/a_qiyun?useSSL=false",
            "username" : "drpeco"
          }
        },
        "workerNum" : 2,
        "ddl" : {
          "fetchInterval" : 3000,
          "type" : "mysql",
          "properties" : {
            "database" : "a_qiyun",
            "password" : "******",
            "table" : "ddl_change_cp_112_ORACLE_MYSQL_MANUAL_LOWER",
            "url" : "jdbc:mysql://172.16.23.23:3306/a_qiyun?useSSL=false",
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

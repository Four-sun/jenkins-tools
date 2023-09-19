{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UPPER",
        "identifierMappings" : {
          "SHIXIAO.*" : "ORACLE.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "fetchFilterSql" : "",
          "ddlSkip" : false,
          "enableFetchAll" : "true",
          "readPosition" : "current",
          "pavingData" : false,
          "password" : "******",
          "split" : true,
          "cat" : "insert,update,delete",
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
          "schema" : "ORACLE",
          "password" : "******",
          "executeDdlAble" : true,
          "connection" : [ {
            "jdbcUrl" : "jdbc:oracle:thin:@172.16.85.244:1521:orcl",
            "table" : [ "*" ]
          } ],
          "username" : "oracle"
        },
        "name" : "oraclewriter"
      },
      "restoration" : {
        "cache" : {
          "cacheTimeout" : 60000,
          "cacheSize" : 100000,
          "maxBytes" : 104857600,
          "type" : "mysql",
          "properties" : {
            "database" : "automation",
            "password" : "******",
            "table" : "transaction_data_Flink_CDC_Test_Oracle_Oracle",
            "url" : "jdbc:mysql://172.16.82.39:3306/automation",
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
            "table" : "Flink_CDC_Test_Oracle_Oracle_state_recover",
            "url" : "jdbc:mysql://172.16.82.39:3306/automation",
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
            "table" : "ddl_change_Flink_CDC_Test_Oracle_Oracle",
            "url" : "jdbc:mysql://172.16.82.39:3306/automation",
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

{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UNCHANGE",
        "identifierMappings" : {
          "SHIXIAO.*" : "ORACLE.${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "schema" : "SHIXIAO",
          "password" : "******",
          "split" : true,
          "ddlSkip" : false,
          "cat" : "insert,update,delete",
          "enableFetchAll" : "true",
          "jdbcUrl" : "jdbc:oracle:thin:@172.16.100.243:1521:orcl",
          "readPosition" : "current",
          "pavingData" : false,
          "table" : [ "SHIXIAO.FLINKX_CDC_ALL_TYPE_ONE" ],
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
            "table" : "transaction_data_cp_STREAM_checkpoint_1_copy",
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
            "table" : "cp_STREAM_checkpoint_1_copy_state_recover",
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
            "table" : "ddl_change_cp_STREAM_checkpoint_1_copy",
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

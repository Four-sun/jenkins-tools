{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UPPER",
        "identifierMappings" : {
          "automation.*" : "SHIXIAO._test_${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
          "fetchFilterSql" : "id between 1 and 1000",
          "ddlSkip" : false,
          "enableFetchAll" : true,
          "start" : {
          },
          "pavingData" : false,
          "password" : "******",
          "split" : true,
          "port" : 3306,
          "cat" : "insert,update,delete",
          "host" : "172.16.100.186",
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/automation",
          "table" : [ "cdc_one" ],
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
          "cacheSize" : 100000,
          "maxBytes" : 104857600,
          "type" : "mysql",
          "properties" : {
            "database" : "a_qiyun",
            "password" : "******",
            "table" : "transaction_data_cp_112_MySQL_DDL_ORACLE_AUTO_NORMAL",
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
            "table" : "cp_112_MySQL_DDL_ORACLE_AUTO_NORMAL_state_recover",
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
            "table" : "ddl_change_cp_112_MySQL_DDL_ORACLE_AUTO_NORMAL",
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

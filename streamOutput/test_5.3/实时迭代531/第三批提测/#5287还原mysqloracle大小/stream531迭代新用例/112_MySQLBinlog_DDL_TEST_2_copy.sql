{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "casing" : "UNCHANGE",
        "identifierMappings" : {
          "automation.*" : "automation.stream_${schemaName}_${tableName}"
        }
      },
      "reader" : {
        "parameter" : {
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
          "table" : [ "mysql_flink_cdc_test_one" ],
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
            "jdbcUrl" : "jdbc:mysql://172.16.82.39:3306/automation",
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
            "database" : "automation",
            "password" : "******",
            "table" : "transaction_data_112_MySQLBinlog_DDL_TEST_2_copy",
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
            "table" : "112_MySQLBinlog_DDL_TEST_2_copy_state_recover",
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
            "table" : "ddl_change_112_MySQLBinlog_DDL_TEST_2_copy",
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

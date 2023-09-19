{
  "job" : {
    "content" : [ {
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
          "jdbcUrl" : "jdbc:mysql://172.16.100.186:3306/automation",
          "table" : [ "mysql_flink_cdc_test_four" ],
          "initialTableStructure" : true,
          "username" : "drpeco"
        },
        "name" : "binlogreader"
      },
      "writer" : {
        "semantic" : "exactly-once",
        "parameter" : {
          "database" : "kungen",
          "partition" : "days(timestamp_data)",
          "hadoopConfig" : {
            "fs.defaultFS" : "hdfs://ns1",
            "dfs.ha.namenodes.ns1" : "nn1,nn2",
            "dfs.namenode.rpc-address.ns1.nn2" : "172.16.22.103:9000",
            "dfs.client.failover.proxy.provider.ns1" : "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider",
            "dfs.namenode.rpc-address.ns1.nn1" : "172.16.21.107:9000",
            "dfs.nameservices" : "ns1"
          },
          "executeDdlAble" : true,
          "defaultFS" : "hdfs://ns1",
          "warehouse" : "hdfs://dtInsight/hive/warehouse",
          "uri" : "thrift://172-16-23-238:9083",
          "table" : "mysql_flink_cdc_test_four"
        },
        "name" : "icebergwriter"
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
            "table" : "transaction_data_flinkcdc_mysql_iceberg_increment_copy",
            "url" : "jdbc:mysql://172.16.82.144:3306/automation",
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
            "table" : "flinkcdc_mysql_iceberg_increment_copy_state_recover",
            "url" : "jdbc:mysql://172.16.82.144:3306/automation",
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
            "table" : "ddl_change_flinkcdc_mysql_iceberg_increment_copy",
            "url" : "jdbc:mysql://172.16.82.144:3306/automation",
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

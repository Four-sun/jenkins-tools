{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "ddlSkip" : false,
          "enableFetchAll" : true,
          "start" : { },
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
        "semantic" : "exactly-once",
        "parameter" : {
          "database" : "db_jiuwei",
          "hadoopConfig" : {
            "fs.defaultFS" : "hdfs://ns1",
            "hadoop.security.authentication" : "kerberos",
            "dfs.client.failover.proxy.provider.ns1" : "org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider",
            "hive.metastore.sasl.enabled" : "true",
            "dfs.nameservices" : "ns1",
            "sftpConf" : {
              "maxWaitMillis" : "3600000",
              "minIdle" : "16",
              "auth" : "1",
              "isUsePool" : "true",
              "timeout" : "3000",
              "path" : "/home/admin/sftp/stream_6x",
              "password" : "******",
              "maxIdle" : "16",
              "port" : "22",
              "maxTotal" : "16",
              "host" : "172.16.82.70",
              "fileTimeout" : "300000",
              "username" : "admin"
            },
            "java.security.krb5.conf" : "krb5.conf",
            "dfs.ha.namenodes.ns1" : "nn1,nn2",
            "principal" : "hive/dev03-hadoop@DTSTACK.COM",
            "remoteDir" : "/home/admin/sftp/stream_6x/DSCENTER_ICEBERG_101",
            "dfs.namenode.rpc-address.ns1.nn2" : "172.16.82.91:9000",
            "hadoop.security.authorization" : true,
            "principalFile" : "hive.keytab",
            "dfs.namenode.rpc-address.ns1.nn1" : "172.16.82.162:9000",
            "hive.metastore.kerberos.principal" : "hive/dev03-hadoop@DTSTACK.COM"
          },
          "executeDdlAble" : true,
          "defaultFS" : "hdfs://ns1",
          "warehouse" : "hdfs:/dtInsight/hive/warehouse",
          "uri" : "thrift://172.16.82.162:9083",
          "table" : "mysql_flink_cdc_test_one"
        },
        "name" : "icebergwriter"
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
            "table" : "transaction_data_flinkcdc_krb_copy",
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
            "table" : "flinkcdc_krb_copy_state_recover",
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
            "table" : "ddl_change_flinkcdc_krb_copy",
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

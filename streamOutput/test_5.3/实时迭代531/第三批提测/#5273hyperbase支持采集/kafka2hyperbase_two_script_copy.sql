{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "columnMappings" : {
          "automation.stream_mysql_ogg_one" : {
            "name" : "name",
            "id" : "id",
            "age" : "age"
          }
        },
        "identifierMappings" : {
          "automation.stream_mysql_ogg_one" : "tiezhu.stream_test_02"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "nullReplaceNotExistsField" : false,
          "topics" : [ "fanshu2", "fanshu4" ],
          "groupId" : "default",
          "deserialization" : "ogg",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false,
          "tableSchema" : {
            "automation.stream_mysql_ogg_one" : [ {
              "name" : "id",
              "type" : "int"
            }, {
              "name" : "name",
              "type" : "varchar(100)"
            }, {
              "name" : "age",
              "type" : "varchar(100)"
            } ]
          }
        },
        "name" : "kafkareader"
      },
      "writer" : {
        "isBinaryRowkey" : true,
        "parameter" : {
          "rowKeyExpress" : {
            "tiezhu.stream_test_02" : "$(id)"
          },
          "column" : [ "*" ],
          "connection" : [ {
            "password" : "******",
            "jdbcUrl" : "jdbc:hive2://172.16.83.150:10000/tiezhu;principal=hive/tdh02@TDH",
            "username" : "admin"
          } ],
          "hbaseConfig" : {
            "hbase.zookeeper.quorum" : "tdh02,tdh03,tdh01",
            "hadoop.security.authentication" : "kerberos",
            "jaasSectionName" : "Client",
            "zookeeper.znode.parent" : "/hyperbase1",
            "sftpConf" : {
              "maxWaitMillis" : "3600000",
              "minIdle" : "16",
              "auth" : "1",
              "isUsePool" : "true",
              "timeout" : "30000",
              "path" : "/home/admin/sftp/dttestuic_com",
              "password" : "******",
              "maxIdle" : "16",
              "port" : "22",
              "maxTotal" : "16",
              "host" : "172.16.82.70",
              "fileTimeout" : "300000",
              "username" : "admin"
            },
            "java.security.krb5.conf" : "krb5.conf",
            "hbase.regionserver.kerberos.principal" : "hbase/_HOST@TDH",
            "principal" : "hbase/tdh01@TDH",
            "remoteDir" : "/home/admin/sftp/dttestuic_com/DsCenter_979",
            "hbase.security.authentication" : "kerberos",
            "principalFile" : "hyperbase.keytab",
            "hbase.master.kerberos.principal" : "hbase/_HOST@TDH",
            "isAddSecurityModule" : true,
            "useLocalFile" : "false"
          }
        },
        "name" : "inceptorwriter",
        "encoding" : "utf-8"
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

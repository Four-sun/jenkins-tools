{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "1",
          "increColumn" : "ID",
          "column" : [ {
            "name" : "ID",
            "type" : "NUMBER(38,0)",
            "key" : "ID"
          }, {
            "name" : "FLOAT_DATA",
            "type" : "FLOAT",
            "key" : "FLOAT_DATA"
          }, {
            "name" : "DOUBLE_DATA",
            "type" : "FLOAT",
            "key" : "DOUBLE_DATA"
          }, {
            "name" : "NUMBER_1",
            "type" : "NUMBER(1,0)",
            "key" : "NUMBER_1"
          }, {
            "name" : "CHAR_255",
            "type" : "CHAR",
            "key" : "CHAR_255"
          }, {
            "name" : "NCHAR_255",
            "type" : "NCHAR",
            "key" : "NCHAR_255"
          }, {
            "name" : "NVARCHAR2_255",
            "type" : "NVARCHAR2",
            "key" : "NVARCHAR2_255"
          }, {
            "name" : "VARCHAR_255",
            "type" : "VARCHAR2",
            "key" : "VARCHAR_255"
          }, {
            "name" : "VARCHAR2_255",
            "type" : "VARCHAR2",
            "key" : "VARCHAR2_255"
          }, {
            "name" : "CLOB_DATA",
            "type" : "CLOB",
            "key" : "CLOB_DATA"
          }, {
            "name" : "BLOB_DATA",
            "type" : "BLOB",
            "key" : "BLOB_DATA"
          }, {
            "name" : "DATE_DATA",
            "type" : "DATE",
            "key" : "DATE_DATA"
          }, {
            "name" : "TIMESTAMP_DATA",
            "type" : "TIMESTAMP(6)",
            "key" : "TIMESTAMP_DATA"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:oracle:thin:@172.16.100.243:1521:orcl" ],
            "table" : [ "SHIXIAO.FLINKX_NEW_ALL_TYPE_TWO" ]
          } ],
          "polling" : true,
          "username" : "shixiao"
        },
        "name" : "oraclereader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID", "FLOAT_DATA", "DOUBLE_DATA", "NUMBER_1", "CHAR_255", "NCHAR_255", "NVARCHAR2_255", "VARCHAR_255", "VARCHAR2_255", "CLOB_DATA", "BLOB_DATA", "DATE_DATA", "TIMESTAMP_DATA" ],
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "fanshu7",
          "partitionAssignColumns" : [ "ID" ]
        },
        "name" : "kafkawriter",
        "type" : 37
      }
    } ],
    "setting" : {
      "restore" : {
        "isRestore" : true,
        "isStream" : true,
        "restoreColumnName" : "ID",
        "restoreColumnIndex" : 0
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

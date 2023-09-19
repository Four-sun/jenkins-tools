{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "select ID, FLOAT_DATA, DOUBLE_DATA, NUMBER_1, CHAR_255, NCHAR_255, NVARCHAR2_255, VARCHAR_255, VARCHAR2_255, DATE_DATA, TIMESTAMP_DATA from FLINKX_CDC_ALL_TYPE_TWO where ID between 1 and 4000",
          "startLocation" : "0",
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
            "type" : "NUMBER(5,0)",
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
            "name" : "DATE_DATA",
            "type" : "DATE",
            "key" : "DATE_DATA"
          }, {
            "name" : "TIMESTAMP_DATA",
            "type" : "TIMESTAMP",
            "key" : "TIMESTAMP_DATA"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:oracle:thin:@172.16.100.243:1521:orcl" ]
          } ],
          "polling" : true,
          "username" : "shixiao"
        },
        "name" : "oraclereader",
        "type" : 2
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "ID", "FLOAT_DATA", "DOUBLE_DATA", "NUMBER_1", "CHAR_255", "NCHAR_255", "NVARCHAR2_255", "VARCHAR_255", "VARCHAR2_255", "DATE_DATA", "TIMESTAMP_DATA" ],
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.21.237:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "fanshu2"
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

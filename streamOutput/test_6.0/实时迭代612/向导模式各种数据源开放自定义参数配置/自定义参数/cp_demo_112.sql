{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "password" : "******",
          "customSql" : "",
          "startLocation" : "0",
          "increColumn" : "id",
          "column" : [ {
            "name" : "id",
            "type" : "INT",
            "key" : "id"
          }, {
            "name" : "boolean_data",
            "type" : "TINYINT",
            "key" : "boolean_data"
          }, {
            "name" : "bit_data",
            "type" : "BIT",
            "key" : "bit_data"
          }, {
            "name" : "tinyint_data",
            "type" : "TINYINT",
            "key" : "tinyint_data"
          }, {
            "name" : "tinyint_unsigned_data",
            "type" : "TINYINT UNSIGNED",
            "key" : "tinyint_unsigned_data"
          }, {
            "name" : "smallint_data",
            "type" : "SMALLINT",
            "key" : "smallint_data"
          }, {
            "name" : "smallint_unsigned_data",
            "type" : "SMALLINT UNSIGNED",
            "key" : "smallint_unsigned_data"
          }, {
            "name" : "mediumint_data",
            "type" : "MEDIUMINT",
            "key" : "mediumint_data"
          }, {
            "name" : "mediumint_unsigned_data",
            "type" : "MEDIUMINT UNSIGNED",
            "key" : "mediumint_unsigned_data"
          }, {
            "name" : "int_data",
            "type" : "INT",
            "key" : "int_data"
          }, {
            "name" : "int_unsigned_data",
            "type" : "INT UNSIGNED",
            "key" : "int_unsigned_data"
          }, {
            "name" : "integer_data",
            "type" : "INT",
            "key" : "integer_data"
          }, {
            "name" : "bigint_data",
            "type" : "BIGINT",
            "key" : "bigint_data"
          }, {
            "name" : "bigint_unsigned_data",
            "type" : "BIGINT UNSIGNED",
            "key" : "bigint_unsigned_data"
          }, {
            "name" : "float_data",
            "type" : "FLOAT",
            "key" : "float_data"
          }, {
            "name" : "float_unsigned_data",
            "type" : "FLOAT UNSIGNED",
            "key" : "float_unsigned_data"
          }, {
            "name" : "decimal_data",
            "type" : "DECIMAL",
            "key" : "decimal_data"
          }, {
            "name" : "decimal_unsigned_data",
            "type" : "DECIMAL UNSIGNED",
            "key" : "decimal_unsigned_data"
          }, {
            "name" : "numeric_data",
            "type" : "DECIMAL",
            "key" : "numeric_data"
          }, {
            "name" : "double_data",
            "type" : "DOUBLE",
            "key" : "double_data"
          }, {
            "name" : "double_unsigned_data",
            "type" : "DOUBLE UNSIGNED",
            "key" : "double_unsigned_data"
          }, {
            "name" : "varchar_data",
            "type" : "VARCHAR(255) ",
            "key" : "varchar_data"
          }, {
            "name" : "char_data",
            "type" : "CHAR",
            "key" : "char_data"
          }, {
            "name" : "timestamp_data",
            "type" : "TIMESTAMP",
            "key" : "timestamp_data"
          }, {
            "name" : "datetime_data",
            "type" : "DATETIME",
            "key" : "datetime_data"
          }, {
            "name" : "date_data",
            "type" : "DATE",
            "key" : "date_data"
          }, {
            "name" : "time_data",
            "type" : "TIME",
            "key" : "time_data"
          }, {
            "name" : "year_data",
            "type" : "YEAR",
            "key" : "year_data"
          }, {
            "name" : "tinyblob_data",
            "type" : "TINYBLOB",
            "key" : "tinyblob_data"
          }, {
            "name" : "blob_data",
            "type" : "BLOB",
            "key" : "blob_data"
          }, {
            "name" : "mediumblob_data",
            "type" : "MEDIUMBLOB",
            "key" : "mediumblob_data"
          }, {
            "name" : "longblob_data",
            "type" : "LONGBLOB",
            "key" : "longblob_data"
          }, {
            "name" : "tinytext_data",
            "type" : "VARCHAR(85) ",
            "key" : "tinytext_data"
          }, {
            "name" : "text_data",
            "type" : "TEXT",
            "key" : "text_data"
          }, {
            "name" : "mediumtext_data",
            "type" : "MEDIUMTEXT",
            "key" : "mediumtext_data"
          }, {
            "name" : "longtext_data",
            "type" : "LONGTEXT",
            "key" : "longtext_data"
          }, {
            "name" : "binary_data",
            "type" : "BINARY",
            "key" : "binary_data"
          }, {
            "name" : "varbinary_data",
            "type" : "VARBINARY",
            "key" : "varbinary_data"
          }, {
            "name" : "json_data",
            "type" : "JSON",
            "key" : "json_data"
          }, {
            "name" : "enum_data",
            "type" : "CHAR",
            "key" : "enum_data"
          }, {
            "name" : "set_data",
            "type" : "CHAR",
            "key" : "set_data"
          } ],
          "pollingInterval" : 5000,
          "connection" : [ {
            "jdbcUrl" : [ "jdbc:mysql://172.16.100.186:3306/automation" ],
            "table" : [ "automation.side_112_mysql_all_type_table" ]
          } ],
          "polling" : true,
          "username" : "drpeco"
        },
        "name" : "mysqlreader"
      },
      "writer" : {
        "parameter" : {
          "tableFields" : [ "id", "boolean_data", "bit_data", "tinyint_data", "tinyint_unsigned_data", "smallint_data", "smallint_unsigned_data", "mediumint_data", "mediumint_unsigned_data", "int_data", "int_unsigned_data", "integer_data", "bigint_data", "bigint_unsigned_data", "float_data", "float_unsigned_data", "decimal_data", "decimal_unsigned_data", "numeric_data", "double_data", "double_unsigned_data", "varchar_data", "char_data", "timestamp_data", "datetime_data", "date_data", "time_data", "year_data", "tinyblob_data", "blob_data", "mediumblob_data", "longblob_data", "tinytext_data", "text_data", "mediumtext_data", "longtext_data", "binary_data", "varbinary_data", "json_data", "enum_data", "set_data" ],
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "dataCompelOrder" : true,
          "topic" : "fanshu4",
          "partitionAssignColumns" : [ "id" ]
        },
        "name" : "kafkawriter",
        "type" : 37
      }
    } ],
    "setting" : {
      "restore" : {
        "isRestore" : true,
        "isStream" : true,
        "restoreColumnName" : "id",
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

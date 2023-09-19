{
  "job" : {
    "content" : [ {
      "reader" : {
        "parameter" : {
          "slotName" : "flinkx_pg_1",
          "password" : "******",
          "databaseName" : "public",
          "cat" : "insert,update,delete",
          "tableList" : [ "public.large_user", "public.large_user_12001", "public.pg_test_xiaohe", "public.tb_user_log", "public.large_user_123w", "public.large_user_12", "public.large_user_12000", "public.tbl_order", "public.userinfo", "public.company", "public.moxian_orderamount_f_d", "public.xiao_he_color", "public.large_user_12312w", "public.department", "public.new_company1", "public.large_user_12313", "public.large_user_1200", "public.large_user_1223w", "public.tb_user_info", "public.audit", "public.large_user_123", "public.large_user_1231", "public.task_init", "public.task_hist", "public.large_user_12222313", "public.sidetestthree", "public.zd_cs", "public.alter", "public.zd_varying", "public.sidetesttwo", "public.alter1", "public.tabletest", "public.emqx", "public.xx_1", "public.resulttestone", "public.resultone", "public.emqx_zd", "public.myresult", "public.oracle_test", "public.oracle_110", "public.oracle_112", "public.st_cdctest_1119", "public.sftest1223", "public.tb_user", "public.sal_emp", "public.company_0621", "public.company_0621_001", "public.company_0621_002", "public.postgresql_input_test_basic", "public.postgresql_input_test_basic_1", "public.zd", "public.ultra", "public.tables", "public.large_user1103", "public.large_user1104", "public.large_user1108", "public.character_sets", "public.large_user1107", "public.large_user1109", "public.large_user1110", "public.large_user1111", "public.large_user111111", "public.large_user1212", "public.large_user121213", "public.large_user_12001111", "public.large_user_120011111111", "public.large_user_1200111111111111", "public.large_usefr", "public.lardxcge_user", "public.lardxcge_uxcser", "public.larzcvdxcge_uxcser", "public.large_user111001", "public.large_user12", "public.pgresult", "public.jier_test001", "public.source_112_postgresql_time_type_three", "public.source_112_postgresql_all_type_one", "public.stream_pg_one", "public.test_result_table_name_wavljbot", "public.test_result_table_name_ynubxjds", "public.test_result_table_name_bwcxigpv", "public.test_result_table_name_pcrbjmgu", "public.test_result_table_name_pwhackjm", "public.test_result_table_name_fgwkdcxj", "public.test_result_table_name_sednpuca", "public.test_result_table_name_mzosidgp", "public.test_result_table_name_yqktfbgo", "public.test_result_table_name_zquoeipy", "public.test_result_table_name_jkwiqsyg", "public.test_result_table_name_vpmzsgjo", "public.test_result_table_name_epfotjbn", "public.test_result_table_name_ghvqkdte", "public.test_result_table_name_xvuptfoj", "public.test_result_table_name_iescqrtw", "public.stream_pg_five", "public.test_result_table_name_fohcupzn", "public.test_result_table_name_ycotuznr", "public.test_result_table_name_dosbfaqt", "public.test_result_table_name_fsejzayu", "public.test_result_table_name_zblmauvo" ],
          "allowCreateSlot" : true,
          "pavingData" : false,
          "url" : "jdbc:postgresql://172.16.101.246:5432/postgres",
          "username" : "dtstack_rep"
        },
        "name" : "pgwalreader"
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "dataCompelOrder" : false,
          "topic" : "fanshu7"
        },
        "name" : "kafkawriter",
        "type" : 37
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

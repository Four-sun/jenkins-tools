{
  "job" : {
    "content" : [ {
      "nameMapping" : {
        "identifierMappings" : {
          "fanshu2" : "fanshu7",
          "test_topic_name_gcwfybte" : "test_topic_name_fuaetrsy",
          "test_topic_name_wtzaudhp" : "test_topic_name_qalphzym",
          "test_topic_vxfuomzp" : "test_topic_name_orzhjcma",
          "test_topic_name_wpclmfys" : "test_topic_name_pwfyagbr",
          "test_topic_name_bxronphj" : "test_topic_name_nrjaxdbe",
          "test_topic_name_rlwugjzp" : "test_result_table_name_infkroxt",
          "test_topic_name_ljhgiszu" : "test_topic_name_wyuhxlbe",
          "test_topic_name_fszotwgh" : "test_topic_name_yifwangr",
          "test_topic_name_qpbjyslo" : "test_topic_chknestj",
          "test_result_table_name_bzkrfxnq" : "test_topic_name_lypwqjdh",
          "test_topic_name_tcmibgpz" : "test_topic_pdzgtesn",
          "test_topic_enxwdpio" : "test_topic_bkfisprq",
          "test_topic_name_avqlmhsc" : "test_topic_name_draguhlp",
          "test_topic_name_ltjnebzc" : "test_topic_name_zgqyiudx",
          "test_topic_name_gcwfybte1" : "test_topic_name_rzsjaxmn"
        }
      },
      "reader" : {
        "parameter" : {
          "mode" : "latest-offset",
          "codec" : "json",
          "topics" : [ "fanshu2", "test_topic_name_gcwfybte", "test_topic_name_wtzaudhp", "test_topic_name_bxronphj", "test_topic_name_rlwugjzp", "test_topic_name_qpbjyslo", "test_result_table_name_bzkrfxnq", "test_topic_name_tcmibgpz", "test_topic_enxwdpio", "test_topic_name_avqlmhsc", "test_topic_name_ltjnebzc", "test_topic_name_gcwfybte1", "test_topic_vxfuomzp", "test_topic_name_wpclmfys", "test_topic_name_ljhgiszu", "test_topic_name_fszotwgh" ],
          "groupId" : "default",
          "componentVersion" : "1.12",
          "consumerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092",
            "auto.commit.interval.ms" : "1000",
            "auto.offset.reset" : "latest"
          },
          "addMessage" : false
        },
        "name" : "kafkareader"
      },
      "writer" : {
        "parameter" : {
          "producerSettings" : {
            "zookeeper.connect" : "",
            "bootstrap.servers" : "172.16.100.109:9092"
          },
          "topics" : [ "fanshu7", "test_topic_name_fuaetrsy", "test_topic_name_qalphzym", "test_topic_name_nrjaxdbe", "test_result_table_name_infkroxt", "test_topic_chknestj", "test_topic_name_lypwqjdh", "test_topic_pdzgtesn", "test_topic_bkfisprq", "test_topic_name_draguhlp", "test_topic_name_zgqyiudx", "test_topic_name_rzsjaxmn", "test_topic_name_orzhjcma", "test_topic_name_pwfyagbr", "test_topic_name_wyuhxlbe", "test_topic_name_yifwangr" ],
          "dataCompelOrder" : false
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

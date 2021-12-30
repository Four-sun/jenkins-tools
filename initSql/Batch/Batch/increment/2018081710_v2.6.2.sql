alter table rdos_batch_script modify column script_text LONGTEXT NOT NULL COMMENT '脚本内容';
alter table rdos_hive_table_action_record modify column action_sql LONGTEXT NOT NULL COMMENT '操作sql语句';
alter table rdos_batch_sql_text_temp modify column sql_text LONGTEXT NOT NULL COMMENT 'sql 文本';
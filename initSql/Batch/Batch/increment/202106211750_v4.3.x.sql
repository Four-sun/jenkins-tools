-- 删除hive_table_info索引，重新新建索引
alter table rdos_hive_table_info drop key idx;
alter table rdos_hive_table_info
	add constraint idx
		unique (project_id, table_name, table_type);

 -- 将rdos_hive_table_info已删除的数据移到rdos_hive_table_info_deleted表中
 REPLACE INTO rdos_hive_table_info_deleted
        (id,tenant_id,project_id,table_name,table_type,life_day,life_status,table_size,size_update_time,user_id,charge_user_id,path,
        catalogue_id,is_deleted,is_dirty_data_table,last_ddl_time,last_dml_time,table_desc,grade,subject,refresh_rate,
        incre_type,is_ignore,check_result,location,delim,store_type,modify_user_id)
    select id,tenant_id,project_id,table_name,table_type,life_day,life_status,table_size,size_update_time,user_id,charge_user_id,path,
    catalogue_id,is_deleted,is_dirty_data_table,last_ddl_time,last_dml_time,table_desc,grade,subject,refresh_rate,
    incre_type,is_ignore,check_result,location,delim,store_type,modify_user_id
    from rdos_hive_table_info where is_deleted = 1;
-- 删除 rdos_hive_table_info is_deleted = 1 的数据
delete from rdos_hive_table_info where is_deleted = 1;
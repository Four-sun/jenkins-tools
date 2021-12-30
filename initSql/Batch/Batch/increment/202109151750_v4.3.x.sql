BEGIN;

--  删除表的唯一索引，避免更新时报索引冲突
alter table rdos_role_user drop index `index_project_user_role`;

-- 为了避免更新报唯一索引冲突，先删除索引，后面再加回来
alter table rdos_batch_alarm_receive_user drop index `index_batch_alarm_receive_user`;
alter table rdos_batch_hive_table_collection drop index `project_id_user_id_table_id`;
alter table rdos_project_stick drop index `idx_project_user`;

--  更新所有表的tenant_id
update rdos_batch_alarm a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_alarm_receive_user a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_alarm_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_alarm_type a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_apply a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_catalogue a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1;

update rdos_batch_component a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_component_version a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_data_source a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_data_source_center a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_data_source_migration a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_data_source_migration_task a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_data_source_task_ref a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_dirty_data_count a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_function a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1;

update rdos_batch_function_resource a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_hive_select_sql a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_hive_table_collection a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_hive_table_column a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_hive_table_partition a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_hive_table_permission a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_model_column a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_model_monitor_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_model_rule a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1;

update rdos_batch_model_table a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1;

update rdos_batch_package a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_package_item a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_resource a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_script a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_table_relation a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1 and a.tenant_id<>0;

update rdos_batch_table_sync_log a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_table_table a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_task a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_task_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_task_resource a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_task_resource_shade a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_task_task a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.parent_apptype=1;

update rdos_batch_task_version a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_test_produce_data_source a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_test_produce_resource a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_batch_test_produce_task a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_datamask_columns_info a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_datamask_config a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_datamask_rule a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_file_merge_partition a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_file_merge_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_file_merge_rule a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_hive_catalogue a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_hive_table_action_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_hive_table_info a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_hive_table_info_deleted a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_notify a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_notify_alarm a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_notify_record a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_notify_user a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_project a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_project_engine a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_project_stick a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_read_write_lock a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_role a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0 and a.tenant_id<>-1;

update rdos_role_permission a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_role_user a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_table_project_data_history a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_user_column_permission a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rdos_user_operator_permission a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id
where a.is_deleted=0;

update rods_project_job_setting a
left join rdos_tenant b on b.id=a.tenant_id and b.is_deleted=0
set a.tenant_id=b.dtuic_tenant_id;



--  更新所有表的uic_user_id
update rdos_batch_alarm_receive_user a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_apply a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_hive_select_sql a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_hive_table_collection a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_hive_table_permission a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_hive_table_action_record a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_hive_table_info a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
left join rdos_user d on d.id=a.charge_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.user_id=c.dtuic_user_id, a.charge_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_hive_table_info_deleted a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
left join rdos_user d on d.id=a.charge_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.user_id=c.dtuic_user_id, a.charge_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_notify_user a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_role_user a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_user_column_permission a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;

update rdos_user_operator_permission a
left join rdos_user c on c.id=a.user_id and c.is_deleted=0
set a.user_id=c.dtuic_user_id
where a.is_deleted=0;


--  更新所有表的create_user_id和modified_user_id
update rdos_batch_alarm a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_catalogue a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0 and a.create_user_id<>0;

update rdos_batch_component a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
left join rdos_user f on f.id=a.owner_user_id and f.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id, a.owner_user_id=f.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_component_version a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
left join rdos_user f on f.id=a.owner_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id, a.owner_user_id=f.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_data_source a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_data_source_center a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_data_source_migration a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_function a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_model_column a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_model_rule a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_model_table a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_package a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_resource a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_script a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_table_sync_log a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_task a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
left join rdos_user f on f.id=a.owner_user_id and f.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id, a.owner_user_id=f.dtuic_user_id
where a.is_deleted=0;

update rdos_batch_task_version a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_file_merge_record a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_file_merge_rule a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_hive_catalogue a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_notify a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0 and a.create_user_id<>0;

update rdos_project a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_project_engine a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_project_stick a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_read_write_lock a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_role a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_role_permission a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_role_user a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_tenant a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
set a.create_user_id=d.dtuic_user_id
where a.is_deleted=0;

update rdos_user_column_permission a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rdos_user_operator_permission a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id
where a.is_deleted=0;

update rods_project_job_setting a
left join rdos_user d on d.id=a.create_user_id and d.is_deleted=0
left join rdos_user e on e.id=a.modify_user_id and e.is_deleted=0
set a.create_user_id=d.dtuic_user_id, a.modify_user_id=e.dtuic_user_id;

-- 将索引加回来
alter table rdos_batch_alarm_receive_user ADD UNIQUE index `index_batch_alarm_receive_user`(`alarm_id`, `user_id`, `project_id`) USING BTREE;
alter table rdos_batch_hive_table_collection ADD UNIQUE index `project_id_user_id_table_id`(`project_id`, `user_id`, `table_id`) USING BTREE;
alter table rdos_project_stick ADD UNIQUE index `idx_project_user`(`project_id`, `create_user_id`) USING BTREE;

-- 修改dag相关表的租户id
UPDATE dagschedulex.schedule_job SET `tenant_id` = `dtuic_tenant_id`  WHERE `app_type` = 1;
UPDATE dagschedulex.schedule_job_job SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 1;
UPDATE dagschedulex.schedule_task_shade SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 1;
UPDATE dagschedulex.schedule_fill_data_job SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 1;
UPDATE dagschedulex.schedule_task_task_shade SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 1;

COMMIT;

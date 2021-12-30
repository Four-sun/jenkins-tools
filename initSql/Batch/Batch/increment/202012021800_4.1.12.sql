START TRANSACTION;

-- 更新告警规则
UPDATE rdos_batch_alarm r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新告警接收人
UPDATE rdos_batch_alarm_receive_user r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新告警记录
UPDATE rdos_batch_alarm_record r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新数据地图权限申请记录	
UPDATE rdos_batch_apply r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新目录	
UPDATE rdos_batch_catalogue r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新数据源
UPDATE rdos_batch_data_source r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新整库同步配置规则
UPDATE rdos_batch_data_source_migration r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新整库同步
UPDATE rdos_batch_data_source_migration_task r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新任务
UPDATE rdos_batch_data_source_task_ref r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新脏数据统计
UPDATE rdos_batch_dirty_data_count r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新脏数据血缘
UPDATE rdos_batch_fill_data_relation r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新函数
UPDATE rdos_batch_function r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新函数资源
UPDATE rdos_batch_function_resource r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新函数资源
UPDATE rdos_batch_hive_select_sql r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
 
-- 更新sql查询临时表
UPDATE rdos_hive_table_info_deleted r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新分区信息
UPDATE rdos_batch_hive_table_partition r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新字段名模型
UPDATE rdos_batch_model_column r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新模型指标
UPDATE rdos_batch_model_monitor_record r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新模型指标
UPDATE rdos_batch_model_rule r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新模型表
UPDATE rdos_batch_model_table r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新发布包
UPDATE rdos_batch_package r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新发布包内容
UPDATE rdos_batch_package_item r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新资源
UPDATE rdos_batch_resource r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新脚本
UPDATE rdos_batch_script r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新表操作记录
UPDATE rdos_hive_table_action_record r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新表收藏记录
UPDATE rdos_batch_hive_table_collection r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新表名模型检测
UPDATE rdos_batch_hive_table_column r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新建的表
UPDATE rdos_hive_table_info r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新权限校验
UPDATE rdos_batch_hive_table_permission r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新统计数量
UPDATE rdos_table_project_data_history r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;

-- 更新表血缘
UPDATE rdos_batch_table_relation r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新整库同步日志
UPDATE rdos_batch_table_sync_log r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新血缘表关系
UPDATE rdos_batch_table_table r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务
UPDATE rdos_batch_task r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务记录
UPDATE rdos_batch_task_record r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务资源
UPDATE rdos_batch_task_resource r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务资源
UPDATE rdos_batch_task_resource_shade r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务
UPDATE rdos_batch_task_shade r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新子任务
UPDATE rdos_batch_task_task r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务版本
UPDATE rdos_batch_task_version r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新脱敏字段配置
UPDATE rdos_datamask_columns_info r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新脱敏配置
UPDATE rdos_datamask_config r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新脱敏规则配置
UPDATE rdos_datamask_rule r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新任务成功失败统计
UPDATE rdos_batch_job_state_count r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新通知
UPDATE rdos_notify r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新通知记录
UPDATE rdos_notify_alarm r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新消息记录
UPDATE rdos_notify_record r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新通知用户
UPDATE rdos_notify_user r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新项目引擎
UPDATE rdos_project_engine r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新项目置顶
UPDATE rdos_project_stick r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新锁信息
UPDATE rdos_read_write_lock r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新用户角色
UPDATE rdos_role r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新用户
UPDATE rdos_role_user r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新表字段权限申请字段
UPDATE rdos_user_column_permission r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;
	
-- 更新权限申请操作记录
UPDATE rdos_user_operator_permission r
LEFT JOIN rdos_project p ON r.project_id = p.id 
SET r.is_deleted = 1, r.gmt_modified = now() 
WHERE
	p.is_deleted = 1 
	AND r.is_deleted = 0;


COMMIT;
	

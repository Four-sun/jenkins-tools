begin ;
-- 删除索引影响到的索引（后面再添加回来）
ALTER TABLE `science_hive_table_info`
DROP INDEX `idx`;
ALTER TABLE `science_project_stick`
DROP INDEX `idx_project_user`;
ALTER TABLE `science_role_user`
DROP INDEX `index_project_user_role`;
-- 算法迁移权限中心
--  更新所有表的tenant_id、user_id、create_user_id、modified_user_id
UPDATE science_alarm a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_alarm a
    INNER JOIN science_user u1 ON a.create_by=u1.id
    SET a.create_by=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_alarm a
    INNER JOIN science_user u2 ON a.update_by=u2.id
    SET a.update_by=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_alarm_record a
    INNER JOIN
    (SELECT id,GROUP_CONCAT(dtuic_user_id SEPARATOR ',') dtuic_user_id
    FROM
    (SELECT a.id,a.receive_user,b.dtuic_user_id FROM
    (select a.id,substring_index(substring_index(a.receive_user, ',', b.help_topic_id + 1), ',', -1) receive_user
    from science_alarm_record a JOIN mysql.help_topic b
    ON b.help_topic_id < (length(a.receive_user) - length(REPLACE(a.receive_user, ',', '')) + 1)
    WHERE is_deleted=0)
    a INNER JOIN science_user b on a.receive_user=b.id) a
    GROUP BY id) b on a.id=b.id
    SET a.receive_user=b.dtuic_user_id;

UPDATE science_alarm_record a
    INNER JOIN science_tenant t on a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_alarm_rule a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_alarm_rule a
    INNER JOIN science_user u1 ON a.create_by=u1.id
    SET a.create_by=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_alarm_rule a
    INNER JOIN science_user u2 ON a.update_by=u2.id
    SET a.update_by=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_alarm_rule_receive_user a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_catalogue a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_catalogue a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_component a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_component a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_component a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_data_source_center a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_data_source_center a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_data_source_center a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_dependent_task_task a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_dependent_task_task a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_dependent_task_task a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_hive_select_sql a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_hive_select_sql a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_hive_table_info a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_hive_table_info a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_hive_table_info a
    INNER JOIN science_user u2 ON a.charge_user_id=u2.id
    SET a.charge_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_hive_table_info a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_job a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_job a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_model a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_model a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_model_op a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_model_op a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_model_op a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_model_service a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_model_service a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_model_service a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_model_task_relation a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_model_version a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_model_version a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_model_version_param a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_model_version_param a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_notify a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_notify a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_notify_alarm a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_notify_record a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_notify_user a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_notify_user a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_package a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_package a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_package a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_package a
    INNER JOIN science_user u3 ON a.publish_user_id=u3.id
    SET a.publish_user_id=u3.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_package_item a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_package_item a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_package_item a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_project a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_project a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_project_engine a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_project_hit a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_project_stick a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_project_stick a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_read_write_lock a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_resource a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_resource a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_resource a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_role a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_role a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_role_user a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_role_user a
    INNER JOIN science_user u1 ON a.user_id=u1.id
    SET a.user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_task a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_task a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task a
    INNER JOIN science_user u3 ON a.owner_user_id=u3.id
    SET a.owner_user_id=u3.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_task_batch a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_task_batch a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task_batch a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task_batch a
    INNER JOIN science_user u3 ON a.owner_user_id=u3.id
    SET a.owner_user_id=u3.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_task_resource a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_task_resource_shade a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_task_save_version a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task_save_version a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_task_shade a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_task_shade a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task_shade a
    INNER JOIN science_user u2 ON a.modify_user_id=u2.id
    SET a.modify_user_id=u2.dtuic_user_id
WHERE a.is_deleted=0;
UPDATE science_task_shade a
    INNER JOIN science_user u3 ON a.owner_user_id=u3.id
    SET a.owner_user_id=u3.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_task_task a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;

UPDATE science_task_version a
    INNER JOIN science_tenant t ON a.tenant_id=t.id
    SET a.tenant_id=t.dtuic_tenant_id
WHERE a.is_deleted=0;
UPDATE science_task_version a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

UPDATE science_tenant a
    INNER JOIN science_user u1 ON a.create_user_id=u1.id
    SET a.create_user_id=u1.dtuic_user_id
WHERE a.is_deleted=0;

-- 恢复之前删掉的索引
ALTER TABLE `science_hive_table_info`
    ADD UNIQUE INDEX `idx`(`tenant_id`, `project_id`, `table_name`(128), `table_type`) USING BTREE;
ALTER TABLE `science_project_stick`
    ADD UNIQUE INDEX `idx_project_user`(`project_id`, `user_id`) USING BTREE;
ALTER TABLE `science_role_user`
    ADD UNIQUE INDEX `index_project_user_role`(`project_id`, `user_id`, `role_id`) USING BTREE;

-- 修改dag相关表的租户id
UPDATE dagschedulex.schedule_job SET `tenant_id` = `dtuic_tenant_id`  WHERE `app_type` = 8;
UPDATE dagschedulex.schedule_job_job SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 8;
UPDATE dagschedulex.schedule_task_shade SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 8;
UPDATE dagschedulex.schedule_fill_data_job SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 8;
UPDATE dagschedulex.schedule_task_task_shade SET `tenant_id` = `dtuic_tenant_id` WHERE `app_type` = 8;


-- 权限中心迁移-历史数据迁移
--  注意，这里的SQL有执行顺序要求，必须按照顺序执行
--  1.角色表
DELETE FROM `dt_pub_service`.`auth_role` where app_type = 8 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `create_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `old_role_id`)
select 8, tenant_id, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `id`
from `science_role`
where is_deleted=0;

--  2.权限表
DELETE FROM `dt_pub_service`.`auth_permission` where app_type=8 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_permission`(`old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`)
select `id`, 8, `code`, `name`, `display`, `parent_id`, `type`, `gmt_create`, `gmt_modified`, `is_deleted`
from `science_permission`
where is_deleted=0;

-- 更新权限表的parent_id
update `dt_pub_service`.`auth_permission` a
    inner join `dt_pub_service`.`auth_permission` b on a.parent_id=b.old_permission_id and b.app_type=8 and b.is_deleted=0
    set a.parent_id = b.id
where a.is_deleted = 0 and a.app_type = 8;

--  3.用户角色表
DELETE FROM `dt_pub_service`.`auth_role_user` where app_type=8 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_user`( `app_type`, `dtuic_tenant_id`, `project_id`, `role_id`, `dtuic_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`)
select 8, a.`tenant_id`, a.`project_id`, e.id as role_id, a.`user_id`, a.`gmt_create`, a.`gmt_modified`, a.`is_deleted`, null , null
from `science_role_user` a
         inner join `dt_pub_service`.`auth_role` e on e.old_role_id = a.role_id and e.app_type=8 and e.is_deleted=0
where a.is_deleted=0;

--  4.角色权限表
DELETE FROM `dt_pub_service`.`auth_role_permission` where app_type=8 and is_deleted=0;
INSERT INTO `dt_pub_service`.`auth_role_permission`( `app_type`, `role_id`, `permission_id`, `gmt_create`, `gmt_modified`, `is_deleted`, `modify_user_id`, `create_user_id`, `dtuic_tenant_id`, `project_id`)
SELECT 8, e.id as role_id, f.id as permission_id, a.`gmt_create`, a.`gmt_modified`, 0, null , null , r.`tenant_id`, r.`project_id`
from (SELECT role_id,permission_id,gmt_create,gmt_modified
      from `science_role_permission` a WHERE a.is_deleted=0 GROUP BY role_id,permission_id) a
         INNER JOIN `dt_pub_service`.`auth_role` e on e.old_role_id = a.role_id and e.app_type=8 and e.is_deleted=0
         inner join `dt_pub_service`.`auth_permission` f on f.old_permission_id = a.permission_id and f.app_type=8 and f.is_deleted=0
         inner join science_role r on r.id=a.role_id;

--  5.将算法用到的user和tenant迁移到业务中心
INSERT IGNORE INTO `dt_pub_service`.`ps_user` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_user_id`,
  `user_name`,
  `user_email`,
  `user_status`,
  `phone_number`)
SELECT
    `gmt_create`,
    `gmt_modified`,
    null,
    null,
    0,
    `dtuic_user_id`,
    `user_name`,
    `email`,
    `status`,
    `phone_number`
FROM science_user
where is_deleted=0;

INSERT IGNORE INTO `dt_pub_service`.`ps_tenant` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_tenant_id`,
  `tenant_name`,
  `tenant_desc`,
  `tenant_status`)
SELECT
    `gmt_create`,
    `gmt_modified`,
    null,
    null,
    `is_deleted`,
    `dtuic_tenant_id`,
    `tenant_name`,
    `tenant_desc`,
    `status`
FROM science_tenant
where is_deleted=0;

-- 表生命周期迁移-删掉不用的定时任务
DELETE FROM dt_center_cron_schedule WHERE job_trigger_name in('dataSciencePeriodDataCleanJobScheduleJobTrigger','dataScienceTableLifecycleJobTrigger');

DELETE FROM qrtz_cron_triggers WHERE TRIGGER_NAME in('dataSciencePeriodDataCleanJobScheduleJobTrigger','dataScienceTableLifecycleJobTrigger');

DELETE FROM qrtz_triggers WHERE TRIGGER_NAME in('dataSciencePeriodDataCleanJobScheduleJobTrigger','dataScienceTableLifecycleJobTrigger');

DELETE FROM qrtz_job_details WHERE JOB_NAME in('dataSciencePeriodDataCleanJob','dataScienceTableLifecycleJob');
commit ;
ALTER TABLE dl_group ADD is_publish TINYINT(1) DEFAULT '-1' COMMENT '是否上下线 0:下线,1:上线';
ALTER TABLE dl_group CHANGE is_publish is_publish TINYINT(1) DEFAULT '-1' COMMENT '是否上下线 0:下线,1:上线' AFTER is_open_api;
update dl_group set is_publish = 1;

ALTER TABLE dl_group ADD publish_time DATETIME NULL COMMENT '发布时间';
ALTER TABLE dl_group CHANGE publish_time publish_time DATETIME NULL COMMENT '发布时间' AFTER is_publish;

ALTER TABLE dl_group ADD computing_time DATETIME NULL COMMENT '计算时间';
ALTER TABLE dl_group CHANGE computing_time computing_time DATETIME NULL COMMENT '计算时间' AFTER publish_time;

ALTER TABLE dl_group ADD growth_num int(11) DEFAULT 0 NOT NULL COMMENT '增长量';
ALTER TABLE dl_group CHANGE growth_num growth_num int(11) DEFAULT 0 NOT NULL COMMENT '增长量' AFTER group_data_count;

ALTER TABLE dl_group MODIFY COLUMN group_data_count int(11) DEFAULT 0 NULL COMMENT '群组数据量（刷新 或 统计）';

INSERT INTO dt_center_cron_schedule (job_detail_name,job_detail_group,job_trigger_name,job_trigger_group,class_name,cron,concurrent,start_time,end_time,biz_type,gmt_create,gmt_modified,is_deleted) VALUES
('tagValueJob','tagValueJob','tagValueJob','tagValueJob','com.dtstack.tagapp.param.schedule.impl.TagValueQuartz','0 0 3 * * ?',0,NULL,NULL,'TAG',now(),now(),0)
;

INSERT INTO dt_center_cron_schedule (job_detail_name,job_detail_group,job_trigger_name,job_trigger_group,class_name,cron,concurrent,start_time,end_time,biz_type,gmt_create,gmt_modified,is_deleted) VALUES
('groupJob','groupJob','groupJob','groupJob','com.dtstack.tagapp.param.schedule.impl.GroupQuartz','0 0 4 * * ?',0,NULL,NULL,'TAG',now(),now(),0)
;

INSERT INTO dt_center_cron_schedule (job_detail_name,job_detail_group,job_trigger_name,job_trigger_group,class_name,cron,concurrent,start_time,end_time,biz_type,gmt_create,gmt_modified,is_deleted) VALUES
('tagPublishCountJob','tagPublishCountJob','tagPublishCountJob','tagPublishCountJob','com.dtstack.tagapp.param.schedule.impl.TagPublishCountQuartz','0 0 0 */1 * ?',0,NULL,NULL,'TAG',now(),now(),0)
;

INSERT INTO dt_center_cron_schedule (job_detail_name,job_detail_group,job_trigger_name,job_trigger_group,class_name,cron,concurrent,start_time,end_time,biz_type,gmt_create,gmt_modified,is_deleted) VALUES
('groupExceptionJob','groupExceptionJob','groupExceptionJob','groupExceptionJob','com.dtstack.tagapp.param.schedule.impl.GroupExceptionQuartz','0 0 5 * * ?',0,NULL,NULL,'TAG',now(),now(),0)
;

ALTER TABLE dl_group ADD group_status TINYINT(1) DEFAULT 0 NULL COMMENT '0：正常，1：异常';
ALTER TABLE dl_group CHANGE group_status group_status TINYINT(1) DEFAULT 0 NULL COMMENT '0：正常，1：异常' AFTER group_store_type;

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (77,'tag_center_tag_config_tag_panorama','标签中心_标签管理_标签全景','标签全景',41);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (78,'group_analysis_manage_group_publish','群组分析_群组管理_群组发布','发布',65);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 77, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 77) and role_value in (1,2,3,4,6,7);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 78, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 78) and role_value in (1,2,3,4,6,7);

DELETE FROM  dl_tag_task_task WHERE is_deleted = 1;



delete from dl_role_permission;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 1) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 7) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from
(select id from  dl_role where role_value = 2) a ,
(select id  from dl_permission where id not in (1) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from
(select id  from dl_role where role_value = 3) a ,
(select id  from dl_permission where id not in (1) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 4) a ,
(select  id from dl_permission where id not in(1,5,6,7,10,17,18,19,20,21,22,23,24,25,26,27,28,29,30,35,36,37,38,39,40,41,42,43,44,45,46,47,51,52,53,54,55,56,57,58,59,60,61,62,63)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 5) a ,
(select id from dl_permission where id not in(1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,34,36,37,38,39,40,43,44,45,46,47,50,51,55,58,59,62,63,67,68,70,71,74,75,76,77,78)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 6) a ,
(select  id from dl_permission where id not in (1,5,6,7,10,17)  and is_deleted = 0) b;
CREATE TABLE `dl_tag_schedule_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `group_id` int(11) DEFAULT NULL COMMENT '群组字段',
  `schedule_type` tinyint(4) DEFAULT NULL COMMENT '跑批类型 0:原子 1:衍生 2:圈群 3:组合',
  `last_schedule_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上一次调度时间',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='定时任务记录';

-- 任务调度表


CREATE TABLE `dt_center_cron_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_detail_name` varchar(255) NOT NULL COMMENT 'job名称',
  `job_detail_group` varchar(255) NOT NULL COMMENT 'job group 名称',
  `job_trigger_name` varchar(255) NOT NULL COMMENT 'job trigger 名称',
  `job_trigger_group` varchar(255) NOT NULL COMMENT 'job trigger group 名称',
  `class_name` varchar(255) NOT NULL COMMENT '任务执行类名称',
  `cron` varchar(255) NOT NULL COMMENT 'cron 表达式',
  `concurrent` tinyint(1) NOT NULL COMMENT '0: false, 1:true',
  `start_time` datetime COMMENT '开始时间',
  `end_time` datetime  COMMENT '结束时间',
  `biz_type` VARCHAR(255) NOT NULL COMMENT '任务业务类型',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_job_name` (`job_detail_name`, `job_detail_group`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- quartz自带表

CREATE TABLE QRTZ_JOB_DETAILS(
SCHED_NAME VARCHAR(120) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
JOB_CLASS_NAME VARCHAR(250) NOT NULL,
IS_DURABLE VARCHAR(1) NOT NULL,
IS_NONCONCURRENT VARCHAR(1) NOT NULL,
IS_UPDATE_DATA VARCHAR(1) NOT NULL,
REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
NEXT_FIRE_TIME BIGINT(13) NULL,
PREV_FIRE_TIME BIGINT(13) NULL,
PRIORITY INTEGER NULL,
TRIGGER_STATE VARCHAR(16) NOT NULL,
TRIGGER_TYPE VARCHAR(8) NOT NULL,
START_TIME BIGINT(13) NOT NULL,
END_TIME BIGINT(13) NULL,
CALENDAR_NAME VARCHAR(200) NULL,
MISFIRE_INSTR SMALLINT(2) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
REPEAT_COUNT BIGINT(7) NOT NULL,
REPEAT_INTERVAL BIGINT(12) NOT NULL,
TIMES_TRIGGERED BIGINT(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CRON_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
CRON_EXPRESSION VARCHAR(120) NOT NULL,
TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_CALENDARS (
SCHED_NAME VARCHAR(120) NOT NULL,
CALENDAR_NAME VARCHAR(200) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
ENGINE=InnoDB;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
ENTRY_ID VARCHAR(95) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
FIRED_TIME BIGINT(13) NOT NULL,
SCHED_TIME BIGINT(13) NOT NULL,
PRIORITY INTEGER NOT NULL,
STATE VARCHAR(16) NOT NULL,
JOB_NAME VARCHAR(200) NULL,
JOB_GROUP VARCHAR(200) NULL,
IS_NONCONCURRENT VARCHAR(1) NULL,
REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
ENGINE=InnoDB;

CREATE TABLE QRTZ_SCHEDULER_STATE (
SCHED_NAME VARCHAR(120) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
CHECKIN_INTERVAL BIGINT(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
ENGINE=InnoDB;

CREATE TABLE QRTZ_LOCKS (
SCHED_NAME VARCHAR(120) NOT NULL,
LOCK_NAME VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
ENGINE=InnoDB;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);

commit;

ALTER TABLE dl_group ADD group_file_name varchar(255) NULL COMMENT '群组上传文件名';
ALTER TABLE dl_group CHANGE group_file_name group_file_name varchar(255) NULL COMMENT '群组上传文件名' AFTER group_desc;

INSERT INTO dt_center_cron_schedule (job_detail_name,job_detail_group,job_trigger_name,job_trigger_group,class_name,cron,concurrent,start_time,end_time,biz_type,gmt_create,gmt_modified,is_deleted) VALUES
('tagJob','tagJob','tagJob','tagJob','com.dtstack.tagapp.param.schedule.impl.TagQuartz','* */30 * * * ?',0,NULL,NULL,'TAG','2020-11-02 10:34:57.0','2020-11-02 10:34:57.0',0)
;

INSERT INTO dl_role( project_id , tenant_id , role_name , role_type , role_value , role_desc ,create_at,update_at,create_by,update_by,is_deleted)
select id,tenant_id,'数据开发',1,6,'拥有标签体系建设中需要的一切操作权限，但不能管理项目及项目成员',now(),now(),dp.create_by,dp.update_by,0 from dl_project dp where dp.id not in(
select project_id from dl_role where role_value = 6 and is_deleted = 0
) and is_deleted = 0;

INSERT INTO dl_role( project_id , tenant_id , role_name , role_type , role_value , role_desc ,create_at,update_at,create_by,update_by,is_deleted)
select id,tenant_id,'租户管理员',1,7,'本项目内的全部权限，具有本项目内的最高权限',now(),now(),dp.create_by,dp.update_by,0 from dl_project dp where dp.id not in(
select project_id from dl_role where role_value = 7 and is_deleted = 0
) and is_deleted = 0;

delete from dl_role_permission;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 1) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 7) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from
(select id from  dl_role where role_value = 2) a ,
(select id  from dl_permission where id not in (1,5) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from
(select id  from dl_role where role_value = 3) a ,
(select id  from dl_permission where id not in (1,5) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 4) a ,
(select  id from dl_permission where id not in(1,5,6,7,10,17,18,19,20,21,22,23,24,25,26,27,28,29,30,35,36,37,38,39,40,41,42,43,44,45,46,47,51,52,53,54,55,56,57,58,59,60,61,62,63)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 5) a ,
(select id from dl_permission where id not in(1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,34,36,37,38,39,40,43,44,45,46,47,50,51,55,58,59,62,63,67,68,70,71,74,75,76)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 6) a ,
(select  id from dl_permission where id not in (1,5,6,7,10,17)  and is_deleted = 0) b;

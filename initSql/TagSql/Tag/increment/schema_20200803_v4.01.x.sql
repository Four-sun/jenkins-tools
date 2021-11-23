ALTER TABLE dl_tag ADD tag_identifier varchar(128) NULL COMMENT '标签标识';
ALTER TABLE dl_tag CHANGE tag_identifier tag_identifier varchar(128) NULL COMMENT '标签标识' AFTER tag_name;

ALTER TABLE dl_entity ADD entity_identifier varchar(128) NULL COMMENT '实体标识';
ALTER TABLE dl_entity CHANGE entity_identifier entity_identifier varchar(128) NULL COMMENT '实体标识' AFTER entity_name;

ALTER TABLE dl_entity ADD entity_partition_filed varchar(128) NULL COMMENT '分区字段';
ALTER TABLE dl_entity CHANGE entity_partition_filed entity_partition_filed varchar(128) NULL COMMENT '分区字段' AFTER entity_desc;
ALTER TABLE dl_entity ADD entity_partition_format varchar(128) NULL COMMENT '分区格式';
ALTER TABLE dl_entity CHANGE entity_partition_format entity_partition_format varchar(128) NULL COMMENT '分区格式' AFTER entity_partition_filed;
ALTER TABLE dl_entity ADD entity_current_partition varchar(128) NULL COMMENT '当前分区';
ALTER TABLE dl_entity CHANGE entity_current_partition entity_current_partition varchar(128) NULL COMMENT '当前分区' AFTER entity_partition_format;

ALTER TABLE dl_use_tag_rel CHANGE use_tag_Id use_tag_id int(11) NOT NULL COMMENT '使用标签id';

ALTER TABLE dl_tag ADD use_tag_value TINYINT(1) DEFAULT 0 NOT NULL COMMENT '是否可以使用标签值查询 0 使用dsl查询 1:使用标签值查询';
ALTER TABLE dl_tag CHANGE use_tag_value use_tag_value TINYINT(1) DEFAULT 0 NOT NULL COMMENT '是否可以使用标签值查询 0 使用dsl查询 1:使用标签值查询' AFTER tag_desc;

CREATE TABLE dl_table_sync (
	id                              int(11)         NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id                       int(11)         NOT NULL COMMENT '租户id',
    project_id                      int(11)         NOT NULL COMMENT '项目id',
    entity_id                       int(11)         NOT NULL COMMENT '实体id',
    group_id                        int(11)         COMMENT '群组字段',
    entity_partition_filed          varchar(255)     COMMENT '实体分区字段',
    entity_partition_filed_format   varchar(64)     COMMENT '实体分区字段格式',
    entity_current_partition        varchar(255)     COMMENT '实体当前分区',
    sync_type                       tinyint(1)      COMMENT '同步类型 1:original 2:derived 3:combined',
    sync_table_name                 varchar(255)    COMMENT '同步名称',
    sync_table_name_cn              varchar(255)    COMMENT '同步中文名',
    sync_table_name_desc            varchar(255)    COMMENT '同步描述',
    sync_partition_filed            varchar(255)     COMMENT '同步分区字段',
    sync_partition_filed_format     varchar(64)     COMMENT '同步分区字段格式',
    sync_current_partition          varchar(255)     COMMENT '同步当前分区',
    sync_period_type                tinyint(1)      COMMENT '0:分钟 1:小时 2:天 3:星期 4:月',
    sync_week_day                   varchar(64)      COMMENT '每周几',
    sync_day                        varchar(64)      COMMENT '每月几号',
    sync_hour                       varchar(64)      COMMENT '小时',
    sync_minute                     varchar(64)      COMMENT '分钟',
    create_at                       datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	update_at                       datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  	create_by                       int(11)         NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by                       int(11)         NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted                      tinyint(1)      NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表分区同步表';


insert into dl_use_tag_rel(tenant_id ,project_id ,tag_id ,use_tag_id ,create_at ,update_at ,create_by ,update_by ,is_deleted )
(select
ddtr.tenant_id,dt.project_id ,ddtr.derive_tag_id as tag_id,ddtr.atom_tag_id  as use_tag_id,ddtr.create_at ,now() as update_at,ddtr.create_by , ddtr.update_by ,ddtr.is_deleted
from dl_derive_tag_rel ddtr
left join dl_tag dt on ddtr.atom_tag_id = dt.id) ;

ALTER TABLE dl_group ADD group_store_type tinyint(1) NULL COMMENT ' 0：实时群组 1：动态群组 2:静态群组';
ALTER TABLE dl_group CHANGE group_store_type group_store_type tinyint(1) NULL COMMENT ' 0：实时群组 1：动态群组 2:静态群组' AFTER group_type;

ALTER TABLE dl_group ADD group_identifier varchar(64) NULL COMMENT '群组标识';
ALTER TABLE dl_group CHANGE group_identifier group_identifier varchar(64) NULL COMMENT '群组标识' AFTER group_name;

CREATE TABLE `dl_tag_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `group_id` int(11) DEFAULT NULL COMMENT '群组id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `tag_type` tinyint(1) NOT NULL COMMENT '标签类型 0 原子标签,1 衍生标签 2 群组 3组合标签',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 0 sql,1 mr 2 数据同步',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0 flink, 1 spark',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` longtext NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `schedule_conf` varchar(2048) NOT NULL COMMENT '调度配置 json格式',
  `period_type` tinyint(2) DEFAULT NULL COMMENT '周期类型',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  `submit_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
  `submit_time` datetime NOT NULL  COMMENT '提交时间',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人id',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `task_desc` varchar(256) NOT NULL,
  `main_class` varchar(256) NOT NULL,
  `exe_args` text,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '标签任务表';


CREATE TABLE `dl_tag_task_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL COMMENT '实体id',
  `task_id` int(11) NOT NULL COMMENT 'batch 任务id',
  `parent_task_id` int(11) DEFAULT NULL COMMENT '对应batch任务父节点的id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_batch_task_task` (`project_id`,`parent_task_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `dl_tag_task_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `task_id` int(11) NOT NULL COMMENT '父文件夹id',
  `origin_sql` longtext COMMENT '原始sql',
  `sql_text` longtext NOT NULL COMMENT 'sql 文本',
  `publish_desc` text NOT NULL COMMENT '任务参数',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
  `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '标签任务版本表';



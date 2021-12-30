-- 1.数据源中心关联表
CREATE TABLE `assets_data_source_center` (
 `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
 `create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
 `update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
 `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
 `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
 `tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
 `dt_center_source_id` BIGINT(20) NULL DEFAULT NULL COMMENT '数据源中心id',
 `dt_center_source_name` varchar(128) NULL DEFAULT NULL COMMENT '数据源中心名称',
 `dtuic_tenant_id` int(11) DEFAULT NULL COMMENT 'UIC租户id',
 `data_source_name` VARCHAR(128) NULL DEFAULT NULL COMMENT '数据源名称',
 `data_source_desc` VARCHAR(255) NULL DEFAULT NULL COMMENT '数据源描述',
 `data_source_type` INT(11) NOT NULL COMMENT '数据源类型code,小于1000为系统数据源，小于1000为自定义数据源',
 `link_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0-连接失败,1-连接成功,2-同步中,3-初始化,-1-未知(自定义数据源专用)',
 `sync_status` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '1-同步结束，2-同步中',
 `sync_date` DATETIME NULL DEFAULT NULL COMMENT '最近同步时间',
 PRIMARY KEY (`id`)
) COMMENT = '数据源中心关联表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `assets_data_db` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`db_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '数据库名称',
	`db_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '数据库中文名',
	`db_desc` VARCHAR(255) NULL DEFAULT NULL COMMENT '数据库描述',
	`data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
	`data_source_type` INT(11) NOT NULL  COMMENT '冗余source.data_source_type',
	`sub_model_id` BIGINT(20) NULL DEFAULT NULL COMMENT '元模型id',
    `col_sub_model_id` bigint(20) NULL COMMENT '字段元模型ID',
	`db_storage` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '存储大小',
	`table_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表数量',
	`schema_count` bigint(20) NULL DEFAULT '0' COMMENT 'SQL Server架构数量',
	`use_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否配置 0 未配置 1已配置',
	`db_hot` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '数据库热度',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '数据库管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_data_table` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`table_name` VARCHAR(100) NOT NULL COMMENT '表名称',
	`table_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '表中文名',
	`data_source_type`  INT(11) NOT NULL  COMMENT '冗余source.data_source_type',
	`sub_model_id` BIGINT NULL DEFAULT NULL COMMENT '冗余db.sub_model_id',
	`data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
	`sync_status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '同步状态 0 未同步  1已同步',
	`db_id` BIGINT(20) NOT NULL COMMENT '数据库Id',
	`schema_name` VARCHAR(100) NULL DEFAULT NULL COMMENT 'GP数据源的结构为database-schema-table',
	`table_storage` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '容量大小',
	`table_owner` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表负责人',
	`table_hot` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表热度',
	`use_count`  BIGINT(20)  DEFAULT 0 COMMENT '使用次数',
	`affect_count` BIGINT(20) DEFAULT 0 COMMENT '影响表数',
    `has_lineage` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有血缘',
	`extra_attribute` json  NULL DEFAULT NULL COMMENT '表额外属性（业务属性） json字符串',
	`origin_table_id` VARCHAR(32) NULL DEFAULT NULL COMMENT '用于保存源数据表的 table_id 目前不用',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	`sync_date` DATETIME NULL DEFAULT NULL COMMENT '最近同步时间',
	`table_create_at` DATETIME NULL DEFAULT NULL COMMENT 'hive创建时间',
    PRIMARY KEY (`id`)
) COMMENT = '数据表管理' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_data_table_column` (
      `id` BIGINT (20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
      `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
      `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
      `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
      `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
      `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
      `column_name` VARCHAR (100) NOT NULL COMMENT '名称',
      `column_name_cn` VARCHAR (100) NULL COMMENT '中文名称',
      `column_desc` VARCHAR (255) NULL COMMENT '描述',
      `column_type` VARCHAR (255) NOT NULL DEFAULT '' COMMENT '字段类型',
      `column_order` SMALLINT(4) NOT NULL DEFAULT '0'  COMMENT '字段顺序标识',
      `table_id` BIGINT (20) NOT NULL COMMENT 'table表id ',
 	    `db_id` BIGINT (20) NOT NULL COMMENT '对应数据库id',
 	    `data_source_id` BIGINT (20) NOT NULL COMMENT '对应数据源id',
 	    `table_name`  VARCHAR(100) NOT NULL COMMENT '冗余table.table_name',
      `table_hot`  bigint(20)  NOT NULL DEFAULT '0' COMMENT '冗余table.table_hot',
      `table_storage`  bigint(20)  NOT NULL DEFAULT '0' COMMENT '冗余table.table_storage',
      `table_create_at`  DATETIME NULL DEFAULT NULL COMMENT '冗余table.table_create_at',
      `extra_attribute`  json  NULL DEFAULT NULL COMMENT '冗余table.extra_attribute',
      `table_owner`  bigint(20)  NULL DEFAULT NULL COMMENT '冗余table.table_owner',
      `data_source_type`  INT(11)  NULL DEFAULT NULL COMMENT '冗余source.data_source_type',
      `sub_model_id` BIGINT NULL DEFAULT NULL COMMENT '冗余db.sub_model_id',
      `col_sub_model_id` bigint(20) NULL COMMENT '字段元模型ID',
      `col_extra_attribute` json NULL COMMENT '字段属性（json字符串）',
      `affect_count` BIGINT(20) DEFAULT 0 COMMENT '影响表数',
     `is_partition` TINYINT (1) NULL DEFAULT 0 COMMENT '1表示分区字段，0表示普通字段',
     `tenant_id` BIGINT (20) NOT NULL COMMENT '租户id,用于租户隔离',
     PRIMARY KEY (`id`)
) COMMENT = '表字段表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_data_table_partition` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`part_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '分区名称',
    `file_group_name` varchar(100) DEFAULT NULL COMMENT '文件组名称',
	`partition_create_time` DATETIME NULL DEFAULT NULL COMMENT '分区创建时间',
	`partition_update_time` DATETIME NULL DEFAULT NULL COMMENT '分区更新时间',
	`row_count` BIGINT(20) NOT NULL COMMENT '分区数据行数',
	`table_id` BIGINT(20) NOT NULL COMMENT '表id',
	`db_id` BIGINT(20) NOT NULL COMMENT '对应数据库id',
	`data_source_id` BIGINT(20) NOT NULL COMMENT '对应数据源id',
	`partition_size` BIGINT(20) NULL DEFAULT NULL COMMENT '分区大小,单位byte',
	`file_number` BIGINT(20) NULL DEFAULT NULL COMMENT '文件数量',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = 'hive分区管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 表索引表
CREATE TABLE `assets_data_table_index` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` INT(11) NOT NULL DEFAULT 0 COMMENT '创建的用户',
  `update_by` INT(11) NOT NULL DEFAULT 0 COMMENT '修改的用户',
  `index_name` VARCHAR (100) NULL COMMENT '索引名称',
  `column_name` VARCHAR (100) NULL COMMENT '索引列名',
  `index_type` VARCHAR (100) NULL COMMENT '索引类型',
  `comment` VARCHAR (100) NULL COMMENT '索引注释',
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否删除,1-删除,0-未删除',
  `db_id` BIGINT (20) NULL COMMENT '数据库id',
  `table_id` BIGINT (20) NULL COMMENT '表id',
  `data_source_id` BIGINT(20) NOT NULL COMMENT '应数据源id',
  `tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
  PRIMARY KEY (`id`)
  )COMMENT = '索引表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 2.元模型相关
CREATE TABLE `assets_model_sub_management` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
    `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 0-表 1-字段',
	`sub_model_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '子模型名称',
	`sub_model_desc` VARCHAR(255) NULL DEFAULT NULL COMMENT '子模型描述',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '子模型管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_model_attribute` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
	`attribute_type` TINYINT(1) NOT NULL COMMENT '元模型属性类型,0表示技术属性 1表示`通用业务属性`,2表示`个性业务属性`',
    `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 0-表 1-字段',
	`sub_model_id` BIGINT(20) NULL DEFAULT NULL COMMENT '子模型ID,元模型属性为个性业务属性时起作用',
	`attribute_name` VARCHAR(100) NOT NULL COMMENT '元模型中 属性名',
	`attribute_name_cn` VARCHAR(100) NOT NULL COMMENT '元模型中 属性中文名',
	`field_type` TINYINT(1) NULL DEFAULT NULL COMMENT '字段属性,1-枚举,2-string类型文本,3-树形目录,4-bigint文本框,5-日期类型,6-varchar类型,7-存储大小',
	`is_required` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否必填项，0非必填，1必填',
	`is_preset` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否是预设字段，预设字段不可修改，0常规字段，1预设字段',
	`sort_order` TINYINT(1) NULL DEFAULT NULL COMMENT '排序字段',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '业务属性管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_model_attribute_value_set` (
    `id` BIGINT (20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  	`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  	`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  	`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
 	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `attribute_id` BIGINT (20) NOT NULL COMMENT '属性配置id assets_model_biz_attribute表 ID',
    `attribute_value` VARCHAR (255) NOT NULL COMMENT '属性值',
    `parent_id` BIGINT (20) NULL COMMENT '父节点id（树形目录时存在）',
 	`field_type` TINYINT (1) NULL COMMENT '字段属性，1表示枚举、2表示string文本、3表示树形目录、4 表示bigint文本框',
    `attribute_type` TINYINT (1) NULL COMMENT '元模型属性类型,0表示技术属性、1表示`通用业务属性`,2表示`个性业务属性` 冗余',
    `attribute_name` VARCHAR (100) NULL COMMENT '属性名称 冗余',
    `attribute_name_cn` VARCHAR (100) NULL COMMENT '属性中文名 冗余',
 	`sort_order` TINYINT (1) NULL COMMENT '排序字段',
    `tenant_id` BIGINT (20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '模型属性值管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 3.表搜索记录
CREATE TABLE `assets_check_record` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`table_id` BIGINT(20) NOT NULL COMMENT '表id',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
	`db_id` BIGINT(20) NULL DEFAULT NULL COMMENT '数据库id',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`),
    KEY `idx_tid_dstype` (
        `table_id`,
        `data_source_type`
    ) USING BTREE,
    KEY `idx_createby` (`create_by`) USING BTREE
) COMMENT = '表查看记录表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 4.周期同步相关表
CREATE TABLE `assets_sync_task` (
    `id` BIGINT (20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
 	`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 	`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 	`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  	`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  	`data_source_id` BIGINT (20) NOT NULL COMMENT '对应数据源id',
    `schedule_conf` varchar(512) NOT NULL COMMENT '调度配置',
  	`period_type` TINYINT (1) NOT NULL COMMENT '调度类型 0分钟 1小时 2 天  3 周 4月',
  	`task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 手动同步 只运行一次  1 周期同步',
    `tenant_id` BIGINT (20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '周期同步配置表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `assets_sync_job` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `data_source_id` bigint(20) NOT NULL COMMENT '对应数据源id',
  `task_id` bigint(20) NOT NULL COMMENT 'sync_task表id',
  `job_id` varchar(32) NOT NULL COMMENT '对应task服务的job_id 标识唯一周期实例',
  `job_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态 1 同步中 2 同步结束  3 手动停止',
  `table_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '同步总表数量',
  `table_success_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '同步表成功的数量',
  `table_fail_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '同步表失败的数量',
  `fail_table` longtext COMMENT '同步失败的表名 逗号隔开',
  `job_log` longtext COMMENT '任务日志 错误信息',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  `plan_date` datetime DEFAULT NULL COMMENT '计划时间',
  `exec_start_time`  datetime  DEFAULT NULL COMMENT '任务开始时间' ,
  `exec_end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='周期同步实例表';
--  5. 字典表
CREATE TABLE `assets_sys_dict` (
  `id` BIGINT (20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `dict_type` int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1：数据源字典,2-规则校验类型',
  `dict_name` varchar(100) NOT NULL DEFAULT '' COMMENT '字典名',
  `dict_value` int(11) NOT NULL DEFAULT '0' COMMENT '字典值',
  `dict_name_cn` varchar(100) NOT NULL DEFAULT '' COMMENT '字典中文名',
  `dict_sort` int(11) NOT NULL DEFAULT '0' COMMENT '字典顺序',
    PRIMARY KEY (`id`)
) COMMENT = '字典表（个性属性配置查询metastoreSql需要配置在字典表）' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 6. 数据安全
CREATE TABLE assets_role (
  `id` BIGINT (20) UNSIGNED NOT NULL auto_increment PRIMARY KEY,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `tenant_id` BIGINT (20) DEFAULT '0' NOT NULL COMMENT '角色所属租户id,0:基础角色',
  `role_name` VARCHAR (100) NOT NULL COMMENT '角色名称',
  `role_type` TINYINT (1) DEFAULT '1' NOT NULL COMMENT '角色类型：1：功能权限',
  `role_value` TINYINT (1) DEFAULT '0' NOT NULL COMMENT '真正的角色 枚举值 ',
  `role_desc` VARCHAR (255) DEFAULT '' NOT NULL COMMENT '角色描述'
    ) COMMENT '角色表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE assets_permission (
    `id` BIGINT (20) UNSIGNED auto_increment PRIMARY KEY,
 	`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 	`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  	`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  	`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `permission_code` VARCHAR (255) DEFAULT '' NOT NULL COMMENT '权限CODE',
    `permission_name` VARCHAR (100) NULL COMMENT '权限名',
    `permission_display` VARCHAR (100) NULL COMMENT '展示名称',
    `parent_id` BIGINT (20) UNSIGNED NULL COMMENT '父权限id',
    `permission_type` TINYINT (1) DEFAULT '1' NULL COMMENT '1:功能权限;2:数据权限'
) COMMENT '权限表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE assets_role_permission (
    `id` BIGINT (20) UNSIGNED auto_increment COMMENT '自增id' PRIMARY KEY,
  	`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  	`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  	`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `role_id` BIGINT (20) UNSIGNED NOT NULL COMMENT '关联角色id',
    `permission_id` BIGINT (20) UNSIGNED NOT NULL COMMENT '关联权限id'
) COMMENT '角色权限关联表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE assets_user (
    `id` BIGINT (20) UNSIGNED auto_increment PRIMARY KEY,
  	`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  	`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  	`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  	`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `dtuic_user_id` BIGINT (20) UNSIGNED NOT NULL COMMENT 'dtuic userid',
    `user_name` VARCHAR (100) NOT NULL COMMENT '用户名称',
    `user_email` VARCHAR (100) NULL COMMENT '用户邮箱',
    `user_status` TINYINT (1) DEFAULT '0' NOT NULL COMMENT '用户状态0：正常，1：禁用',
    `phone_number` VARCHAR (100) NULL COMMENT '用户手机号',
  	`tenant_id` BIGINT (20) NOT NULL COMMENT '租户id,用于租户隔离'
) COMMENT '角色表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX index_user_name ON assets_user (user_name);
CREATE TABLE assets_role_user (
   `id` BIGINT (20) UNSIGNED auto_increment PRIMARY KEY,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `tenant_id` BIGINT (20) UNSIGNED NOT NULL COMMENT '租户id',
  `role_id` BIGINT (20) UNSIGNED NOT NULL COMMENT '角色id',
  `user_id` BIGINT (20) UNSIGNED NOT NULL COMMENT '用户id'
) COMMENT '角色用户关联表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 7.租户管理
CREATE TABLE assets_tenant (
  `id` BIGINT (20) UNSIGNED auto_increment PRIMARY KEY,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `dtuic_tenant_id` BIGINT (20) UNSIGNED NOT NULL COMMENT 'dtuic的租户id',
  `tenant_name` VARCHAR (100) NOT NULL COMMENT '用户名称',
  `tenant_desc` VARCHAR (255) NULL COMMENT '租户描述',
  `tenant_status` TINYINT(1) DEFAULT '0' NOT NULL COMMENT '用户状态0：正常，1：禁用',
    CONSTRAINT index_tenant_name UNIQUE (tenant_name)
) COMMENT '租户表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 8.预设模型属性
CREATE TABLE `assets_preset_model_attribute` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`attribute_name` VARCHAR(100) NOT NULL COMMENT '元模型中 属性名',
	`attribute_name_cn` VARCHAR(100) NOT NULL COMMENT '元模型中 属性中文名',
	`attribute_type` TINYINT(1) NOT NULL COMMENT '元模型属性类型,0表示技术属性 1表示`通用业务属性`,2表示`个性业务属性`',
	`field_type` TINYINT(1) NOT NULL COMMENT '字段属性,1-枚举,2-string类型文本,3-树形目录,4-bigint文本框,5-日期类型,6-varchar类型,7-存储大小',
    `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 1-表 2字段',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型  数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
	`is_required` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否必填项，0非必填，1必填',
	`sort_order` TINYINT(1) NOT NULL COMMENT '排序字段',
	PRIMARY KEY (`id`),
	INDEX `idx_sourcetype` (`data_source_type`) USING BTREE,
	INDEX `idx_attributetype` (`attribute_type`) USING BTREE
) COMMENT '预设模型属性' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 9.批量管理
CREATE TABLE `assets_data_table_batch_manage` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
	`data_table_id` BIGINT(20) NOT NULL COMMENT '数据表ID',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
	`user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
	PRIMARY KEY (`id`)
)  COMMENT '批量管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `assets_data_db_batch_manage` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1-删除,0-未删除',
	`db_id` BIGINT(20) NOT NULL COMMENT '数据库ID',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户ID,用于租户隔离',
	`user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
	`data_source_type` INT(11) NOT NULL COMMENT '数据源类型',
	PRIMARY KEY (`id`)
) COMMENT='数据库批量管理表' ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `assets_sync_job_thread` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`job_id` VARCHAR(32) NOT NULL COMMENT '对应task服务的job_id 标识唯一周期实例',
  `thread_id` VARCHAR(32) NOT NULL COMMENT '线程id',
	`table_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步总表数量',
	`table_success_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步表成功的数量',
	`table_fail_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步表失败的数量',
	`fail_table` LONGTEXT NULL COMMENT '同步失败的表名 逗号隔开',
	`job_log` LONGTEXT NULL COMMENT '任务日志 错误信息',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`)
)
COMMENT='周期同步实例线程表'
ENGINE=InnoDB
;

-- 数据价值排行
CREATE TABLE `assets_data_value_rank` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB',
  `table_id` bigint(20) unsigned NOT NULL COMMENT '表ID',
  `column_id` bigint(20) DEFAULT NULL COMMENT '列ID',
  `meta_data_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '元数据类型 1-表 2-字段',
  `obj_attr_1` varchar(100) NOT NULL COMMENT '对象属性1',
  `obj_attr_2` varchar(100) DEFAULT NULL COMMENT '对象属性2',
  `view_count` bigint(20) DEFAULT '0' COMMENT '查看次数',
  `use_count` bigint(20) DEFAULT '0' COMMENT '使用次数',
  `affect_count` bigint(20) DEFAULT '0' COMMENT '影响表数',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据价值排行表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 已接入数据统计表
CREATE TABLE `assets_data_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `data_source_count` bigint(10) DEFAULT NULL COMMENT '数据源数量',
  `database_count` bigint(10) DEFAULT NULL COMMENT '数据库数量',
  `data_table_count` bigint(20) DEFAULT NULL COMMENT '数据表数量',
  `table_increment` bigint(20) DEFAULT NULL COMMENT '数据表增量',
  `meta_data_change` BIGINT(20) NULL DEFAULT '0' COMMENT '元数据修改次数',
	`storage` BIGINT(20) NULL DEFAULT '0' COMMENT '数据源存储容量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据预览表' ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 表存储排行数据
CREATE TABLE `assets_data_statistic_table_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `table_rank` tinyint(1) NOT NULL COMMENT '表存储容量排名',
  `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
	`data_source_name` VARCHAR(255) NOT NULL COMMENT '数据源名称',
  `table_id` bigint(10) NOT NULL COMMENT '表主键',
  `table_name` varchar(100) NOT NULL COMMENT '表名称',
  `database_name` varchar(100) NOT NULL COMMENT '所属数据库名称',
  `table_storage` bigint(20) NOT NULL COMMENT '表存储大小',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据表存储大小排行前10' ENGINE=InnoDB  DEFAULT CHARSET=utf8;
-- 库存储排行数据
CREATE TABLE `assets_data_statistic_database_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
  `db_rank` tinyint(1) NOT NULL COMMENT '数据库存储容量排名',
  `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
	`data_source_name` VARCHAR(255) NOT NULL COMMENT '数据源名称',
  `db_id` bigint(10) NOT NULL COMMENT '数据库主键',
  `db_name` varchar(100) NOT NULL COMMENT '数据库名称',
  `db_storage` bigint(20) NOT NULL COMMENT '数据库存储大小',
  `db_source_storage` bigint(20) NOT NULL COMMENT '该数据源下所有数据库存储大小总和',
  `db_storage_ratio` varchar(100) NOT NULL COMMENT '该数据库存储大小占该数据源数据库存储大小总和的占比',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT='数据库存储大小排行前10' ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据分布表
CREATE TABLE `assets_data_distribution` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
    `data_source_type` INT(11) NOT NULL COMMENT '数据源类型  1-Mysql,2-Oracle,7-Hive,31-TiDB,27-Hive1,3-SQL Server',
    `attribute_id` BIGINT(20) UNSIGNED NOT NULL COMMENT '属性ID',
    `attribute_name_cn` varchar(100) NOT NULL COMMENT '属性中文名',
    `attribute_value` VARCHAR (255) NOT NULL COMMENT '属性值',
    `table_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表数量',
    `ratio` VARCHAR(10) NOT NULL DEFAULT '0%' COMMENT '表占比',
    `tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '数据分布' ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `assets_model_column_attribute` (
   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
   `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
   `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
   `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
   `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
   `table_id` bigint(20) DEFAULT NULL COMMENT '表ID',
   `column_id` bigint(20) NOT NULL COMMENT '字段ID',
   `field_type` tinyint(1) NOT NULL COMMENT '字段类型',
   `attribute_id` bigint(20) NOT NULL COMMENT '属性ID',
   `attribute_name` varchar(100)  DEFAULT NULL COMMENT '属性名称',
   `attribute_name_cn` varchar(100)  NOT NULL COMMENT '属性中文名',
   `attribute_type` tinyint(1) NOT NULL COMMENT '属性类型 0技术1通用2个性',
   `attribute_value` varchar(255)  DEFAULT NULL COMMENT '属性值',
   `attribute_value_id` bigint(20) DEFAULT NULL COMMENT '属性值ID（枚举、树形目录）',
   `attribute_value_display` varchar(255) DEFAULT NULL COMMENT '属性值（文本）',
   `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段属性表';

-- 资源目录表
CREATE TABLE `assets_resource_catalog` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`catalog_name` VARCHAR(100) NOT NULL COMMENT '目录名称',
  `parent_id` BIGINT(100) NOT NULL DEFAULT '-1' COMMENT '父id',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT = '资源目录表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据资源表
CREATE TABLE `assets_resource`
(
    `id`               BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_at`        DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`        DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`        INT(11)             NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`        INT(11)             NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`       TINYINT(1)          NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `resource_name`    VARCHAR(100)        NOT NULL COMMENT '资源名称',
    `resource_name_cn` VARCHAR(100)        NULL COMMENT '资源中文名',
    `data_id`          BIGINT(100)         NOT NULL COMMENT '元数据id(表id或者字段id)',
    `data_source_type` INT(11)          NOT NULL COMMENT '数据源类型',
    `data_source_id`   BIGINT(20)          NOT NULL COMMENT '数据源ID',
    `catalog_id`       BIGINT(100)         NOT NULL COMMENT '资源目录id',
    `db_id`            BIGINT(100)         NOT NULL COMMENT '库id',
    `table_id`         BIGINT(100)         NOT NULL COMMENT '表id',
    `table_owner`      BIGINT(20)          NOT NULL DEFAULT '0' COMMENT '表负责人',
    `resource_type`    BIGINT(100)         NOT NULL COMMENT '资源类型',
    `resource_status`  TINYINT(1)          NOT NULL COMMENT '发布状态,0已下线,1已发布',
    `tenant_id`        BIGINT(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) COMMENT = '数据资源表' ENGINE = InnoDB DEFAULT CHARSET = utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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



-- 元数据质量-完整度分析表
CREATE TABLE `assets_fill_rate_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `analysis_mode` tinyint(3) unsigned NOT NULL COMMENT '统计方式：0-数据源， 1-数据库，2-表负责人',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `table_owner_id` bigint(20) DEFAULT NULL,
  `table_owner_name` varchar(128) DEFAULT NULL,
  `data_source_id` bigint(20) DEFAULT NULL,
  `data_source_type` INT(11) NULL DEFAULT NULL,
  `data_source_name` varchar(128) DEFAULT NULL,
  `db_id` bigint(20) DEFAULT NULL COMMENT '数据库id',
  `db_name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `table_fill_rate` float NOT NULL DEFAULT '0' COMMENT '表填充率',
  `column_fill_rate` float NOT NULL DEFAULT '0' COMMENT '字段填充率',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='元数据质量-完整度分析表(按数据源、数据库、负责人统计)';


-- 元数据质量-业务属性完整度分析表
CREATE TABLE `assets_biz_attr_fill_rate_statistic` (
   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
   `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
   `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
   `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
   `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
   `analysis_mode` tinyint(3) unsigned NOT NULL COMMENT '统计方式：3-业务属性',
   `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
   `data_source_type` INT(11) NULL DEFAULT NULL COMMENT '数据源类型',
   `meta_data_type` tinyint(3) unsigned NOT NULL COMMENT '元模型属性类型： 1-表，2-字段',
   `attribute_id` bigint(20) DEFAULT NULL COMMENT '属性id',
   `attribute_name` varchar(128) DEFAULT NULL COMMENT '属性名',
   `attribute_name_cn` varchar(128) DEFAULT NULL COMMENT '属性中文名',
   `fill_rate` float NOT NULL DEFAULT '0' COMMENT '填充率',
   `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
   PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='元数据质量-完整度分析表(按业务属性统计)';

-- 元数据质量-质量统计表
CREATE TABLE `assets_fill_rate_total_statistic` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
    `data_source_type` INT(11) NOT NULL  COMMENT '数据源类型',
    `meta_data_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '元数据类型 1-表 2-字段',
    `fill_rate` float NOT NULL DEFAULT '0' COMMENT '不同数据源类型下元模型填充率',
    `total_fill_rate` float NOT NULL DEFAULT '0' COMMENT '所有数据源类型下元模型填充率',
    `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='质量统计表';

CREATE TABLE assets_db_lineage_statistics (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
	  `create_by` bigint(20) NOT NULL DEFAULT 0 COMMENT '创建人',
	  `update_by` bigint(20) NOT NULL DEFAULT 0 COMMENT '更新人',
	  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 未删除 1 已删除',
	  `db_id` BIGINT(20) NOT NULL COMMENT '数据库id',
    `db_name` VARCHAR(100) NOT NULL COMMENT '数据库名称',
    `data_source_type` INT(11) NOT NULL COMMENT '数据源类型',
    `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源id',
    `table_total_count`  BIGINT(20)  DEFAULT 0 COMMENT '数据库表总数',
    `table_count_without_lineage`  BIGINT(20)  DEFAULT 0 COMMENT '无血缘的表总数',
	  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库血缘统计';

-- 数据脱敏 - 脱敏规则表
CREATE TABLE `assets_data_masking_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `masking_rule_name` varchar(128) DEFAULT NULL COMMENT '脱敏规则名称',
  `masking_type` tinyint(4) DEFAULT NULL COMMENT '脱敏效果，0-部分脱敏，1-全部脱敏',
  `replace_char` varchar(32) DEFAULT NULL COMMENT '替换字符',
  `start_position` tinyint(4) DEFAULT NULL COMMENT '字段替换开始位置',
  `sample_data` varchar(128) DEFAULT NULL COMMENT '样例数据',
  `end_position` tinyint(4) DEFAULT NULL COMMENT '替换结束位置',
  `masking_table_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '直接脱敏表数量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB COMMENT='脱敏规则表';

-- 数据脱敏 - 脱敏应用表
create table assets_data_masking_table
(
    id bigint unsigned auto_increment,
    tenant_id bigint unsigned not null,
    masking_rule_id bigint unsigned not null comment '脱敏规则id',
    table_id bigint unsigned not null comment '脱敏表的table_id,对应元数据的表id，如果是血缘脱敏表，此id就是其直接脱敏表的元数据表id',
    lineage_table_id bigint unsigned null comment '血缘表id',
    table_name varchar(64) not null comment '脱敏表名',
    column_id bigint unsigned not null comment '脱敏字段column_id,对应元数据的字段id，如果是血缘脱敏表，此id就是其直接脱敏表的元数据字段id',
    lineage_column_id bigint unsigned null comment '血缘字段id',
    column_name varchar(128) not null comment '脱敏字段名称',
    db_id bigint unsigned null comment '数据库id',
    db_name varchar(128) not null comment '数据库名称',
    data_source_type INT(11) not null comment '数据源类型',
    data_source_id bigint unsigned null comment '数据源id',
    data_source_name varchar(128) not null comment '数据源名称',
    lineage_table_count int default 0 not null comment '血缘脱敏表总数',
    create_at datetime default current_timestamp not null,
    update_at datetime default current_timestamp not null,
    create_by bigint unsigned default 0 not null,
    update_by bigint unsigned default 0 null,
    lineage_status tinyint default 1 not null comment '0-血缘未启用， 1-血缘已启用',
    is_direct tinyint default 1 not null comment '0-不是直接脱敏表，1-是直接脱敏表',
    is_deleted tinyint default 0 not null comment '0 未删除 1 已删除',
    constraint assets_data_masking_table_pk
        primary key (id)
)ENGINE=InnoDB
    comment '数据脱敏应用表';

CREATE TABLE `assets_alert`
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`     tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `meta_data_type` tinyint(1)          NOT NULL COMMENT '事件源 0-数据源',
    `meta_data_id`   bigint(20)          NOT NULL COMMENT '事件源ID',
    `event_type`     tinyint(1)          NOT NULL COMMENT '事件类型 1-周期同步未完成',
    `send_type`      varchar(100)                 DEFAULT '0' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
    `ding_webhook`   varchar(255)                 DEFAULT NULL COMMENT '钉钉Webhook',
    `users`          varchar(255)                 DEFAULT NULL COMMENT '要通知的用户信息',
    `tenant_id`      bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='告警表';

CREATE TABLE `assets_subscribe`
(
    `id`                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`        tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `user_id`           bigint(20)          NOT NULL COMMENT '订阅人ID',
    `meta_data_type`    tinyint(1)          NOT NULL COMMENT '订阅对象 1-表',
    `meta_data_id`      bigint(20)          NOT NULL COMMENT '订阅对象ID',
    `meta_data_name`    varchar(255)        NOT NULL COMMENT '订阅对象名',
    `meta_data_name_cn` varchar(255)        NULL COMMENT '订阅对象中文名',
    `event_type`        tinyint(1)          NOT NULL COMMENT '事件类型 2-元数据变动',
    `send_type`         varchar(100)        NOT NULL DEFAULT '0' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
    `ding_webhook`      varchar(255)                 DEFAULT NULL COMMENT '钉钉Webhook',
    `tenant_id`         bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='订阅表';

CREATE TABLE `assets_notify_record`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted`   tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `app_type`     tinyint(1)          NOT NULL DEFAULT '9' COMMENT '应用类型 数据资产默认为9',
    `project_id`   bigint(20)          NOT NULL,
    `user_id`      bigint(20)                   DEFAULT NULL COMMENT '用户ID',
    `content_id`   bigint(20)          NOT NULL COMMENT '通知内容ID',
    `content`      varchar(255)        NOT NULL COMMENT '通知内容',
    `trigger_type` tinyint(1)                   DEFAULT NULL COMMENT '触发类型',
    `status`       tinyint(1)          NOT NULL DEFAULT '0',
    `read_status`  tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否已读',
    `tenant_id`    bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='通知记录表';

CREATE TABLE `assets_version_record`
(
    `id`         bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `create_by`  bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
    `update_by`  bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
    `create_at`  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `is_deleted` tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
    `table_id`   bigint(20)          NOT NULL COMMENT '表ID',
    `change_by`  varchar(100)        NOT NULL COMMENT '操作人',
    `version`    int(10)                      DEFAULT '10' COMMENT '版本号 更新时自增1 以倒数第一位分隔',
    `snapshot`   json                NOT NULL COMMENT '更改快照',
    `tenant_id`  bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT ='变更日志表';

-- 资产盘点-数据资源分布
CREATE TABLE `assets_data_resource_distribution` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `catalog_id` bigint(100) NOT NULL COMMENT '资源目录id',
  `catalog_name` varchar(100) NOT NULL COMMENT '目录名称',
  `data_source_count` bigint(10) DEFAULT NULL COMMENT '数据源数量',
  `database_count` bigint(10) DEFAULT NULL COMMENT '数据库数量',
  `data_table_count` bigint(20) DEFAULT NULL COMMENT '数据表数量',
  `data_table_total_count` bigint(20) DEFAULT NULL COMMENT '目录下所有数据表数量',
  `data_table_ratio` float DEFAULT '0' COMMENT '表数量占比',
  `storage` bigint(20) DEFAULT '0' COMMENT '目录下数据源存储容量',
  `total_storage` bigint(20) DEFAULT NULL COMMENT '目录下数据存储容量',
  `storage_ratio` float DEFAULT '0' COMMENT '目录下存储容量占比',
  `child_catalog_count` varchar(256) DEFAULT NULL COMMENT '一级目录下的子集数量',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产盘点数据质量分布';

-- 资产盘点-资产查询趋势表
CREATE TABLE `assets_search_statistic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `search_count` bigint(10) DEFAULT NULL COMMENT '查询次数',
  `login_count` bigint(10) DEFAULT NULL COMMENT '登录人次',
  `login_user_count` bigint(20) DEFAULT NULL COMMENT '登录人数',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产盘点-资产查询趋势';

CREATE TABLE `assets_resource_display`(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `create_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '创建的用户',
    `update_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '修改的用户',
    `is_deleted`   tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `tenant_id`    bigint(20)          NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
    `user_id`      bigint(20)          NOT NULL COMMENT '用户ID',
    `key_property` TINYINT(1)          NULL     DEFAULT 0 COMMENT '主键信息，0优先显示英文名 1优先显示中文名',
    `tech_attrs`   VARCHAR(10)         NULL     DEFAULT '1,1,1,1' COMMENT '资源技术属性是否选中',
    `biz_attrs`    VARCHAR(255)        NULL COMMENT '业务属性选中的ID',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8 COMMENT ='资源用户显示项表';
commit;

CREATE TABLE `assets_data_source_type` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '创建人',
	`update_by` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '更新人',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
	`data_source_type_name` VARCHAR(255) NOT NULL COMMENT '数据源名称',
	`data_source_type_code` INT(11) NOT NULL DEFAULT '0' COMMENT '数据源类型code,1000起',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`)
)ENGINE = InnoDB DEFAULT CHARSET=utf8 COMMENT ='自定义数据源类型表';


-- 数据标准表
CREATE TABLE `assets_standard` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`standard_name_cn` varchar(255) NOT NULL COMMENT '标准中文名',
`standard_name` varchar(255) NOT NULL COMMENT '标准名称',
`data_type` varchar(100) NOT NULL COMMENT '数据类型',
`catalog_id` bigint(100) NOT NULL COMMENT '标准目录id',
`business_definition` varchar(255) DEFAULT NULL COMMENT '业务定义',
`custom_attribute` json DEFAULT NULL COMMENT '自定义属性 json字符串',
`standard_status` tinyint(1) NOT NULL COMMENT '发布状态,0待发布,1已发布',
`hit_count` bigint(100) NOT NULL DEFAULT '0' COMMENT '命中数量',
`match_count` bigint(100) NOT NULL DEFAULT '0' COMMENT '匹配数量',
`mapping_status` tinyint(1) NOT NULL COMMENT '映射状态,-1初始化状态,0映射中,1映射结束',
`mapping_date` datetime DEFAULT NULL COMMENT '最近映射时间',
`publish_date` datetime DEFAULT NULL COMMENT '最近发布时间',
`nullable` tinyint(1) DEFAULT NULL COMMENT '允许为空 0不可空 1可空',
`repeatable` tinyint(1) DEFAULT NULL COMMENT '允许重复 0不允许 1允许',
`value_range` json DEFAULT NULL COMMENT '取值范围 json字符串',
`enum_range` json DEFAULT NULL COMMENT '枚举范围 json字符串',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据标准表';

-- 标准目录表
CREATE TABLE `assets_standard_catalog` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`catalog_name` varchar(255) NOT NULL COMMENT '目录名称',
`parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
`child_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
`prev_id` bigint(20) DEFAULT NULL COMMENT '前一个节点id',
`next_id` bigint(20) DEFAULT NULL COMMENT '后一个节点id',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准目录表';

-- 标准映射表
CREATE TABLE `assets_standard_mapping` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`column_id` bigint(100) NOT NULL COMMENT '字段id',
`standard_id` bigint(100) NOT NULL COMMENT '标准id',
`data_source_type` int(11) NOT NULL COMMENT '数据源类型',
`match_status` tinyint(1) NOT NULL COMMENT '匹配状态 1字段名匹配，字段中文名不匹配 2字段中文名匹配，字段名不匹配 3字段名称均匹配，其他属性不匹配 4完全匹配',
`bind_status` tinyint(1) NOT NULL COMMENT '绑定状态,0未绑定,1已绑定',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`),
KEY `idx_column_id` (`column_id`) USING BTREE,
KEY `idx_standard_id` (`standard_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准映射表';

-- flink表额外参数信息表
CREATE TABLE `assets_flink_table_param` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`table_id` bigint(20) NOT NULL COMMENT 'flink表id',
`db_id` bigint(20) NOT NULL COMMENT 'flink库id',
`source_id` bigint(20) NOT NULL COMMENT 'flink源id',
`mapping_source_id` bigint(20) NOT NULL COMMENT 'flink映射源id',
`mapping_db_id` bigint(20) NOT NULL COMMENT 'flink映射库id',
`mapping_table_id` bigint(20) NOT NULL COMMENT 'flink映射数据表id',
`mapping_source_type` int(11) NOT NULL COMMENT 'flink映射数据源类型',
`charset` varchar(100) DEFAULT NULL COMMENT '编码类型',
`sink_params` json DEFAULT NULL COMMENT '结果表参数 json字符串',
`source_params` json DEFAULT NULL COMMENT '源表参数 json字符串',
`side_params` json DEFAULT NULL COMMENT '维表参数 json字符串',
`tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='flink表额外参数信息表';

-- 数据权限
-- 策略表
CREATE TABLE `assets_strategy` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_name` varchar(255) NOT NULL COMMENT '策略名称',
`strategy_desc` varchar(255) DEFAULT '' COMMENT '策略描述',
`strategy_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0生效,1未生效',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略表';

-- 策略元数据关系表
CREATE TABLE `assets_strategy_data` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除,0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_id` bigint(20) NOT NULL COMMENT '策略id',
`data_source_type` bigint(20) NOT NULL COMMENT '数据源类型',
`meta_data_type` tinyint(1) NOT NULL COMMENT '元数据类型 0表示库,1表示表,2表示字段',
`meta_data_id` bigint(20) NOT NULL COMMENT '元数据id 数据库id/数据表id/字段id',
`meta_data_name` varchar(100) NOT NULL COMMENT '元数据名称',
`relation_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '关系类型,0选中,1排除',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略元数据关系表';

-- 策略用户关系表
CREATE TABLE `assets_strategy_user` (
`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
`update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
`update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除,0未删除',
`tenant_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
`strategy_id` bigint(20) NOT NULL COMMENT '策略id',
`user_id` bigint(20) NOT NULL COMMENT '用户id',
`permission_type` tinyint(1) NOT NULL COMMENT '权限类型 0表示可读权限、1表示读写权限',
PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='策略用户关系表';


CREATE TABLE `ei_index_base_info` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_code` VARCHAR ( 255 ) NOT NULL COMMENT '指标编码',
    `idx_type` TINYINT ( 1 ) NOT NULL COMMENT '指标类型 1-原子指标 2-派生指标 3-复合指标 4-自定义指标',
    `idx_name` VARCHAR ( 255 ) NOT NULL COMMENT '指标名称',
    `idx_nick_name` VARCHAR ( 255 ) NULL COMMENT '指标别名',
    `idx_desc` VARCHAR ( 255 ) NULL COMMENT '指标描述',
    `cat_id` INT ( 11 ) NOT NULL COMMENT '目录id',
    `bus_caliber` VARCHAR ( 512 ) NULL COMMENT '业务口径',
    `idx_frequency` TINYINT ( 1 ) NULL COMMENT '指标频度,1为日频度，3为周频度，5为月频度，7为季频度，9为年频度',
    `result_table` varchar(255) DEFAULT NULL COMMENT '结果表表名',
    `cr_table_idx_sql` text COMMENT '指标定义，即建表sql',
    `idx_sql` text COMMENT '指标配置后生成的sql',
    `model_id` INT ( 11 ) NULL COMMENT '模型id',
    `is_loop_than` int(11) DEFAULT NULL COMMENT '是否开启同环比设置0:不开启,1:开启',
    `loop_than_pre` tinyint(1) DEFAULT NULL COMMENT '同比设置1:日同比,2:月同比,3:季同比',
    `loop_than_chain` tinyint(1) DEFAULT NULL COMMENT '环比设置1:日环比,2:月环比,3:季环比,4:年同比',
    `last_version` VARCHAR ( 255 ) DEFAULT NULL COMMENT '最新版本',
    `release_status` TINYINT ( 1 ) NOT NULL COMMENT '发布状态, -1已下线，0未发布，1发布',
    `dispatch_status` TINYINT ( 1 ) DEFAULT NULL COMMENT '调度状态，-1-已冻结 0-未提交 1-运行中',
    `duty_id` INT ( 11 ) NOT NULL COMMENT '负责人id',
    `release_user_id` INT ( 11 ) DEFAULT NULL COMMENT '发布人id',
    `release_desc` VARCHAR ( 512 ) DEFAULT NULL COMMENT '发布说明',
    `total_visit` INT(11) NOT NULL DEFAULT '0' COMMENT '累计访问',
    `release_date` datetime DEFAULT NULL COMMENT '发布时间',
    `condition_expression` text COMMENT '存储过滤json数据派生、复合指标过滤条件',
    `variable_param` text COMMENT '存储sql用到的参数',
    `period_id` INT(11) NULL COMMENT '统计周期id',
    `group_id` VARCHAR(32) DEFAULT NULL COMMENT '分组id' ,
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标基本信息表';

CREATE TABLE `ei_index_reference` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `idx_type` TINYINT ( 1 ) NOT NULL COMMENT '指标类型 1-原子指标 2-派生指标 3-复合指标 4-自定义指标',
    `reference_type` TINYINT ( 1 ) NULL COMMENT '引用类型 1-模型 2-指标',
    `reference_id` INT ( 11 ) NOT NULL COMMENT '引用的如果为模型则为ei_model的id，如果为指标则为ei_index的id',
    `reference_name` varchar(255) DEFAULT NULL  COMMENT '引用的名称',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` ),
    INDEX `idx_id` ( `idx_id` ) USING BTREE COMMENT '指标ID索引'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标引用信息';

CREATE TABLE `ei_index_dispatch_info` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `dispatch_period` TINYINT ( 1 ) NULL COMMENT '调度周期,-1-手动调度,1-日频度，3-周频度，5-月频度，7-季频度，9-年频度',
    `week_day` VARCHAR ( 255 ) NULL COMMENT '所选的星期几 1-7: 对应星期一到星期日 用逗号隔开',
    `day` VARCHAR ( 255 ) NULL COMMENT '所选的日期号 1-31: 对应1号到31号 用逗号隔开',
    `spec_time` VARCHAR ( 255 ) NULL COMMENT '具体时间 时分秒 HH:mm:ss形式',
    `task_id` INT ( 11 ) NOT NULL COMMENT '任务id，指标侧生成，提交到离线平台',
    `task_name` VARCHAR ( 255 ) NOT NULL COMMENT '任务名称，指标侧生成，提交到离线平台',
    `task_detail` text NOT NULL COMMENT '任务名称，指标侧生成，提交到离线平台',
    `priority` TINYINT ( 1 ) NOT NULL DEFAULT 100 COMMENT '优先级参数 范围1-100',
    `task_status` TINYINT ( 1 ) NOT NULL COMMENT '调度状态, -1-已冻结 0-未提交 1-运行中',
    `is_retry` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否重试 0 -不重试 1-重试',
    `retry_times` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '优先级参数 范围1-100',
    `interval_time` int(11) NULL COMMENT '重试间隔时间（分钟）',
    `pre_idx_id_list` VARCHAR ( 255 ) NULL COMMENT '上游指标列表',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` ),
    INDEX `idx_id` ( `idx_id` ) USING BTREE COMMENT '指标ID索引'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标调度信息表';

CREATE TABLE `ei_model` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `model_id` INT ( 11 ) NOT NULL COMMENT '数据模型返回的模型id',
    `version`VARCHAR ( 255 ) NOT NULL COMMENT '模型版本',
    `model_name` VARCHAR ( 255 ) NOT NULL COMMENT '模型名称',
    `model_en_name` VARCHAR ( 255 ) NOT NULL COMMENT '模型英文名(模型编码)',
    `ds_id` VARCHAR ( 255 ) NOT NULL COMMENT '数据源id',
    `ds_type` INT ( 11 ) NOT NULL COMMENT '数据源类型',
    `ds_type_name` VARCHAR ( 255 ) NOT NULL COMMENT '数据源类型名称',
    `ds_name` VARCHAR ( 255 ) NOT NULL DEFAULT 0 COMMENT '数据源名称',
    `ds_url` VARCHAR ( 255 ) NOT NULL DEFAULT 0 COMMENT '数据源地址',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '从publicservice中获取的模型';

CREATE TABLE `ei_index_metric` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `model_id` int(11) NULL DEFAULT NULL COMMENT '模型id',
    `model_column_id` INT ( 11 ) NOT NULL COMMENT '模型列id(自定义sql存储为-1)',
    `schema_name` VARCHAR ( 255 ) NOT NULL COMMENT 'schema',
    `table_name` VARCHAR ( 255 ) NOT NULL COMMENT '对应表名',
    `field_name` VARCHAR ( 255 ) NOT NULL COMMENT '列名，默认为指标英文名称',
    `field_type` varchar(255)  DEFAULT NULL COMMENT '字段类型',
    `field_desc` varchar(255) DEFAULT NULL COMMENT '字段描述',
    `field_alias` varchar(255) NULL COMMENT '字段别名',
    `field_expression` text DEFAULT NULL COMMENT '原子指标，存储模型字段的json信息；派生指标，存储模型字段json信息与function_type字段得到度量；复合指标，存储计算逻辑参数josn信息与function_type字段组合得到度量；',
    `function_exp` VARCHAR ( 255 ) COMMENT '派生指标自定义函数表达式',
    `function_type` TINYINT ( 11 ) DEFAULT NULL COMMENT '只有派生指标、复合指标有聚合逻辑，函数逻辑类型 1为sum 2为count',
    `field_unit` VARCHAR ( 255 ) DEFAULT NULL COMMENT '度量单位',
    `field_accuracy` TINYINT ( 1 ) DEFAULT NULL  COMMENT '字段精度',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` ),
    INDEX `idx_id` ( `idx_id` ) USING BTREE COMMENT '指标ID索引'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标度量信息表';

CREATE TABLE `ei_index_dimension` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `schema_name` VARCHAR ( 255 ) NOT NULL COMMENT 'schema',
    `table_name` VARCHAR ( 255 ) NOT NULL COMMENT '对应表名',
    `field_name` VARCHAR ( 255 ) NOT NULL COMMENT '列名，默认为模型名称',
    `field_type` varchar(255)  DEFAULT NULL COMMENT '字段类型',
    `field_desc` varchar(255) DEFAULT NULL COMMENT '字段描述',
    `field_alias` varchar(255) NULL COMMENT '字段别名',
    `model_id` int(11) NULL DEFAULT NULL COMMENT '模型id',
    `model_column_id` INT ( 11 ) NOT NULL COMMENT '模型列id(自定义sql存储为-1)',
    `time_dimension` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '0-非时间维度 1-时间维度 是否为时间维度',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` ),
    INDEX `idx_id` ( `idx_id` ) USING BTREE COMMENT '指标ID索引'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标维度信息';

CREATE TABLE `ei_model_field` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `ei_model_id` INT ( 11 ) NOT NULL COMMENT 'ei_model表的id',
    `table_id` INT ( 11 ) NOT NULL COMMENT '表id',
    `db_schema` VARCHAR ( 255 ) NOT NULL COMMENT 'schema',
    `table_name` VARCHAR ( 255 ) NOT NULL COMMENT '对应的表名',
    `column_name` VARCHAR ( 255 ) NOT NULL COMMENT '列名',
    `column_type` VARCHAR ( 255 ) NOT NULL COMMENT '列类型',
    `column_desc` VARCHAR ( 255 ) NULL COMMENT '列描述',
    `is_dimension` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '是否为维度列, 0否, 1是',
    `is_metric` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '是否为度量列, 0否, 1是',
    `is_partition` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '是否为分区字段, 0否, 1是',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '模型字段表';

CREATE TABLE `ei_model_table` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `ei_model_id` INT ( 11 ) NOT NULL COMMENT 'ei_model表的id',
    `table_name` VARCHAR ( 255 ) NOT NULL COMMENT '表别名',
    `table_alias` VARCHAR ( 255 ) NOT NULL COMMENT '表名称',
    `extra_table_alias` varchar(255)  NULL DEFAULT NULL COMMENT '第三方服务中存储的表别名',
    `db_schema` VARCHAR ( 255 ) NOT NULL COMMENT 'schema',
    `is_main` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '是否为主表 0 否,1 是',
    `is_partition` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '是否为分区表 0 否,1 是',
    `update_type` INT ( 11 ) NOT NULL DEFAULT 0 COMMENT '更新方式 更新方式 0-无（没有更新方式） 1-增量 2-全量',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '模型事实表';

CREATE TABLE `ei_model_table_join` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `ei_model_id` INT ( 11 ) NOT NULL COMMENT 'ei_model表的id',
    `left_table_id` INT ( 11 ) NOT NULL COMMENT '左表id',
    `left_column` VARCHAR ( 120 ) NOT NULL COMMENT '左表关联字段(可能不在模型字段中)',
    `right_table_id` INT ( 11 ) NOT NULL COMMENT '右表id',
    `right_column` VARCHAR ( 120 ) NOT NULL COMMENT '右表关联字段(可能不在模型字段中)',
    `join_type` INT ( 11 ) NOT NULL COMMENT '表join类型 1:LeftJoin 2:RightJoin 3:InnerJoin',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '模型关联表';

CREATE TABLE `ei_project_management` (
    `id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
    `project_name` VARCHAR ( 256 ) NOT NULL COMMENT '项目名称',
    `project_show_name` VARCHAR ( 256 ) NOT NULL COMMENT '项目显示名称',
    `project_desc` VARCHAR ( 256 ) COMMENT '项目描述',
    `data_source_addr` VARCHAR ( 256 ) NOT NULL COMMENT '数据源地址',
    `schema_name` VARCHAR ( 64 ) DEFAULT NULL COMMENT 'schema名',
    `data_info_id` int(11) DEFAULT NULL COMMENT 'schema对应id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `top_sign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶,1已置顶，0未置顶',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '项目管理表';

CREATE TABLE `ei_idx_cat` (
    `id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `cat_name` VARCHAR ( 255 ) NOT NULL COMMENT '目录名称',
    `parent_id` INT ( 11 ) DEFAULT NULL COMMENT '父节点id',
    `child_id` INT ( 11 ) DEFAULT NULL COMMENT '子节点id',
    `pre_id` INT ( 11 ) DEFAULT NULL COMMENT '前一个节点id',
    `next_id` INT ( 11 ) DEFAULT NULL COMMENT '后一个节点id',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标目录表';

CREATE TABLE `ei_idx_model_ref` (
    `id` INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `field_id` INT ( 11 ) NOT NULL COMMENT '字段id',
    `field_type` TINYINT ( 4 ) NOT NULL DEFAULT 1 COMMENT '关联字段类型 0-度量  1-维度',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '模型字段与指标关联表';

CREATE TABLE `ei_statis_period` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
    `period_name` varchar(32) NOT NULL COMMENT '周期名称',
    `period_desc` varchar(256) NOT NULL COMMENT '周期描述',
    `start_date` varchar(64) DEFAULT NULL COMMENT '开始时间',
    `end_date` varchar(64) DEFAULT NULL COMMENT '结束时间',
    `is_sys` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是系统内置,0不是,1是',
    `project_id` int(11) NOT NULL COMMENT '项目主键id',
    `tenant_id` int(11) NOT NULL COMMENT '租户主键id',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` int(11) DEFAULT '0',
    `modify_user_id` int(11) DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT ='统计周期表';

CREATE TABLE `ei_idx_info_history` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `idx_id` INT ( 11 ) NOT NULL COMMENT '指标id',
    `version` VARCHAR ( 255 ) NOT NULL COMMENT '指标版本',
    `release_user_id` INT ( 11 ) NOT NULL COMMENT '发布人id',
    `release_desc` varchar ( 255 ) DEFAULT NULL COMMENT '指标发布说明',
    `release_date` datetime DEFAULT NULL COMMENT '发布时间',
    `index_base_info` text COMMENT '存储ei_base_info的json数据',
    `index_metric` text COMMENT '存储ei_index_metric的json数据	',
    `index_dimension` text COMMENT '存储ei_index_dimension的json数据',
    `index_reference` text COMMENT '存储ei_index_reference的json数据',
    `index_dispatch_info` text COMMENT '存储ei_index_dispatch_info的json数据',
    `project_id` INT ( 11 ) NOT NULL COMMENT '项目主键id',
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户主键id',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT 0 COMMENT '是否删除,1删除，0未删除',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `create_user_id` INT ( 11 ) DEFAULT '0',
    `modify_user_id` INT ( 11 ) DEFAULT '0',
    PRIMARY KEY ( `id` ),
    INDEX `idx_id` ( `idx_id` ) USING BTREE COMMENT '指标ID索引'
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '指标基本信息表';

CREATE TABLE `ei_result_table_field` (
     `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键id',
     `idx_id` int(11) NOT NULL COMMENT '指标id',
     `version` varchar(32) NOT NULL DEFAULT 'V1.0' COMMENT '版本',
     `schema_name` varchar(255) NOT NULL COMMENT 'schema',
     `data_type` varchar(32) NOT NULL COMMENT '数据类型',
     `comment` varchar(255) DEFAULT NULL COMMENT '字段描述',
     `field_name` varchar(255) NOT NULL COMMENT '字段名称',
     `table_name` varchar(255) NOT NULL COMMENT '表名称',
     `alias_name` varchar(32) DEFAULT NULL COMMENT '字段别名',
     `project_id` int(11) NOT NULL COMMENT '项目主键id',
     `tenant_id` int(11) NOT NULL COMMENT '租户主键id',
     `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
     `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
     `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     `create_user_id` int(11) DEFAULT '0',
     `modify_user_id` int(11) DEFAULT '0',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标结果表映射字段历史信息';

CREATE TABLE `rdos_user` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `dtuic_user_id` INT ( 11 ) NOT NULL COMMENT 'dtuic userid',
    `user_name` VARCHAR ( 256 ) NOT NULL COMMENT '用户名称',
    `email` VARCHAR ( 256 ) DEFAULT NULL COMMENT '用户手机号',
    `status` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `phone_number` VARCHAR ( 256 ) DEFAULT NULL COMMENT '用户手机号',
    PRIMARY KEY ( `id` ),
    UNIQUE KEY `index_dtuic_user_id` ( `dtuic_user_id` ),
    KEY `index_user_name` (`user_name` ( 128 ))
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = 'UIC用户表';

CREATE TABLE `rdos_tenant` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `dtuic_tenant_id` INT ( 11 ) NOT NULL COMMENT '租户id',
    `tenant_name` VARCHAR ( 256 ) NOT NULL COMMENT '租户名称',
    `tenant_desc` VARCHAR ( 256 ) DEFAULT NULL COMMENT '租户描述',
    `status` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '租户状态0：正常，1：禁用',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `create_user_id` BIGINT ( 20 ) DEFAULT NULL,
    `data_source_id` int(11) NULL COMMENT '租户presto对应的数据源id',
    `data_source_info` text  NULL COMMENT '租户对应的presto数据源信息',
    PRIMARY KEY ( `id` ),
    UNIQUE KEY `index_tenant_id` ( `dtuic_tenant_id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = 'UIC租户表';

CREATE TABLE `rdos_project` (
    `id` INT ( 11 ) NOT NULL AUTO_INCREMENT,
    `tenant_id` INT ( 11 ) NOT NULL COMMENT '租户id',
    `project_name` VARCHAR ( 256 ) NOT NULL COMMENT '项目名称',
    `project_alias` VARCHAR ( 256 ) NOT NULL COMMENT '项目别名',
    `project_Identifier` VARCHAR ( 256 ) NOT NULL COMMENT '项目标识',
    `project_desc` VARCHAR ( 4000 ) DEFAULT NULL,
    `status` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
    `create_user_id` INT ( 11 ) NOT NULL COMMENT '新建项目的用户id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` TINYINT ( 1 ) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY ( `id` )
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = 'UIC project表';

CREATE TABLE `rdos_batch_sys_parameter` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `param_name` varchar(64) NOT NULL COMMENT '参数名称',
    `param_command` varchar(64) NOT NULL COMMENT '参数替换指令',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `ei_field_alias`  (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `unique_key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段唯一标识（schema_tableName_fieldName）',
   `alias` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段别名',
   `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除',
   `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
   `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COMMENT = '字段别名表';

ALTER TABLE ei_field_alias ADD COLUMN extra_table_alias varchar(50) NULL COMMENT '表别名';

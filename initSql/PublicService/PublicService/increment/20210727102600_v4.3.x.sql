CREATE TABLE `lc_table_life` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `old_table_id` int(11) DEFAULT NULL COMMENT '各平台表id',
                                 `project_id` int(11) NOT NULL COMMENT '项目id',
                                 `uic_tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT 'uic租户id',
                                 `app_type` int(11) NOT NULL DEFAULT '0' COMMENT 'RDOS(1), DQ(2), API(3), TAG(4), MAP(5), CONSOLE(6), STREAM(7), DATASCIENCE(8)',
                                 `table_name` varchar(256) NOT NULL COMMENT '表名称',
                                 `table_type` tinyint(2) NOT NULL COMMENT '表类型',
                                 `table_desc` varchar(2048) NOT NULL DEFAULT '' COMMENT '表描述',
                                 `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
                                 `life_status` int(11) NOT NULL DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
                                 `charge_user_id` int(11) DEFAULT NULL COMMENT '负责人',
                                 `create_user_id` int(11) DEFAULT NULL COMMENT '用户id',
                                 `modify_user_id` int(11) DEFAULT NULL COMMENT '修改人',
                                 `db_schema` varchar(255) NOT NULL DEFAULT '',
                                 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                                 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                                 `data_source_id` int(11) NOT NULL COMMENT '数据源中心数据源iD',
                                 `delete_meta` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除表结构',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_old_talbe_id_apptype` (`old_table_id`,`app_type`) USING BTREE,
                                 KEY `idx` (`uic_tenant_id`,`project_id`,`table_type`,`app_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='hive表的生命周期记录表';

CREATE TABLE if not exists `lc_table_action_record` (
                                            `id` int(11) NOT NULL AUTO_INCREMENT,
                                            `uic_tenant_id` int(11) NOT NULL COMMENT '租户id',
                                            `project_id` int(11) NOT NULL COMMENT '项目id',
                                            `app_type` int(11) NOT NULL DEFAULT '0' COMMENT 'RDOS(1), DQ(2), API(3), TAG(4), MAP(5), CONSOLE(6), STREAM(7), DATASCIENCE(8)',
                                            `user_id` int(11) NOT NULL COMMENT '用户id',
                                            `table_id` int(11) NOT NULL COMMENT '表id',
                                            `action_sql` longtext NOT NULL COMMENT '操作sql语句',
                                            `operate` varchar(100) NOT NULL COMMENT '操作类型 ',
                                            `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                                            `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                            `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录表';



CREATE TABLE `lc_table_process` (
                                    `id` int(11) NOT NULL AUTO_INCREMENT,
                                    `app_type` int(11) NOT NULL,
                                    `data_type_code` int(11) NOT NULL COMMENT '数据源类型对应的code唯一 如Mysql, Oracle, Hive',
                                    `life_process` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '生命周期处理类型比如hive',
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

BEGIN;
INSERT INTO `lc_table_process` VALUES (1, 9, 27, 'hive');
INSERT INTO `lc_table_process` VALUES (3, 9, 7, 'hive');
INSERT INTO `lc_table_process` VALUES (5, 9, 45, 'hive');
COMMIT;
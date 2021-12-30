-- ----------------------------
-- Table structure for role_user
-- ----------------------------
CREATE TABLE `role_user` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `tenant_id` int(11) NOT NULL COMMENT '租户id',
                             `role_id` int(11) NOT NULL COMMENT '角色id',
                             `user_id` int(11) DEFAULT NULL COMMENT '用户id',
                             `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                             `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                             `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                             `cluster_id` int(11) DEFAULT NULL COMMENT '集群id',
                             PRIMARY KEY (`id`) USING BTREE,
                             KEY `idx_cluster_user_role` (`user_id`,`tenant_id`,`cluster_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE `role` (
                        `id` int(11) NOT NULL AUTO_INCREMENT,
                        `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
                        `role_name` varchar(256) NOT NULL COMMENT '角色名称',
                        `role_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
                        `role_value` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), ADMIN(2), MEMBER(3)',
                        `role_desc` varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
                        `modify_user_id` int(11) NOT NULL,
                        `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                        `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                        `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                        `cluster_id` int(11) DEFAULT NULL COMMENT '集群id',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
CREATE TABLE `role_permission` (
                                      `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                      `role_id` int(11) unsigned NOT NULL COMMENT '关联角色id',
                                      `permission_id` int(11) unsigned NOT NULL COMMENT '关联权限id',
                                      `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                                      `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                      `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      KEY `idx_role_permission` (`role_id`,`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
CREATE TABLE `permission` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `code` varchar(256) NOT NULL DEFAULT '' COMMENT '权限CODE',
                                 `name` varchar(256) DEFAULT NULL COMMENT '权限名',
                                 `display` varchar(256) DEFAULT NULL COMMENT '展示名称',
                                 `parent_id` int(11) DEFAULT NULL COMMENT '父权限id',
                                 `type` tinyint(1) DEFAULT '1' COMMENT '1:功能权限;2:数据权限',
                                 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                                 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='权限表';

SET FOREIGN_KEY_CHECKS = 1;



-- ----------------------------
-- Table structure for user
-- ----------------------------
CREATE TABLE `user` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `dtuic_user_id` int(11) NOT NULL COMMENT 'dtuic userid',
                           `user_name` varchar(256) NOT NULL COMMENT '用户名称',
                           `email` varchar(256) NOT NULL COMMENT '用户email',
                           `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
                           `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                           `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                           `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                           `phone_number` varchar(256) DEFAULT NULL COMMENT '用户手机号',
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `idx_dtuic_user_id` (`dtuic_user_id`),
                           KEY `idx_user_name` (`user_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tenant
-- ----------------------------
CREATE TABLE `tenant` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `dtuic_tenant_id` int(11) NOT NULL COMMENT '租户id',
                             `tenant_name` varchar(256) NOT NULL COMMENT '用户名称',
                             `tenant_desc` varchar(256) DEFAULT NULL COMMENT '租户描述',
                             `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
                             `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                             `create_user_id` bigint(20) DEFAULT NULL,
                             `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                             `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                             PRIMARY KEY (`id`),
                             KEY `idx_tenant_name` (`tenant_name`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

--
-- Table structure for table `broker`
--

-- DROP TABLE IF EXISTS `broker`;
CREATE TABLE `broker` (
                          `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                          `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                          `broker_id` int(16) NOT NULL DEFAULT '-1' COMMENT 'brokerid',
                          `host` varchar(128) NOT NULL DEFAULT '' COMMENT 'broker主机名',
                          `port` int(16) NOT NULL DEFAULT '-1' COMMENT 'broker端口',
                          `timestamp` bigint(20) NOT NULL DEFAULT '-1' COMMENT '启动时间',
                          `max_avg_bytes_in` bigint(20) NOT NULL DEFAULT '-1' COMMENT '峰值的均值流量',
                          `version` varchar(128) NOT NULL DEFAULT '' COMMENT 'broker版本',
                          `status` int(16) NOT NULL DEFAULT '0' COMMENT '状态: 0有效，-1无效',
                          `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          `gmt_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `uniq_cluster_id_broker_id` (`cluster_id`,`broker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='broker信息表';

--
-- Table structure for table `broker_metrics`
--

-- DROP TABLE IF EXISTS `broker_metrics`;
CREATE TABLE `broker_metrics` (
                                  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                  `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                  `broker_id` int(16) NOT NULL DEFAULT '-1' COMMENT 'brokerid',
                                  `metrics` text COMMENT '指标',
                                  `messages_in` double(53,2) NOT NULL DEFAULT '0.00' COMMENT '每秒消息数流入',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_cluster_id_broker_id_gmt_create` (`cluster_id`,`broker_id`,`gmt_create`),
  KEY `idx_gmt_create` (`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='broker-metric信息表';

--
-- Table structure for table `cluster`
--

-- DROP TABLE IF EXISTS `cluster`;
CREATE TABLE `cluster` (
                           `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '集群id',
                           `app_type` int(2) NOT NULL DEFAULT '3' COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS，10-MSG',
                           `tenant_id` int(11) NOT NULL COMMENT '租户id',
                           `user_id` int(11) DEFAULT NULL COMMENT '创建项目的用户id',
                           `cluster_name` varchar(128) NOT NULL DEFAULT '' COMMENT '集群名称',
                           `zookeeper` varchar(512) NOT NULL DEFAULT '' COMMENT 'zk地址',
                           `bootstrap_servers` varchar(512) NOT NULL DEFAULT '' COMMENT 'server地址',
                           `kafka_version` varchar(32) NOT NULL DEFAULT '' COMMENT 'kafka版本',
                           `security_properties` text COMMENT 'Kafka安全认证参数',
                           `jmx_properties` text COMMENT 'JMX配置',
                           `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT ' 监控标记, 0表示未监控, 1表示监控中',
                           `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '集群类型, 0表示kafka',
                           `description` text COMMENT '备注信息',
                           `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `gmt_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `uniq_cluster_name` (`cluster_name`, `tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='cluster信息表';

--
-- Table structure for table `cluster_metrics`
--

-- DROP TABLE IF EXISTS `cluster_metrics`;
CREATE TABLE `cluster_metrics` (
                                   `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                   `cluster_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '集群id',
                                   `metrics` text COMMENT '指标',
                                   `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   PRIMARY KEY (`id`),
                                   KEY `idx_cluster_id_gmt_create` (`cluster_id`,`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='clustermetrics信息';

--
-- Table structure for table `controller`
--

-- DROP TABLE IF EXISTS `controller`;
CREATE TABLE `controller` (
                              `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                              `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                              `broker_id` int(16) NOT NULL DEFAULT '-1' COMMENT 'brokerid',
                              `host` varchar(256) NOT NULL DEFAULT '' COMMENT '主机名',
                              `timestamp` bigint(20) NOT NULL DEFAULT '-1' COMMENT 'controller变更时间',
                              `version` int(16) NOT NULL DEFAULT '-1' COMMENT 'controller格式版本',
                              `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `uniq_cluster_id_broker_id_timestamp` (`cluster_id`,`broker_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='controller记录表';


--
-- Table structure for table `operate_record`
--

-- DROP TABLE IF EXISTS `operate_record`;
CREATE TABLE `operate_record` (
                                  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                                  `module_id` int(16) NOT NULL DEFAULT '-1' COMMENT '模块类型, 0:topic, 1:应用, 2:配额, 3:权限, 4:集群, -1:未知',
                                  `operate_id` int(16) NOT NULL DEFAULT '-1' COMMENT '操作类型, 0:新增, 1:删除, 2:修改',
                                  `resource` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称、app名称',
                                  `content` text COMMENT '操作内容',
                                  `operator` varchar(64) NOT NULL DEFAULT '' COMMENT '操作人',
                                  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                  PRIMARY KEY (`id`),
                                  KEY `idx_module_id_operate_id_operator` (`module_id`,`operate_id`,`operator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录';

--
-- Table structure for table `topic`
--

-- DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
                         `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                         `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                         `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称',
                         `peak_bytes_in` bigint(20) DEFAULT '0' COMMENT '峰值流量',
                         `description` text COMMENT '备注信息',
                         `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                         `gmt_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `uniq_cluster_id_topic_name` (`cluster_id`,`topic_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topic信息表';

--
-- Table structure for table `topic_expired`
--

-- DROP TABLE IF EXISTS `topic_expired`;
CREATE TABLE `topic_expired` (
                                 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                                 `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                 `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称',
                                 `produce_connection_num` bigint(20) NOT NULL DEFAULT '0' COMMENT '发送连接数',
                                 `fetch_connection_num` bigint(20) NOT NULL DEFAULT '0' COMMENT '消费连接数',
                                 `expired_day` bigint(20) NOT NULL DEFAULT '0' COMMENT '过期天数',
                                 `gmt_retain` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '保留截止时间',
                                 `status` int(16) NOT NULL DEFAULT '0' COMMENT '-1:可下线, 0:过期待通知, 1+:已通知待反馈',
                                 `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `gmt_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `uniq_cluster_id_topic_name` (`cluster_id`,`topic_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topic过期信息表';

--
-- Table structure for table `topic_metrics`
--

-- DROP TABLE IF EXISTS `topic_metrics`;
CREATE TABLE `topic_metrics` (
                                 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                 `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                 `topic_name` varchar(192) NOT NULL DEFAULT '' COMMENT 'topic名称',
                                 `metrics` text COMMENT '指标数据JSON',
                                 `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 PRIMARY KEY (`id`),
                                 KEY `idx_cluster_id_topic_name_gmt_create` (`cluster_id`,`topic_name`,`gmt_create`),
                                 KEY `idx_gmt_create` (`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topicmetrics表';

--
-- Table structure for table `topic_report`
--

-- DROP TABLE IF EXISTS `topic_report`;
CREATE TABLE `topic_report` (
                                `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `cluster_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '集群id',
                                `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称',
                                `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始上报时间',
                                `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束上报时间',
                                `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `uniq_cluster_id_topic_name` (`cluster_id`,`topic_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='开启jmx采集的topic';

--
-- Table structure for table `topic_request_time_metrics`
--

-- DROP TABLE IF EXISTS `topic_request_time_metrics`;
CREATE TABLE `topic_request_time_metrics` (
                                              `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                                              `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                              `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称',
                                              `metrics` text COMMENT '指标',
                                              `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                              PRIMARY KEY (`id`),
                                              KEY `idx_cluster_id_topic_name_gmt_create` (`cluster_id`,`topic_name`,`gmt_create`),
                                              KEY `idx_gmt_create` (`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topic请求耗时信息';

--
-- Table structure for table `topic_statistics`
--

-- DROP TABLE IF EXISTS `topic_statistics`;
CREATE TABLE `topic_statistics` (
                                    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                    `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                    `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic名称',
                                    `offset_sum` bigint(20) NOT NULL DEFAULT '-1' COMMENT 'offset和',
                                    `max_avg_bytes_in` double(53,2) NOT NULL DEFAULT '-1.00' COMMENT '峰值的均值流量',
  `gmt_day` varchar(64) NOT NULL DEFAULT '' COMMENT '日期2020-03-30的形式',
  `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `max_avg_messages_in` double(53,2) NOT NULL DEFAULT '-1.00' COMMENT '峰值的均值消息条数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_cluster_id_topic_name_gmt_day` (`cluster_id`,`topic_name`,`gmt_day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topic统计信息表';

--
-- Table structure for table `topic_throttled_metrics`
--

-- DROP TABLE IF EXISTS `topic_throttled_metrics`;
CREATE TABLE `topic_throttled_metrics` (
                                           `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                                           `cluster_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '集群id',
                                           `topic_name` varchar(192) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'topic name',
                                           `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'app',
                                           `produce_throttled` tinyint(8) NOT NULL DEFAULT '0' COMMENT '是否是生产耗时',
                                           `fetch_throttled` tinyint(8) NOT NULL DEFAULT '0' COMMENT '是否是消费耗时',
                                           `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                           PRIMARY KEY (`id`),
                                           KEY `idx_cluster_id_topic_name_app_id` (`cluster_id`,`topic_name`,`app_id`),
                                           KEY `idx_gmt_create` (`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='topic限流信息';


-- DROP TABLE IF EXISTS `heartbeat`;
CREATE TABLE `heartbeat` (
                             `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `ip` varchar(128) NOT NULL DEFAULT '' COMMENT '主机ip',
                             `hostname` varchar(256) NOT NULL DEFAULT '' COMMENT '主机名',
                             `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `modify_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `uniq_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='心跳信息';

--
-- Table structure for table `config`
--

-- DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
                          `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
                          `config_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '配置key',
                          `config_value` text COMMENT '配置value',
                          `config_description` text COMMENT '备注说明',
                          `status` int(16) NOT NULL DEFAULT '0' COMMENT '0标识使用中，-1标识已废弃',
                          `gmt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          `gmt_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `uniq_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

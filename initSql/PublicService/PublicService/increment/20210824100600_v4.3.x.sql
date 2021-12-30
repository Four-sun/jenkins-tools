
-- 新增connector表
CREATE TABLE if not exists `dsc_connector` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `connector_type` varchar(64) NOT NULL COMMENT 'connector类型唯一 如Mysql, Oracle, Hive',
  `catalog_name` varchar(128) NOT NULL COMMENT 'Catalog名称',
  `connector_json` text COMMENT 'connector填写的表单信息, 保存为json, key键要与表单的name相同',
  `status` tinyint(4) NOT NULL COMMENT '连接状态 0-连接失败, 1-正常',
  `data_info_id` int(11) NOT NULL COMMENT '关联的数据源id',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE 	    CURRENT_TIMESTAMP,
  `create_user_id` int(11) DEFAULT '0',
  `modify_user_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  CHARSET=utf8 COMMENT='connector详细信息表';



-- hive3给数据质量授权
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
    (2, 'Hive', '3.x', 0, '2021-09-06 16:09:25', '2021-09-06 16:09:25', 0, 0);

-- 增加一个数据源trino，分析型，在doris后面
INSERT INTO `dsc_type` ( `data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
('Trino',7,0.0,'Trino.png',0,'2021-09-07 15:30:00','2021-09-07 15:30:00',0,0,1175,0);

-- Trino数据源可以授权给质量和标签
INSERT INTO `dsc_app_mapping` ( `app_type`, `data_type`, `data_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
( 2, 'Trino', '', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0),
( 4, 'Trino', '', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0);

-- Trino数据源表单属性
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
   ('jdbcUrl', 'JDBC URL', 'Input', 1, 0, NULL, NULL, NULL, 1, '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', 'Trino JDBC URL支持如下格式\n jdbc:trino://host:port \n jdbc:trino://host:port/catalog \n jdbc:trino://host:port/catalog/schema', NULL, '/jdbc:trino:\\/\\/(.)+/', 'Trino', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0,''),
    ('username', '用户名', 'Input', 1, 0, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'Trino', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0,''),
    ('password', '密码', 'Password', 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 'Trino', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0,''),
    ('openKerberos', '开启Kerberos认证', 'Kerberos', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Trino', 0, '2021-09-07 15:30:00','2021-09-07 15:30:00', 0, 0,'');


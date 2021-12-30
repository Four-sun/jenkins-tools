-- 增加一个数据源类型 ADB_PostgreSQL，排序在 kylin 后面
INSERT INTO `dsc_type` (`data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
('ADB_PostgreSQL',7,0.0,'ADB_PostgreSQL.png',0,'2021-06-01 12:22:10','2021-06-01 12:22:10',0,0,1220,0);

-- ADB_PostgreSQL 数据源授权给实时以及离线
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
(1, 'ADB_PostgreSQL', 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0),
(7, 'ADB_PostgreSQL', 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0);

-- ADB_PostgreSQL 添加表单信息
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `type_version`)
VALUES
('jdbcUrl', 'JDBC URL', 'Input', 1, 0, NULL, NULL, NULL, 1, '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', '示例：jdbc:postgresql://host:port/database', NULL, '/jdbc:postgresql:\\/\\/(.)+/', 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'ADB_PostgreSQL'),
('username', '用户名', 'Input', 1, 0, NULL, NULL, NULL, 1, '', NULL, NULL, NULL, 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'ADB_PostgreSQL'),
('password', '密码', 'Password', 1, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'ADB_PostgreSQL');

-- 增加一个数据源类型 Vertica，排序在 GBase_8a 后面
INSERT INTO `dsc_type` (`data_type`, `data_classify_id`, `weight`, `img_url`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `sorted`, `invisible`)
VALUES
('Vertica',5,0.0,'Vertica.png',0,'2021-06-01 12:22:10','2021-06-01 12:22:10',0,0,1720,0);

-- Vertica 数据源授权给数据资产
INSERT INTO `dsc_app_mapping` (`app_type`, `data_type`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`)
VALUES
(9, 'Vertica', 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0);

-- Vertica 添加表单信息
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `type_version`)
VALUES
('jdbcUrl', 'JDBC URL', 'Input', 1, 0, NULL, NULL, NULL, 1, '{\"regex\":{\"message\":\"JDBC URL格式不符合规则!\"}}', '示例：jdbc:vertica://host:port/dbName', NULL, '/jdbc:vertica:\\/\\/(.)+/', 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'Vertica'),
('username', '用户名', 'Input', 1, 0, NULL, NULL, NULL, 1, '', NULL, NULL, NULL, 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'Vertica'),
('password', '密码', 'Password', 1, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 0, '2021-06-01 12:22:10', '2021-06-01 12:22:10', 0, 0, 'Vertica');

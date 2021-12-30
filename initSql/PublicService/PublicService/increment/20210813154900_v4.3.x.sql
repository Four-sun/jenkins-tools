-- es7增加openSSL表单属性
INSERT INTO `dsc_form_field` (`name`, `label`, `widget`, `required`, `invisible`, `default_value`, `place_hold`, `request_api`, `is_link`, `valid_info`, `tooltip`, `style`, `regex`, `type_version`, `is_deleted`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`,`options`)
VALUES
('openSSL', '开启SSL认证', 'SSL', 0, 0, NULL, NULL, NULL, 0, '', NULL, NULL, NULL, 'Elasticsearch-7.x', 0, '2021-08-13 15:56:27', '2021-08-13 15:56:27', 0, 0,'');

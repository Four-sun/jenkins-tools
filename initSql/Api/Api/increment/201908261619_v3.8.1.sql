-- API 添加是否分页和分页 SQL
ALTER TABLE `da_api`
    ADD COLUMN `contain_page` int(11) DEFAULT '0' COMMENT '返回结果是否携带 Page 分页信息， 0-不携带，1-携带' AFTER `contain_header`;
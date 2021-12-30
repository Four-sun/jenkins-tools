-- API 添加是否存储 xml、xml存储字段、协议
ALTER TABLE `da_api`
    ADD COLUMN `wsdl_xml` text NULL COMMENT 'wsdl xml 文件' AFTER `api_version_code`;
ALTER TABLE `da_api`
    ADD COLUMN `save_wsdl_xml` int(11) DEFAULT '0' COMMENT '是否存储 wsdl xml 标记， 0-不存储，1-存储' AFTER `wsdl_xml`;
ALTER TABLE `da_api`
    ADD COLUMN `protocol` varchar(20) NULL COMMENT '协议' AFTER `save_wsdl_xml`;
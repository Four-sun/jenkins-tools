-- API 添加是否存储 xml、xml存储字段、协议
ALTER TABLE `da_api`
    ADD COLUMN `contain_header` int(11) DEFAULT '0' COMMENT '返回结果是否携带 header 中的输入参数， 0-不携带，1-携带' AFTER `protocol`;
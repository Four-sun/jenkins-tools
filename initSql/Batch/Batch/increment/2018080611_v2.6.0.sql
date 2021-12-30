ALTER TABLE `rdos_batch_data_source`
ADD COLUMN `link_state` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用' AFTER `active`;
ALTER TABLE `rdos_stream_data_source`
ADD COLUMN `link_state` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用' AFTER `active`;

alter table `rdos_hive_table_info` modify column `delim` varchar(50) NULL COMMENT '列分隔符';
alter table `rdos_hive_table_info_deleted` modify column `delim` varchar(50) NULL COMMENT '列分隔符';
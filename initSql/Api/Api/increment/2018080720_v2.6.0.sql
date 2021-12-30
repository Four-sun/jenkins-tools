
ALTER TABLE `da_data_source`
ADD COLUMN `link_state` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用' AFTER `active`;
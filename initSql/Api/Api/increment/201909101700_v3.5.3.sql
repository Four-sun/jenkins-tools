-- API添加唯一索引
ALTER  TABLE  `da_data_source_ref` DROP  INDEX  `idx_bizType_relationId_dataSourceId`;
ALTER TABLE `da_data_source_ref` ADD UNIQUE INDEX `index_bizType_relationId_dataSourceId` (`biz_type`,`relation_id`,`data_source_id`);

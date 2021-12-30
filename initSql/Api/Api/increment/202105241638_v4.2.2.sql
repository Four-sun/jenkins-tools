-- 修改枚举值
ALTER TABLE `da_api`
CHANGE COLUMN `app_type` `app_type` INT(2) NOT NULL DEFAULT '3' COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS';
ALTER TABLE `da_api_test`
CHANGE COLUMN `app_type` `app_type` INT(2) NOT NULL DEFAULT '3' COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS' ;

-- 修改数据
update da_api set app_type = 3;
update da_api_test set app_type = 3;

-- da_project表增加external_project_id和app_type字段
ALTER TABLE `da_project`
ADD COLUMN `external_project_id` INT(11) NULL COMMENT '外部项目ID' AFTER `id`,
ADD COLUMN `app_type` INT(2) NOT NULL DEFAULT 3 COMMENT '应用标识：1-RDOS，2-DQ，3-API，4-TAG，5-MAP，6-CONSOLE，7-STREAM，8-DATASCIENCE，9-DATAASSETS' AFTER `external_project_id`;

-- 增加联合索引
ALTER TABLE `da_project`
ADD INDEX `index_external_project_id_app_type` (`external_project_id` ASC, `app_type` ASC);
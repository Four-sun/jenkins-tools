-- 说明：该文件从3.9版本merge进来，由于遗留时间较久，修改名称便于3.10升级时引起注意

-- 脱敏链路只增不减bug fix

ALTER TABLE `rdos_datamask_columns_info`
ADD COLUMN `is_origin` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否原始配置脱敏字段 1:原始脱敏字段' AFTER `is_deleted`;

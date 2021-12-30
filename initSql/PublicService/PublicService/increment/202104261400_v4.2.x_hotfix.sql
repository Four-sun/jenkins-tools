-- 模型表增加租户ID字段
ALTER TABLE `dt_pub_service`.`dm_model`
ADD COLUMN `tenant_id` int(11) COMMENT '租户ID' AFTER `completed_step`,
ADD COLUMN `dtuic_tenant_id` int(11) COMMENT 'dtuic租户ID' AFTER `tenant_id`;
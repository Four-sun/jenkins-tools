-- uic_license表增加is_all字段
ALTER TABLE `uic_license` ADD COLUMN `is_all` tinyint(1) DEFAULT 1 COMMENT '过期时间是否全局配置，1是，2否，子产品单独配置' AFTER `target`;
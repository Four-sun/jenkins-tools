BEGIN;
ALTER TABLE `rdos_project` ADD COLUMN `is_open_meta_data` tinyint(1)  NOT NULL DEFAULT '0' COMMENT '是否开启元数据' ;
COMMIT;
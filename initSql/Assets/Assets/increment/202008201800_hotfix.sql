CREATE TABLE `assets_sync_job_thread` (
	`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`job_id` VARCHAR(32) NOT NULL COMMENT '对应task服务的job_id 标识唯一周期实例',
  `thread_id` VARCHAR(32) NOT NULL COMMENT '线程id',
	`table_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步总表数量',
	`table_success_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步表成功的数量',
	`table_fail_count` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '同步表失败的数量',
	`fail_table` LONGTEXT NULL COMMENT '同步失败的表名 逗号隔开',
	`job_log` LONGTEXT NULL COMMENT '任务日志 错误信息',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
	PRIMARY KEY (`id`)
)
COMMENT='周期同步实例线程表'
ENGINE=InnoDB
;

ALTER TABLE `assets_sync_job_thread`
  add UNIQUE INDEX `uk_job_id_thread_id` (`job_id`,`thread_id`) USING BTREE;

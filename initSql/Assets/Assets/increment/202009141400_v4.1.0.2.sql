CREATE TABLE `assets_resource_catalog` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`catalog_name` VARCHAR(100) NOT NULL COMMENT '目录名称' COLLATE 'utf8_bin',
  `parent_id` BIGINT(100) NOT NULL DEFAULT '-1' COMMENT '父id',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT = '资源目录表' ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `assets_resource` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
	`create_by` INT(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
	`update_by` INT(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
	`is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
	`resource_name` VARCHAR(100) NOT NULL COMMENT '资源名称' COLLATE 'utf8_bin',
	`resource_name_cn` VARCHAR(100) NULL COMMENT '资源中文名' COLLATE 'utf8_bin',
  `data_id` BIGINT(100) NOT NULL  COMMENT '元数据id(表id或者字段id)',
  `catalog_id` BIGINT(100) NOT NULL  COMMENT '资源目录id',
  `db_id` BIGINT(100) NOT NULL  COMMENT '库id',
  `table_id` BIGINT(100) NOT NULL  COMMENT '表id',
  `table_owner` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '表负责人',
  `resource_type` BIGINT(100) NOT NULL  COMMENT '资源类型',
	`resource_status` TINYINT(1) NOT NULL COMMENT '发布状态,0已下线,1已发布',
	`tenant_id` BIGINT(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`)
) COMMENT = '数据资源表' ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `assets_resource`
  ADD UNIQUE INDEX `uk_data_id_resource_type` (`data_id`, `resource_type`),
	ADD INDEX `idx_db_id` (`db_id`),
	ADD INDEX `idx_table_id` (`table_id`);

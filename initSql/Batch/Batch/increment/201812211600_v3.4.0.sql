CREATE TABLE `rdos_datamask_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `table_id` int(11) NOT NULL COMMENT '关联表id',
  `column_name` varchar(128) NOT NULL COMMENT '列名称',
  `rule_id` int(11) NOT NULL COMMENT '关联规则id',
  `example` varchar(255) COMMENT '样例',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
  `enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 小于0逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`),
  UNIQUE KEY `unique_table_id_column` (`table_id`,`column_name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `rdos_datamask_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `example` varchar(255) COMMENT '样例',
  `mask_type` int(11) NOT NULL COMMENT '脱敏效果 0-全部脱敏 1-部分脱敏',
  `replace_str` varchar(32) NOT NULL COMMENT '替换字符',
  `begin_pos` int(11) NOT NULL DEFAULT '0' COMMENT '起始位置',
  `end_pos` int(11) NOT NULL DEFAULT '0' COMMENT '结束位置',
  `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 小于0逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `rdos_datamask_parse_record`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `job_id` varchar(63) NOT NULL COMMENT '工作任务id',
    `status` tinyint(1) NULL COMMENT 'job状态',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_job_id` (`job_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


create table `rdos_datamask_columns_info`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `tenant_id` int(11) NOT NULL COMMENT '租户id',
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `config_id` int(11) NOT NULL COMMENT '关联脱敏配置id',
    `table_id` int(11) NOT NULL COMMENT '关联表id',
    `column_name` varchar(128) NOT NULL COMMENT '列名称',
    `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
    `enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 小于0逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_config_table_column` (`config_id`,`table_id`,`column_name`,`is_deleted`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 脱敏权限
DELIMITER //
create procedure add_datamask_permission()
BEGIN

	declare rId int(11);
	declare flag int default 0;
	DECLARE cur CURSOR FOR ( SELECT id FROM rdos_role WHERE role_type = 1 AND is_deleted = 0 );
	DECLARE cur2 CURSOR FOR ( SELECT id FROM rdos_role WHERE role_value = 6 AND is_deleted = 0 );
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL;


	set @pId = (select id from rdos_permission where code = "root");

    INSERT INTO `rdos_permission` (code, name, display, parent_id, type) VALUES ('datamask','数据脱敏','数据脱敏',@pId,1);

    select id into @pId from rdos_permission where code = "datamask" limit 1;

    INSERT INTO `rdos_permission` (code, name, display, parent_id, type) VALUES ('datamask_rule_edit','数据脱敏_规则编辑','规则编辑',@pId,1),
	('datamask_rule_query','数据脱敏_规则查看','规则查看',@pId,1), ('datamask_config_edit','数据脱敏_配置编辑','配置编辑',@pId,1),
	('datamask_config_query','数据脱敏_配置查看','配置查看',@pId,1),('batchintegration_batch_dbsync','数据集成_整库同步','整库同步',@pId,1);


		SET @id1 = ( SELECT id FROM rdos_permission WHERE code = "datamask_rule_edit" limit 1);
		SET @id2 = ( SELECT id FROM rdos_permission WHERE code = "datamask_config_edit" limit 1);
		SET @id3 = ( SELECT id FROM rdos_permission WHERE code = "datamask_rule_query" limit 1);
		SET @id4 = ( SELECT id FROM rdos_permission WHERE code = "datamask_config_query" limit 1);
		SET @id5 = ( SELECT id FROM rdos_permission WHERE code = "batchintegration_batch_dbsync" limit 1);
		SET @id6 = ( SELECT id FROM rdos_permission WHERE code = "datadevelop_batch_taskmanager_publish" limit 1);


	OPEN cur;
		FETCH cur into rId;
		WHILE ( flag IS NOT NULL ) DO
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id1 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id2 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id3 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id4 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id5 );
			FETCH cur INTO rId;

		END WHILE;
	CLOSE cur;

	OPEN cur2;
		FETCH cur2 into rId;
		WHILE ( flag IS NOT NULL ) DO
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id6 );

			FETCH cur2 INTO rId;

		END WHILE;
	CLOSE cur2;

	-- 访客
    UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id in ( SELECT id FROM rdos_role WHERE role_value = 4 )
		AND permission_id IN ( SELECT id FROM rdos_permission WHERE type = 1 AND CODE IN (
		  'datamask_rule_edit',
		  'datamask_config_edit',
		  'batchintegration_batch_dbsync'
		)
	);

	-- 运维
    UPDATE rdos_role_permission
    SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 5) AND permission_id IN (
      SELECT id from rdos_permission where type = 1 and code in (
        'datamask_rule_edit',
		    'datamask_config_edit',
		    'batchintegration_batch_dbsync',
		    'batchintegration_batch_edit'
      )
    );

	-- 数据开发
  UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id in ( SELECT id FROM rdos_role WHERE role_value = 6 )
		AND permission_id IN ( SELECT id FROM rdos_permission  WHERE type = 1 AND CODE IN (
        'datamask_rule_edit',
		    'datamask_config_edit',
		    'batchintegration_batch_edit'
		)
	);

	UPDATE rdos_role_permission
	SET is_deleted = 0 WHERE role_id in ( SELECT id FROM rdos_role WHERE role_value = 6 )
		AND permission_id IN ( SELECT id FROM rdos_permission  WHERE type = 1 AND CODE IN (
        'datadevelop_batch_taskmanager_publish'
		)
	);


--   SET @userId=(SELECT id FROM rdos_user WHERE dtuic_user_id=1);
--   INSERT INTO rdos_datamask_rule (tenant_id,NAME,mask_type,replace_str,begin_pos,end_pos,modify_user_id,example) VALUES
--   (-1,'身份证',1,'*',3,18,@userId,'32****************'),
--   (-1,'银行卡号',1,'*',5,20,@userId,'6214****************'),
--   (-1,'邮箱',1,'*',4,32,@userId,'swee****************'),
--   (-1,'手机号',1,'*',4,11,@userId,'188*******'),
--   (-1,'IP',1,'*',6,16,@userId,'123.1**********'),
--   (-1,'MAC地址',1,'*',5,17,@userId,'EA-A4****'),
--   (-1,'固定电话',1,'*',5,13,@userId,'0571*********'),
--   (-1,'车牌号',1,'*',4,8,@userId,'浙A2*****'),
--   (-1,'公司',1,'*',5,200,@userId,'杭州玳数*****'),
--   (-1,'地址',1,'*',5,200,@userId,'浙江省杭******'),
--   (-1,'姓名',1,'*',2,5,@userId,'张*');



END;//

DELIMITER ;

call add_datamask_permission();

UPDATE rdos_role SET role_desc = '能够创建任务、脚本、资源等，新建/删除表，但不能执行发布操作，不能管理数据源。'  WHERE role_value = 6;

-- project表新增字段
alter table rdos_project add column is_allow_download tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否允许下载查询结果 1-正常 0-禁用';

alter table rdos_batch_hive_select_sql add column parsed_columns LONGTEXT NULL COMMENT '字段信息';

alter table rdos_batch_task_version add column origin_sql LONGTEXT NULL COMMENT '原始sql';

create table `rdos_batch_task_record` (
    `id` int(11) NOT NULL auto_increment,
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `tenant_id` int(11) NOT NULL COMMENT '租户id',
    `record_type` int(2) NOT NULL COMMENT '记录类型',
    `task_id` int(11) NOT NULL COMMENT '任务id',
    `operator_id` int(11) NOT NULL COMMENT '操作者id',
    `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
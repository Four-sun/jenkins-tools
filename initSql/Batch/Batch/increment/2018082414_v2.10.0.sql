-- 离线任务类型
insert into rdos_dict (`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
  ('10', 'SPARK_SQL', '0', 'SparkSQL', 'SparkSQL', '1', now(), now(), '0'),
  ('10', 'SPARK', '1', 'Spark', 'Spark', '2', now(), now(), '0'),
  ('10', 'SPARK_PYTHON', '3', 'PySpark', 'PySpark', '3', now(), now(), '0'),
  ('10', 'HADOOP_MR', '9', 'HadoopMR', 'HadoopMR', '4', now(), now(), '0'),
  ('10', 'SYNC', '2', '数据同步', 'SYNC', '5', now(), now(), '0'),
  ('10', 'WORK_FLOW', '10', '工作流', 'WORKFLOW', '6', now(), now(), '0'),
  ('10', 'ML_LIb', '8', '机器学习', 'ML LIb', '7', now(), now(), '0'),
  ('10', 'DEEP_LEARNING', '5', '深度学习', 'Deep Learning', '8', now(), now(), '0'),
  ('10', 'PYTHON', '6', 'Python', 'Python', '9', now(), now(), '0'),
  ('10', 'SHELL', '7', 'Shell', 'Shell', '10', now(), now(), '0'),
  ('10', 'VIRTUAL', '-1', '虚节点', 'Virtual', '11', now(), now(), '0');
-- 离线任务类型
insert into rdos_dict (`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
  ('11', 'SPARK_SQL', '0', 'SparkSQL', 'SparkSQL', '1', now(), now(), '0'),
  ('11', 'SPARK', '1', 'Spark', 'Spark', '2', now(), now(), '0'),
  ('11', 'SYNC', '2', '数据同步', 'SYNC', '3', now(), now(), '0'),
  ('11', 'WORK_FLOW', '10', '工作流', 'WORKFLOW', '4', now(), now(), '0'),
  ('11', 'VIRTUAL', '-1', '虚节点', 'Virtual', '5', now(), now(), '0');


-- add columns to rdos_project
alter table `rdos_project` add column `project_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型:0-普通项目，1-测试项目，2-生产项目';
alter table `rdos_project` add column `produce_project_id` int(11) NULL COMMENT '绑定的生产项目id';
alter table `rdos_project` add column `schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '调度状态：0-开启，1-关闭';


alter table rdos_batch_task_process_record drop column job_id;
alter table rdos_batch_task_process_record drop column type;
alter table rdos_batch_task_process_record add column `status` tinyint(1) NULL COMMENT 'job状态';
alter table rdos_batch_task_process_record add column `job_id` varchar(256) NOT NULL COMMENT '工作任务id';
alter ignore table rdos_batch_task_process_record add UNIQUE KEY `idx` (`job_id`(128));
insert into rdos_batch_task_process_record(job_id,status) select job_id,status from rdos_engine_batch_job;

-- alter rdos_batch_task_shade
alter table `rdos_batch_task_shade` add column `is_publish_to_produce` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布到生产环境：0-否，1-是';


-- alter rdos_hive_table_info
alter table `rdos_hive_table_info` add column `modify_user_id` int(11) NOT NULL COMMENT '修改人';
update rdos_hive_table_info set modify_user_id = user_id;

-- rdos_hive_table_info_deleted
alter table `rdos_hive_table_info_deleted` add column `modify_user_id` int(11) NOT NULL COMMENT '修改人';
update rdos_hive_table_info_deleted set modify_user_id = user_id;

-- rdos_batch_resource
alter table `rdos_batch_resource` add column `modify_user_id` int(11) NOT NULL COMMENT '修改人';
update rdos_batch_resource set modify_user_id = create_user_id;


-- add rdos_batch_test_produce_resource
CREATE TABLE `rdos_batch_test_produce_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `test_resource_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_resource_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_resource_id`,`produce_resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- add rdos_batch_test_produce_task
CREATE TABLE `rdos_batch_test_produce_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `test_task_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_task_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_task_id`,`produce_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- add rdos_batch_test_produce_data_source
CREATE TABLE `rdos_batch_test_produce_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_data_source_id` varchar(128) NOT NULL COMMENT '数据源id',
  `produce_data_source_id` varchar(128) NOT NULL COMMENT '关联数据源id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`test_data_source_id`,`produce_data_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- add rdos_batch_package
CREATE TABLE `rdos_batch_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `name` varchar(200) NOT NULL COMMENT '包名称',
  `comment` varchar(500) NOT NULL COMMENT '描述',
  `create_user_id` int(11) NOT NULL COMMENT '申请人',
  `publish_user_id` int(11) NULL COMMENT '发布人',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布状态：0-待发布，1-成功，2-失败',
  `log` text DEFAULT NULL comment '失败日志',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx` (`tenant_id`,`project_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- add rdos_batch_package_item
CREATE TABLE `rdos_batch_package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `package_id` int(11) NOT NULL COMMENT '发布包id',
  `item_id` int(11) NOT NULL COMMENT '发布包下的资源id',
  `item_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '资源类型：0-任务，1-表，2-资源，3-函数',
  `item_inner_type` tinyint(1) NULL COMMENT '资源具体类型',
  `publish_param` text DEFAULT NULL COMMENT '发布参数,json格式',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间,申请时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间，发布时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`package_id`,`item_id`,`item_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- 权限点  数据管理
drop procedure if exists update_permission;

DELIMITER //
create procedure update_permission()
BEGIN

	declare rId int(11);
	declare flag int default 0;
	DECLARE cur CURSOR FOR ( SELECT id FROM rdos_role WHERE role_type = 1 AND is_deleted = 0 );
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL;

    set @pId = (select id from rdos_permission where code = "maintenance_batchtaskmanager");
    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
         VALUES ('maintenance_batchtaskmanager_query','运维中心_离线任务管理_查看','查看',@pId,1,now(),now(),0);

	set @pId = (select id from rdos_permission where code = "root");

    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
     VALUES ('test_produce','生产测试项目','生产测试项目',@pId,1,now(),now(),0);

    select id into @pId from rdos_permission where code = "test_produce";

    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
    values ('test_produce_binding_project','生产测试项目_项目绑定','项目绑定',@pId,1,now(),now(),0),
    ('test_produce_edit_schedule_status','生产测试项目_编辑调度状态','编辑调度状态',@pId,1,now(),now(),0),
    ('test_produce_edit_package','生产测试项目_编辑包','编辑包',@pId,1,now(),now(),0),
    ('test_produce_query_package','生产测试项目_查看包','查看包',@pId,1,now(),now(),0),
    ('test_produce_publish_package','生产测试项目_发布包','发布包',@pId,1,now(),now(),0);

		SET @id1 = ( SELECT id FROM rdos_permission WHERE code = "test_produce_binding_project" limit 1);
		SET @id2 = ( SELECT id FROM rdos_permission WHERE code = "test_produce_edit_schedule_status" limit 1);
		SET @id3 = ( SELECT id FROM rdos_permission WHERE code = "test_produce_edit_package" limit 1);
		SET @id4 = ( SELECT id FROM rdos_permission WHERE code = "test_produce_query_package" limit 1);
		SET @id5 = ( SELECT id FROM rdos_permission WHERE code = "test_produce_publish_package" limit 1);

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

    -- 访客
    UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id in ( SELECT id FROM rdos_role WHERE role_value = 4 )
		AND permission_id IN ( SELECT id FROM rdos_permission WHERE type = 1 AND CODE IN (
		'test_produce',
		'test_produce_binding_project',
		'test_produce_edit_schedule_status',
		'test_produce_edit_package',
		'test_produce_publish_package',
		'maintenance_batchtaskmanager_query'
		)
	);

	-- 运维
    UPDATE rdos_role_permission SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 5) and permission_id IN (
      SELECT id from rdos_permission where type = 1 and code in (
        'test_produce_edit_schedule_status',
        'test_produce_binding_project'
      )
    );

	-- 数据开发
    UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id in ( SELECT id FROM rdos_role WHERE role_value = 6 )
		AND permission_id IN ( SELECT id  FROM rdos_permission  WHERE type = 1 AND CODE IN (
        'test_produce_publish_package',
        'test_produce_binding_project',
        'test_produce_edit_schedule_status'
		)
	) ;

END;//

DELIMITER ;

call update_permission();



drop procedure if exists insert_role_permission;

DELIMITER //

create procedure insert_role_permission()
begin

declare ten_id int(11);
declare flag int default 0;
declare perm_id INT DEFAULT 0;
declare cur cursor for (select id from rdos_role where is_deleted=0 and role_value<>4);
declare continue handler for sqlstate '02000' set flag = null;

set @perm_id = (select id from rdos_permission where code = 'maintenance_batchtaskmanager_query' and is_deleted = 0 limit 1);

open cur;
        fetch cur into ten_id;
        while (flag is not null) do


            insert into rdos_role_permission (role_id,permission_id,gmt_create,gmt_modified,is_deleted)
                values(ten_id, @perm_id,now(),now(),0);

        fetch cur into ten_id;
            end while;
    close cur;

end; //

DELIMITER ;

call insert_role_permission();
-- 同步历史数据，组件管理
DROP PROCEDURE IF EXISTS table_manage_add_catalogue_to_old_project;
delimiter //
create procedure table_manage_add_catalogue_to_old_project()
 begin
    DECLARE stop INT DEFAULT 0;
    DECLARE projectId INT;
    DECLARE tenantId INT;
    DECLARE userId INT;
    DECLARE  id_cur CURSOR  FOR  SELECT id FROM rdos_project where is_deleted = 0;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;
    OPEN   id_cur;
     FETCH id_cur INTO projectId;
     WHILE ( stop is not null) DO
        select tenant_id from rdos_project where id = projectId into tenantId;
        select create_user_id from rdos_project where id = projectId into userId;
        SET @tmp_id = (select id from rdos_batch_catalogue where project_id = projectId and node_name = '组件管理' and level = 0 and is_deleted = 0);
        IF  @tmp_id is null THEN
            insert into rdos_batch_catalogue (project_id, node_name, node_pid, order_val, level, tenant_id, create_user_id) values (projectId, '组件管理', 0, 4, 0, tenantId, userId);
            select id from rdos_batch_catalogue where project_id = projectId and node_name = '组件管理' and is_deleted = 0 and level = 0 into @node_level_id;
            insert into rdos_batch_catalogue (project_id, node_name, node_pid, level, tenant_id, create_user_id, order_val) values (projectId, 'Hive SQL', @node_level_id, 1, tenantId, userId, 2);
            insert into rdos_batch_catalogue (project_id, node_name, node_pid, level, tenant_id, create_user_id, order_val) values (projectId, 'Spark SQL', @node_level_id, 1, tenantId, userId, 1);
        end if;
       FETCH id_cur INTO projectId;
     END WHILE;
    CLOSE id_cur;
 end //
delimiter ;
call table_manage_add_catalogue_to_old_project();
drop procedure  table_manage_add_catalogue_to_old_project;

-- 调整排序规则
update rdos_dict set dict_value = 6, dict_sort = 6 where type = 4 and dict_value = 5 and is_deleted = 0;
update rdos_dict set dict_value = 6, dict_sort = 6 where type = 6 and dict_value = 5 and is_deleted = 0;

INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
    ('4', 'ComponentManager', '5', '组件管理', 'ComponentManager', '5', now(), now(), 0),
    ('6', 'Spark SQL', '5', 'Spark SQL', 'Spark SQL', '1', now(), now(), 0),
    ('6', 'Hive SQL', '5', 'Hive SQL', 'Hive SQL', '2', now(), now(), 0);

-- 组件表
CREATE TABLE `rdos_batch_component` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `name` varchar(256) NOT NULL COMMENT '组件名称',
  `component_type` tinyint(1) NOT NULL COMMENT '组件类型 1:hiveSql, 2:sparkSql',
  `component_desc` varchar(512) COMMENT '组件描述',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `input_params` text NOT NULL COMMENT '输入参数',
  `output_params` text NOT NULL COMMENT '输出参数',
  `system_params` text NOT NULL COMMENT '系统参数',
  `custom_params` text NOT NULL COMMENT '自定义参数',
  `submit_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:未提交, 1:已提交',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '组件版本',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人id',
  `create_user_id` int(11) NOT NULL COMMENT '新建组件的用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改组件的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT ='组件表';

-- 组件版本表
CREATE TABLE `rdos_batch_component_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `component_id` int(11) NOT NULL COMMENT '组件id',
  `version` int(11) NOT NULL COMMENT '组件版本号',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `name` varchar(256) NOT NULL COMMENT '组件名称',
  `component_type` tinyint(1) NOT NULL COMMENT '组件类型 1:hiveSql, 2:sparkSql',
  `component_desc` varchar(512) NOT NULL COMMENT '组件描述',
  `sql_text` LONGTEXT NOT NULL COMMENT 'sql 文本',
  `input_params` text NOT NULL COMMENT '输入参数',
  `output_params` text NOT NULL COMMENT '输出参数',
  `system_params` text NOT NULL COMMENT '系统参数',
  `custom_params` text NOT NULL COMMENT '自定义参数',
  `publish_desc` text COMMENT '提交描述',
  `owner_user_id` int(11) NOT NULL COMMENT '负责人id',
  `create_user_id` int(11) NOT NULL COMMENT '新建组件的用户id',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改组件的用户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT ='组件版本表';

-- 组件引用记录表
CREATE TABLE `rdos_batch_component_task_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `component_id` int(11) NOT NULL COMMENT '组件id',
  `task_id` varchar(256) NOT NULL COMMENT '任务id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT ='组件任务引用关系表';

-- 任务表加使用的组件版本号
alter table `rdos_batch_task` add column `component_id` int(11) COMMENT '使用的组件版本id';

-- 增加组件角色
drop procedure if exists update_permission;
DELIMITER //
create procedure update_permission()
BEGIN
		DECLARE rId int(11);
		DECLARE flag int default 0;
		DECLARE cur CURSOR FOR ( SELECT id FROM rdos_role WHERE role_type = 1 AND is_deleted = 0 AND role_value in (1, 2, 3, 6, 8, 9));
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL;

		set @pId1 = (select id from rdos_permission where code = "datadevelop_batch");
    	INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
     		VALUES ('component','数据开发_离线任务_组件管理','组件管理',@pId1,1,now(),now(),0);
     	set @pId2 = (select id from rdos_permission where code = "component");
     	INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
     		VALUES ('component_edit','数据开发_离线任务_组件管理_编辑','编辑',@pId2,1,now(),now(),0);
     	INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
     		VALUES ('component_query','数据开发_离线任务_组件管理_查看','查看',@pId2,1,now(),now(),0);
    	SET @id1 = ( SELECT id FROM rdos_permission WHERE code = "component" limit 1);
    	SET @id2 = ( SELECT id FROM rdos_permission WHERE code = "component_edit" limit 1);
    	SET @id3 = ( SELECT id FROM rdos_permission WHERE code = "component_query" limit 1);

		OPEN cur;
            FETCH cur into rId;
            WHILE ( flag IS NOT NULL ) DO
                    INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id1 );
                    INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id2 );
                    INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id3 );
                FETCH cur INTO rId;
            END WHILE;
        CLOSE cur;

END;//
DELIMITER ;
call update_permission();

drop procedure if exists update_permission;
DELIMITER //
create procedure update_permission()
BEGIN
		DECLARE rId int(11);
		DECLARE flag int default 0;
		DECLARE cur CURSOR FOR ( SELECT id FROM rdos_role WHERE role_type = 1 AND is_deleted = 0 AND role_value in (4, 5));
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL;

    	SET @id = ( SELECT id FROM rdos_permission WHERE code = "component_query" limit 1);

		OPEN cur;
            FETCH cur into rId;
            WHILE ( flag IS NOT NULL ) DO
                    INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id );
                FETCH cur INTO rId;
            END WHILE;
        CLOSE cur;

END;//
DELIMITER ;
call update_permission();
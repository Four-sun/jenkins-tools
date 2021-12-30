CREATE TABLE `rdos_batch_data_source_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `data_source_id` int(11) NOT NULL DEFAULT '0' COMMENT '数据源id',
  `schedule_conf` varchar(512) DEFAULT '' COMMENT '调度配置 json格式',
  `sync_type` TINYINT(1) NOT NULL COMMENT '同步类型：1=增量 2=全量',
  `time_field_identifier` varchar(32) DEFAULT '' COMMENT '日期标识字段，全量为空',
  `parallel_type` TINYINT(1) NOT NULL COMMENT '并发配置：1=分批上传 2=整批上传',
  `parallel_conf` varchar(32) DEFAULT '' COMMENT '分批上传需配置',
  `transform_field_config` text DEFAULT NULL COMMENT '字段转换规则, json array',
  `create_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



CREATE TABLE `rdos_batch_data_source_migration_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `migration_id` int(11) NOT NULL DEFAULT '0' COMMENT '迁移id',
  `task_id` int(11) NOT NULL DEFAULT '0' COMMENT 'taskId',
  `job_id` int(11) NOT NULL DEFAULT '0' COMMENT 'jobId',
  `table_name` varchar(32) NOT NULL DEFAULT '' COMMENT '表名',
  `ide_table_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'ide中hive表名',
  `status` int(11) NOT NULL COMMENT '任务创建状态',
  `report` text DEFAULT NULL COMMENT '日志报告',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



-- 资源申请表
create table `rdos_batch_apply`(
  `id` int(11) not null auto_increment,
  `tenant_id` int(11) not null comment '租户id',
  `project_id` int(11) not null comment '资源所属项目',
  `user_id` int(11) not null comment '申请用户',
  `apply_resource_type` tinyint(1) not null comment '资源类型',
  `resource_id` int(11) not null comment '申请的资源id',
  `resource_name` varchar(255) not null comment '资源名称',
  `deal_user_id` int(11) null comment '处理用户',
  `day` int(11) not null comment '申请期限',
  `apply_reason` varchar(1024) not null comment '申请理由',
  `status` tinyint(1) not null default '0' comment '状态:0-待审批，1-通过，2-不通过',
  `reply` varchar(1024) NULL comment '回复内容',
  `is_cancel` tinyint(1) not null default '0' comment '是否取消',
  `is_revoke` tinyint(1) not null default '0' comment '是否撤销',
  `gmt_create` datetime not null default current_timestamp comment '新增时间',
  `gmt_modified` datetime not null default current_timestamp comment '修改时间',
  `is_deleted` tinyint(1) not null default '0' comment '0正常 1逻辑删除',
  primary key (`id`)
) engine=innodb default charset=utf8;

-- 用户收藏表
create table `rdos_batch_hive_table_collection`(
  `id` int(11) not null auto_increment,
  `tenant_id` int(11) not null comment '租户id',
  `project_id` int(11) not null comment '项目id',
  `user_id` int(11) not null comment '申请用户',
  `table_id` int(11) not null comment '表id',
  `gmt_create` datetime not null default current_timestamp comment '新增时间',
  `gmt_modified` datetime not null default current_timestamp comment '修改时间',
  `is_deleted` tinyint(1) not null default '0' comment '0正常 1逻辑删除',
  primary key (`id`),
  unique key `project_id_user_id_table_id` (`project_id`,`user_id`,`table_id`)
) engine=innodb default charset=utf8;


-- 表分区
create table `rdos_batch_hive_table_partition`(
  `id` int(11) not null auto_increment,
  `tenant_id` int(11) not null comment '租户id',
  `project_id` int(11) not null comment '项目id',
  `table_id` int(11) not null comment '表id',
  `partition` varchar(1024) not null comment 'hdfs路径',
  `store_size` bigint(30) not null comment '分区大小',
  `gmt_create` datetime not null default current_timestamp comment '新增时间',
  `gmt_modified` datetime not null default current_timestamp comment '修改时间',
  `is_deleted` tinyint(1) not null default '0' comment '0正常 1逻辑删除',
  primary key (`id`),
  unique key `unique_idx` (`table_id`,`partition`(128))
) engine=innodb default charset=utf8;


-- 表权限
create table `rdos_batch_hive_table_permission`(
  `id` int(11) not null auto_increment,
  `tenant_id` int(11) not null comment '租户id',
  `project_id` int(11) not null comment '项目id',
  `user_id` int(11) not null comment '用户id',
  `table_id` int(11) not null comment '表id',
  `permission_type` tinyint(1) not null default '0' comment '0-只读，1-读写，2-修改',
  `gmt_create` datetime not null default current_timestamp comment '新增时间',
  `gmt_modified` datetime not null default current_timestamp comment '修改时间',
  `is_deleted` tinyint(1) not null default '0' comment '0正常 1逻辑删除',
  primary key (`id`),
  unique key `user_id_table_id_permission_type` (`user_id`,`table_id`,`permission_type`)
) engine=innodb default charset=utf8;


CREATE TABLE `rdos_hive_table_info_deleted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `table_desc` varchar(2048) NULL COMMENT '表描述',
  `life_day` int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
  `life_status` int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
  `table_size` bigint(30) DEFAULT NULL COMMENT '表大小',
  `grade` varchar(128) COMMENT '模型层级',
  `subject` varchar(128) COMMENT '主题域',
  `refresh_rate` varchar(128) COMMENT '刷新频率',
  `incre_type` varchar(128) COMMENT '增量类型',
  `is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略',
  `check_result` varchar(256) COMMENT '检测结果',
  `size_update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '表大小更新时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `charge_user_id` int(11) NOT NULL COMMENT '负责人',
  `path` varchar(512) NOT NULL DEFAULT '""' COMMENT '目录路径',
  `location` varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
  `delim` varchar(50) NOT NULL DEFAULT ',' COMMENT '列分隔符',
  `store_type` varchar(100) not null default 'orc' comment '存储格式',
  `catalogue_id` int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
  `last_ddl_time` datetime NULL COMMENT '最后表结构修改时间',
  `last_dml_time` datetime NULL COMMENT '最后数据更改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `is_dirty_data_table` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通表 1-脏数据表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- rdos_batch_table_relation 结构修改和数据更新
begin;
    alter table rdos_batch_table_relation add column `tenant_id` int(11) not null comment '租户id';
    alter table rdos_batch_table_relation add column `project_id` int(11) not null comment '项目id';
    alter table rdos_batch_table_relation add column `data_source_id` int(11) not null comment '数据源id';
    alter table rdos_batch_table_relation add column `table_name` varchar(256) not null comment '表名称';
    alter table rdos_batch_table_relation change column `is_task` `relation_type` tinyint(1) not null comment '关联类型';
    alter table rdos_batch_table_relation change column `type` `detail_type` tinyint(1) not null comment '具体类型';
    alter table rdos_batch_table_relation drop index `table_id_relation_id_is_task`;

    -- 删除脏数据
    delete from rdos_batch_table_relation where table_id not in (select TBL_ID from tbls);
    delete from rdos_batch_table_relation where relation_id = 0;

    -- 将之前的数据源id设为-1，表示hive类型
    update rdos_batch_table_relation set data_source_id = -1;

    -- 更新tenant_id 和 project_id
    update rdos_batch_table_relation r
    join (select tenant_id,project_id,table_id from rdos_hive_table_info) info
    on r.table_id = info.table_id
    set r.tenant_id = info.tenant_id,r.project_id = info.project_id;

    -- 更新tableName字段
    update rdos_batch_table_relation r
    join (select table_name,table_id from rdos_hive_table_info) info
    on r.table_id = info.table_id
    set r.table_name = info.table_name;

    alter ignore table rdos_batch_table_relation add unique key `unique_idx` (`data_source_id`,`table_name`(128),`relation_id`,`relation_type`);
    alter table rdos_batch_table_relation drop column `table_id`;
commit;


-- rdos_hive_catalogue 结构修改和数据更新


drop procedure if exists update_catalogue;

DELIMITER //

create procedure update_catalogue()
begin
	  declare ten_id int(11);
	  declare flag int default 0;
	  declare max_id int(11);
	  declare cur cursor for (select id from rdos_tenant);
	  declare continue handler for sqlstate '02000' set flag = null;

    -- 先更新所有目录的级别，确保代码逻辑不改变
	  update rdos_hive_catalogue set level = level + 1 where id > 0;

    open cur;
        fetch cur into ten_id;
        while (flag is not null) do
            -- 为每个租户创建根目录
            select max(id)+1 into max_id from rdos_hive_catalogue;
            insert into rdos_hive_catalogue(id,tenant_id,project_id,node_name,node_pid,order_val,level,gmt_create,gmt_modified,create_user_id,is_deleted,path)
                values(max_id,ten_id,-1,"类目管理",0,0,0,now(),now(),-1,0,max_id);

            -- 更新原来目录的path
            update rdos_hive_catalogue set path = concat(max_id,"/",path) where tenant_id = ten_id and id != max_id;

            -- 更新项目的父目录为这个租户的根目录
            update rdos_hive_catalogue set node_pid = max_id where level = 1 and tenant_id = ten_id;

        fetch cur into ten_id;
            end while;
    close cur;

    alter table rdos_hive_catalogue drop column project_id;

end; //

DELIMITER ;

call update_catalogue();



-- rdos_batch_hive_table_column 结构修改
begin ;
    alter ignore table rdos_batch_hive_table_column add UNIQUE KEY `idx` (`table_id`,`column_type`,`column_index`);
    update rdos_batch_hive_table_column col
    join(select table_id,id from rdos_hive_table_info where is_deleted = 0) info
    on col.table_id = info.table_id
    set col.table_id = info.id where col.is_deleted = 0;
commit;



-- rdos_hive_table_info 结构修改
begin;
    alter table rdos_hive_table_info add column `location` varchar(1024) not null default '' comment 'hdfs路径';
    alter table rdos_hive_table_info add column `delim` varchar(50) not null default ',' comment '列分隔符';
    alter table rdos_hive_table_info add column `store_type` varchar(100) not null default 'orc' comment '存储格式';
    alter table rdos_hive_table_info add column `charge_user_id` int(11) not null comment '负责人';
    -- 更新location字段
    update rdos_hive_table_info tb join (
        select p.id,db.NAME,sd.LOCATION,tb.TBL_ID
        from sds sd,tbls tb,dbs db,rdos_project p
        where sd.SD_ID = tb.SD_ID and db.DB_ID = tb.DB_ID and p.project_name = db.NAME
    ) info
    on tb.table_id = info.TBL_ID and tb.project_id = info.id
    set tb.location = info.LOCATION  where tb.is_deleted = 0;

    -- store_type字段
    UPDATE rdos_hive_table_info info
        JOIN
    (SELECT
        CASE sd.INPUT_FORMAT
                WHEN 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' THEN 'orc'
                ELSE 'textfile'
            END AS store_type,
            tb.TBL_ID
    FROM
        sds sd
    JOIN tbls tb ON sd.SERDE_ID = tb.SD_ID) temp ON info.table_id = temp.TBL_ID
    SET info.store_type = temp.store_type;

    -- 更新delim字段
    update rdos_hive_table_info info
    join (
      select sp.PARAM_VALUE,temp.TBL_ID from serde_params sp join (
        select tb.TBL_ID,sd.SERDE_ID from tbls tb join sds sd on tb.SD_ID = sd.SD_ID
        ) temp on sp.SERDE_ID = temp.SERDE_ID where sp.PARAM_KEY = "field.delim"
    ) temp2
    on info.table_id = temp2.TBL_ID
    set info.delim = temp2.PARAM_VALUE;


    -- 更新其它字段
    update rdos_hive_table_info set charge_user_id = user_id;
    update rdos_hive_table_info set path = concat(catalogue_id,"/",id);
    alter table rdos_hive_table_info drop column `table_id`;

    alter ignore table rdos_hive_table_info add UNIQUE KEY `idx` (`tenant_id`,`project_id`,`table_name`(128));
commit;


-- 血缘表
CREATE TABLE `rdos_batch_table_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `table_name` varchar(256) NOT NULL COMMENT '表名称',
  `data_source_id` int(11) NOT NULL COMMENT '表id',
  `col` varchar(256) NULL COMMENT '字段名称',
  `input_project_id` int(11) NOT NULL COMMENT '项目id',
  `input_table_name` varchar(256) NOT NULL COMMENT '表名称',
  `input_data_source_id` int(11) NOT NULL COMMENT '表id',
  `input_col` varchar(256) NULL COMMENT '字段名称',
  `unique_key` varchar(64) NULL COMMENT '血缘唯一键',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- saas 环境数据
insert into rdos_batch_table_table(tenant_id,project_id,table_name,data_source_id,col,
input_project_id,input_table_name,input_data_source_id,input_col)
values
(8,16,"hive_all",-1,"",16,"temp_data_f6e4bf75_xc1",-1,""),
(8,16,"ysq11",-1,"",16,"ysq12",-1,"");


UPDATE rdos_role SET role_desc = '本项目内的全部权限，具有本租户内的最高权限' WHERE role_value = 1;
UPDATE rdos_role SET role_desc = '项目空间的创建者，拥有项目空间内的最高权限，可对该项目空间的基本属性、数据源、当前项目空间的全部资源和项目成员等进行管理，并为项目成员赋予项目管理员、开发、运维、访客角色。' WHERE role_value = 2;
update rdos_role set role_desc = '项目空间的管理者，可对该项目空间的基本属性、数据源、当前项目空间的全部资源和项目成员等进行管理，并为项目成员赋予项目管理员、开发、运维、访客角色。项目管理员不能对项目所有者操作。' where role_value = 3;
UPDATE rdos_role SET role_desc = '只具备查看权限，没有权限进行编辑任务、运维等操作。' WHERE role_value = 4;
UPDATE rdos_role SET role_desc = '由项目管理员分配运维权限；拥有发布任务、运维任务的操作权限，没有数据开发的操作权限。' WHERE role_value = 5;
UPDATE rdos_role SET role_desc = '能够创建任务、脚本、资源等，新建/删除表，但不能执行发布操作。' WHERE role_value = 6;


-- 数据源类型
insert into rdos_dict(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
values
('1', 'FTP', '9', 'FTP', 'FTP', '9', now(), now(), '0'),
('1', 'MaxCompute', '10', 'MaxCompute', 'MaxCompute', '10', now(), now(), '0'),
('1', 'ElasticSearch', '11', 'ElasticSearch', 'ElasticSearch', '11', now(), now(), '0');

UPDATE rdos_dict SET dict_name = "MySQL",dict_name_zh = "MySQL",dict_name_en = "MySQL" WHERE TYPE = 1 AND dict_value = 1;

CREATE TABLE `rdos_stream_task_resource_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `resource_id` int(11) DEFAULT NULL COMMENT '对应资源的id,只有MR才需要添加资源id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_project_task_resource_id` (`project_id`,`task_id`,`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task_shade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `task_id` varchar(256) NOT NULL COMMENT '任务id',
  `name` varchar(256) NOT NULL COMMENT '任务名称',
  `main_class` varchar(256) DEFAULT NULL COMMENT '任务名称',
  `task_type` tinyint(1) NOT NULL COMMENT '任务类型 0 sql, 1 mr',
  `engine_type` tinyint(1) NOT NULL COMMENT '执行引擎类型 0 flink, 1 spark',
  `compute_type` tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  `sql_text` text NOT NULL COMMENT 'sql 文本',
  `task_params` text NOT NULL COMMENT '任务参数',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modify_user_id` int(11) NOT NULL COMMENT '最后修改task的用户',
  `create_user_id` int(11) NOT NULL COMMENT '新建task的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `task_desc` varchar(255) DEFAULT NULL,
  `exe_args` text,
  PRIMARY KEY (`id`),
  KEY `index_name` (`project_id`,`name`(128)),
  KEY `index_task_id` (`task_id`(128),`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;

CREATE TABLE `rdos_stream_task_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `task_id` int(11) NOT NULL COMMENT '父文件夹id',
  `sql_text` text NOT NULL COMMENT 'sql 文本',
  `publish_desc` text NOT NULL COMMENT '发布描述',
  `create_user_id` int(11) NOT NULL COMMENT '新建的用户',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;


-- 权限
-- 权限点  数据管理
drop procedure if exists update_permission;

DELIMITER //
create procedure update_permission()
BEGIN

		declare rId int(11);
		declare flag int default 0;
		DECLARE cur CURSOR FOR ( SELECT id FROM rdos_role WHERE role_type = 1 AND is_deleted = 0 );
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL;


		set @pId = (select id from rdos_permission where code = "datamanager_tablemanager");

    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
     VALUES ('datamanager_tablemanager_editcharge','数据管理_表管理_编辑负责人','编辑负责人',@pId,1,now(),now(),0),
     ('datamanager_permissionmanager','数据管理_权限管理','权限管理',@pId,1,now(),now(),0);

    select id into @pId from rdos_permission where code = "datamanager_permissionmanager";
    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
    values ('datamanager_permissionmanager_query','数据管理_权限管理_查看','查看',@pId,1,now(),now(),0),
    ('datamanager_permissionmanager_edit','数据管理_权限管理_编辑','编辑',@pId,1,now(),now(),0),
    ('datamanager_permissionmanager_apply','数据管理_权限管理_申请','申请',@pId,1,now(),now(),0);

    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
    values ('datamodel_manager','数据模型','数据模型',1,1,now(),now(),0);

    select id into @pId from rdos_permission where code = "datamodel_manager";
    INSERT INTO `rdos_permission`(code,name,display,parent_id,`type`,`gmt_create`,`gmt_modified`,`is_deleted`)
    values ('datamodel_manager_query','数据模型_查看','查看',@pId,1,now(),now(),0),
    ('datamodel_manager_edit','数据模型_编辑','编辑',@pId,1,now(),now(),0);


		SET @id1 = ( SELECT id FROM rdos_permission WHERE code = "datamanager_tablemanager_editcharge" limit 1);
		SET @id2 = ( SELECT id FROM rdos_permission WHERE code = "datamanager_permissionmanager" limit 1);
		SET @id3 = ( SELECT id FROM rdos_permission WHERE code = "datamanager_permissionmanager_query" limit 1);
		SET @id4 = ( SELECT id FROM rdos_permission WHERE code = "datamanager_permissionmanager_edit" limit 1);
		SET @id5 = ( SELECT id FROM rdos_permission WHERE code = "datamanager_permissionmanager_apply" limit 1);
		SET @id6 = ( SELECT id FROM rdos_permission WHERE code = "datamodel_manager" limit 1);
		SET @id7 = ( SELECT id FROM rdos_permission WHERE code = "datamodel_manager_query" limit 1);
		SET @id8 = ( SELECT id FROM rdos_permission WHERE code = "datamodel_manager_edit" limit 1);

	OPEN cur;
		FETCH cur into rId;
		WHILE ( flag IS NOT NULL ) DO
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id1 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id2 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id3 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id4 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id5 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id6 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id7 );
				INSERT INTO rdos_role_permission ( role_id, permission_id ) VALUES( rId, @id8 );
			FETCH cur INTO rId;

		END WHILE;
	CLOSE cur;

	UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id = ( SELECT min( id ) FROM rdos_role WHERE role_value = 4 )
		AND permission_id IN ( SELECT id FROM rdos_permission WHERE type = 1 AND CODE IN (
		'datamanager_tablemanager_editcharge',
		'datamanager_permissionmanager_query',
		'datamanager_permissionmanager_edit',
		'datamanager_permissionmanager_apply',
		'datamodel_manager_query',
		'datamodel_manager_edit' )
	);

		-- 运维
	UPDATE rdos_role_permission
	SET is_deleted = 1  WHERE role_id = ( SELECT min( id ) FROM rdos_role WHERE role_value = 5 )
		AND permission_id IN ( SELECT id FROM rdos_permission WHERE type = 1 AND CODE IN (
		'datamanager_tablemanager_edit',
		'datamanager_catalogue_edit',
		'datamanager_tablemanager_editcharge'
		)
	);

		-- 数据开发
	UPDATE rdos_role_permission
	SET is_deleted = 1 WHERE role_id = ( SELECT min( id ) FROM rdos_role WHERE role_value = 6 )
		AND permission_id IN ( SELECT id  FROM rdos_permission  WHERE type = 1 AND CODE IN (
		'datamanager_tablemanager_editcharge',
		'datamanager_catalogue_edit'
		)
	) ;

END;//

DELIMITER ;

call update_permission();


-- 调度端记录离线job处理的id
create table `rdos_batch_task_process_record`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `job_id` int(11) NOT NULL COMMENT '最后一个处理的job',
    `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '处理的调度任务:0-血缘，1-操作记录，2-生命周期',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table rdos_hive_catalogue drop index idx;

alter table rdos_hive_table_action_record change column `action_sql` `action_sql` TEXT NOT NULL COMMENT '操作sql语句';

alter table rdos_batch_job add column dependency_type tinyint(2) NOT NULL DEFAULT 0;
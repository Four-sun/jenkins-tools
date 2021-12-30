INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,
`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
values   ('12', 'LIBRA_SQL', '15', 'LibraSQL', 'LibraSQL', '1', now(), now(), '0'),
  ('12', 'VIRTUAL', '-1', '虚节点', 'Virtual', '2', now(), now(), '0'),
  ('12', 'WORK_FLOW', '10', '工作流', 'WORKFLOW', '3', now(), now(), '0');



INSERT INTO rdos_dict
(`type`, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified, is_deleted)
VALUES('1', 'LibrA', '21', 'LibrA', 'LibrA', 0, now(), now(), 0);


CREATE TABLE `rdos_project_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `engine_type` tinyint(1) NOT NULL COMMENT '多引擎的类型',
  `engine_identity` varchar(256) NOT NULL COMMENT '标识信息，比如hive的dbname',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table rdos_hive_table_info add column `table_type` TINYINT(2) COMMENT '表类型';
alter table rdos_hive_table_info_deleted add column `table_type` TINYINT(2) COMMENT '表类型';
ALTER table rdos_batch_hive_select_sql add engine_type int ;

alter table rdos_dict drop key index_type_dict_value;




update rdos_dict set type = 13, dict_value = 6 where dict_name = 'CustomFunction' and type = 6;

INSERT INTO rdos_dict (type, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified,
                       is_deleted)
VALUES (6, 'LibraSQLFunction', 4, 'LibraSQL', 'LibraSQLFunction', 6, now(), now(), 0);

INSERT INTO ide.rdos_dict (type, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified, is_deleted)
VALUES (6, 'SparkSQLFunction', 4, 'SparkSQL', 'SparkSQLFunction', 4, '2018-10-10 14:46:40', '2018-10-10 14:46:40', 0);
INSERT INTO rdos_dict (type, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified,
                       is_deleted)
VALUES (13, 'SystemFunction', 6, '系统函数', 'SystemFunction', 2, now(), now(), 0);


create table rdos_batch_sql_template
(
    id           bigint auto_increment
        primary key,
    gmt_create   datetime   default CURRENT_TIMESTAMP null,
    gmt_modified datetime   default CURRENT_TIMESTAMP null,
    is_deleted   tinyint(1) default 0                 not null comment '0正常 1逻辑删除',
    engine_type  int                                  null,
    table_type   int        default 1                 not null comment '1 hive 2 libra',
    params       text                                 null
);



INSERT INTO rdos_batch_sql_template (gmt_create, gmt_modified, is_deleted, engine_type, table_type, params) VALUES (now(), now(), 0, null, 1, '"CREATE TABLE employee ( \\n" +
                        "    eid int, \\n" +
                        "    name String,\\n" +
                        "    salary String, \\n" +
                        "    destination String)\\n" +
                        "    STORED AS ORC\\n" +
                        "    lifecycle 10"');
INSERT INTO rdos_batch_sql_template (gmt_create, gmt_modified, is_deleted, engine_type, table_type, params) VALUES (now(), now(), 0, null, 2, '"create table employee\\n" +
                        "(\\n" +
                        "\\teid int,\\n" +
                        "\\tname varchar(10),\\n" +
                        "\\tsalary varchar(10),\\n" +
                        "\\tdestination varchar(30)\\n" +
                        ");\\n " +
                        "alter table employee\\n" +
                        "    owner to root;"');


UPDATE rdos_hive_table_info SET table_type = 1 WHERE 1=1;
update rdos_hive_table_info_deleted set table_type = 1;

alter table rdos_batch_catalogue
    add engine_type int default 0 not null comment '1: hadoop 2:libra' after level;

alter table rdos_batch_function
    add engine_type int default 0 not null comment '1: hadoop 2:libra' after type;

update rdos_batch_function set engine_type  = 1;

INSERT INTO rdos_project_engine (project_id, tenant_id, engine_type, engine_identity, status, gmt_create, gmt_modified, is_deleted)
select id,tenant_id,1,project_name,1,now(),now(),is_deleted from rdos_project;


create table rdos_batch_catalogue_copy
(
    id             int auto_increment
        primary key,
    tenant_id      int                                  not null comment '租户id',
    project_id     int                                  not null comment '项目id',
    node_name      varchar(128)                         not null comment '文件夹名称',
    node_pid       int        default -1                not null comment '父文件夹id -1:没有上级目录',
    order_val      int(3)                               null,
    level          tinyint(1) default 3                 not null comment '目录层级 0:一级 1:二级3:二级以下目录',
    engine_type    int        default 0                 not null comment '1: hadoop 2:libra',
    gmt_create     datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modified   datetime   default CURRENT_TIMESTAMP not null comment '修改时间',
    create_user_id int                                  not null comment '创建用户',
    is_deleted     tinyint(1) default 0                 not null comment '0正常 1逻辑删除'
)
    charset = utf8;

insert into rdos_batch_catalogue_copy
select * from rdos_batch_catalogue;

INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '系统函数', -2, 3, 1, 2, '2019-06-04 15:02:05', '2019-06-04 15:02:05', -1, 0);

INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '其它函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '字符函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '数学函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '日期函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '聚合函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '表生成函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);
INSERT INTO rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted) VALUES (-1, -1, '集合函数', (select * from (select id from rdos_batch_catalogue where node_pid = -2 limit 1) t), null, 2, 2, now(), now(), -1, 0);

insert into rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
select tenant_id,project_id,'SparkSQL',id,null,1,1,now(),now(),
       create_user_id,0 from rdos_batch_catalogue r where is_deleted = 0 and engine_type = 0  and node_name = '函数管理';

insert into rdos_batch_catalogue (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
select tenant_id,project_id,'系统函数',id,null,1,1,now(),now(),
       create_user_id,0 from rdos_batch_catalogue r where is_deleted = 0 and engine_type = 1  and node_name = 'SparkSQL';

update rdos_batch_catalogue cp2 ,(select id,project_id from rdos_batch_catalogue where engine_type = 1 and node_name = 'SparkSQL') cp3
set cp2.node_pid = cp3.id,cp2.engine_type = 1 where cp2.node_name = '自定义函数'  and cp2.is_deleted = 0 and  cp2.engine_type = 0  and cp2.project_id = cp3.project_id;


ALTER TABLE rdos_batch_data_source ADD `is_default` TINYINT DEFAULT 0 NULL;
update
	rdos_batch_data_source s
left join rdos_project p on
	s.project_id = p.id set
	s.is_default = 1
where
	s.`type` = 7
	and s.data_name = p.project_name and s.is_deleted = 0;



ALTER TABLE `rdos_batch_table_relation` ADD COLUMN `table_id` int(11) NULL COMMENT '表id';
ALTER TABLE `rdos_batch_table_relation` DROP INDEX unique_idx;
alter table `rdos_batch_table_relation` add UNIQUE KEY `unique_idx` (`data_source_id`,`table_id`,`relation_id`,`relation_type`);
update
	rdos_batch_table_relation r
left join rdos_hive_table_info t on
	r.project_id = t.project_id and r.table_name = t.table_name
set
	r.table_id = t.id
where
	t.is_deleted = 0 and t.table_type = 1;


ALTER TABLE `rdos_hive_table_info`
DROP INDEX `idx` ,
ADD UNIQUE INDEX `idx` (`tenant_id` , `project_id` , `table_name`(128) , `table_type`);


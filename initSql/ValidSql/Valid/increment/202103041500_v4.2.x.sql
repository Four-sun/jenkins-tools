-- 新增取值范围单表规则
INSERT into dq_function(id,name_zc,name_en,level,have_dirty,is_multiple_support) VALUES
(25,'取值范围','value_range',0,1,0);

-- 给所有数据源添加 取值范围 规则模板,使用 {range}替换取值范围条件
-- mysql类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 1, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- hive类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 7, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- sqlServer类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 3, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- oracle类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 2, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- maxCompute类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 10, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- TiDB类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 31, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- Greenplum类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 36, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- spark类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 45, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');
-- 人大金仓
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 40, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');

-- 修改 dq_monitor_rule 字段operator 的长度
alter table dq_monitor_rule modify operator varchar(32) default '=' not null comment '操作,<,>,=等';

-- 单表新增强弱规则判断 dq_monitor_rule
alter table dq_monitor_rule add `rule_strength` tinyint(1) unsigned default 1 not null comment '强弱规则，0-无规则（引擎预留）；1-弱规则；2-强规则，默认弱规则';

-- 监控规则依赖关系表
create table `dq_monitor_relationship`
(
    `id`                 int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    `project_id`         int(11)      NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`         int(11)      NOT NULL COMMENT '监控规则id（SQL任务的）',
    `parent_monitor_id`  int(11)      NULL COMMENT '工作流中的上游任务监控id，工作流虚节点的值为null',
    `task_type`          tinyint(4)   UNSIGNED NOT NULL COMMENT '引擎任务类型，10-工作流虚节点；0-SQL任务；27-空任务',
    `create_user_id`     int(11)      NOT NULL COMMENT '创建的用户',
    `modify_user_id`     int(11)      NOT NULL COMMENT '修改的用户',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    KEY `idx_monitor_id` (`monitor_id`),
    KEY `idx_parent_monitor_id` (parent_monitor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='监控规则依赖关系表';

-- 添加引擎任务类型
ALTER TABLE `dq_monitor` add `task_type` tinyint(4) unsigned not null default 0 comment '引擎任务类型，10-工作流虚节点；0-SQL任务；27-空任务';


-- 将系统参数 '${bdp.system.recentPart}' 替换成 '${bdp.system.bizdate}'
UPDATE dq_monitor SET partitions = replace (partitions,'${bdp.system.recentPart}','${bdp.system.bizdate}') WHERE partitions LIKE '%${bdp.system.recentPart}%';
UPDATE dq_monitor_rule SET customize_sql = replace (customize_sql,'${bdp.system.recentPart}','${bdp.system.bizdate}') WHERE customize_sql LIKE '%${bdp.system.recentPart}%';
UPDATE dq_monitor_rule SET select_data_sql = replace (select_data_sql,'${bdp.system.recentPart}','${bdp.system.bizdate}') WHERE select_data_sql LIKE '%${bdp.system.recentPart}%';
UPDATE dq_verify SET origin_partition = replace (origin_partition,'${bdp.system.recentPart}','${bdp.system.bizdate}') WHERE origin_partition LIKE '%${bdp.system.recentPart}%';
UPDATE dq_verify SET target_partition = replace (target_partition,'${bdp.system.recentPart}','${bdp.system.bizdate}') WHERE target_partition LIKE '%${bdp.system.recentPart}%';

-- 监控关联任务表
create table `dq_monitor_association`
(
    `id`                 int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    `project_id`         int(11)      NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`         int(11)      NOT NULL COMMENT '监控规则id（SQL任务的）',
    `dtuic_tenant_id`    int(11)      NOT NULL DEFAULT '0' COMMENT 'uic租户id',
    `assoc_task_id`      int(11)      NOT NULL COMMENT '关联其他项目的的task id',
    `assoc_task_name`		 varchar(256) NOT NULL COMMENT '关联其他项目的的任务名称',
    `assoc_app_type`     tinyint      NOT NULL COMMENT '关联的应用类型，比如离线(1)',
    `assoc_project_alias` varchar(256) NOT NULL COMMENT '关联的应用的项目名称',
    `assoc_project_identifier` varchar(256) NOT NULL COMMENT '关联的应用的项目标识',
    `assoc_project_id`   int(11)      NOT NULL COMMENT '关联的应用项目id',
    `create_user_id`     int(11)      NOT NULL COMMENT '创建的用户',
    `modify_user_id`     int(11)      NOT NULL COMMENT '修改的用户',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '监控关联任务表';

-- 数据质量项目同步到引擎
insert into dagschedulex.schedule_engine_project(project_id,uic_tenant_id,app_type,project_name,project_alias,project_Identifier,project_desc,status,create_user_id,gmt_create,gmt_modified,is_deleted)
select
    a.id project_id,
    b.dtuic_tenant_id dtuic_tenant_id,
    2 app_type,
    a.project_name project_name,
    a.project_alias project_alias,
    a.project_Identifier project_Identifier,
    a.project_desc project_desc,
    a.status status,
    a.create_user_id create_user_id,
    a.gmt_create gmt_create,
    a.gmt_modified gmt_modified,
    a.is_deleted is_deleted
from dq_project a LEFT JOIN dq_tenant b ON a.tenant_id = b.id
WHERE a.is_deleted = 0;

-- 任务查询页面改动
alter table dq_monitor_record add exec_end_time datetime comment '实例运行结束的时间';
alter table dq_monitor_record add cyc_time datetime comment '周期实例计划时间，如果是手动触发，就是任务执行时间';
alter table dq_monitor_record add exec_time int(11) comment '执行时间';
-- 添加 `associated`字段
alter table dq_monitor add associated tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-无关联任务，1-有关联任务';

-- 修改多表的状态码
-- 1. 将状态先改为临时状态
-- FAILURE(3, "运行失败") -> FAILED(2)
update dq_verify_record set status = 12 where status = 3;

-- SUCCESS(2, "运行成功"),PASS(4, "校验通过") -> PASS(3)
update dq_verify_record set status = 13 where status in (2, 4);

-- UNPASS(5, "校验不通过") -> UN_PASS(4)
update dq_verify_record set status = 14 where status = 5;

-- 2. 将临时状态修改掉
update dq_verify_record set status = 2 where status = 12;
update dq_verify_record set status = 3 where status = 13;
update dq_verify_record set status = 4 where status = 14;

-- 修改Spark数据源的显示名
update dq_dict set dict_name = 'SparkThrift2.x', dict_name_zh = 'SparkThrift2.x', dict_name_en = 'SparkThrift2.x', gmt_modified = now() where type = 1 and dict_value = 45;

-- 添加日期系统参数
insert into dq_sys_parameter values('6','bdp.system.bizdate2','yyyy-MM-dd','0');
insert into dq_sys_parameter values('7','bdp.system.runtime','yyyyMMddHHmmss','0');

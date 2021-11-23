-- v4.1.1 增量SQL
-- bug fix: 在dt_center_cron_schedule删除任务后还需要删除quartz的任务缓存
delete from qrtz_cron_triggers where TRIGGER_NAME= 'MonitorTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'MonitorTrigger';
delete from qrtz_job_details where JOB_NAME= 'monitorJob';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'MonitorTrigger';

delete from qrtz_cron_triggers where TRIGGER_NAME= 'verifyJobTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'verifyJobTrigger';
delete from qrtz_job_details where JOB_NAME= 'verifyJob';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'verifyJobTrigger';

delete from qrtz_cron_triggers where TRIGGER_NAME= 'monitorTriggerTrigger';
delete from qrtz_triggers where TRIGGER_NAME= 'monitorTriggerTrigger';
delete from qrtz_job_details where JOB_NAME= 'monitorTriggerJob';
delete from qrtz_fired_triggers where TRIGGER_NAME= 'monitorTriggerTrigger';

-- 多表比对报告 - 新增 左表逻辑主键为空 和 右表逻辑主键为空
alter table dq_verify_report add column `left_id_empty` int(11) not null default 0 comment '左表逻辑主键为空';
alter table dq_verify_report add column `right_id_empty` int(11) not null default 0 comment '右表逻辑主键为空';

-- dq_function增添have_dirty字段
alter table dq_function add COLUMN have_dirty tinyint(1) DEFAULT '0' COMMENT '0-没有脏数据表 1-有脏数据表';
update dq_function set have_dirty = 1 where id in (3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,22,23,24);

-- 修改max,min,字符最小长度，字符最大长度的脏数据表存储sql
update dq_function_template set template_query = '`${table}` where char_length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 1;
update dq_function_template set template_query = '`${table}` where char_length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 1;
update dq_function_template set template_query = '`${table}` where ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 1;
update dq_function_template set template_query = '`${table}` where ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 1;
update dq_function_template set template_query = '"${table}" where length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 2;
update dq_function_template set template_query = '"${table}" where length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 2;
update dq_function_template set template_query = '"${table}" where 1=1 and ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 2;
update dq_function_template set template_query = '"${table}" where 1=1 and ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 2;
update dq_function_template set template_query = '${table} where len(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 3;
update dq_function_template set template_query = '${table} where len(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 3;
update dq_function_template set template_query = '${table} where 1=1 and  ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 3;
update dq_function_template set template_query = '${table} where 1=1 and  ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 3;
update dq_function_template set template_query = '${table} where length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 7;
update dq_function_template set template_query = '${table} where length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 7;
update dq_function_template set template_query = '${table} where ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 7;
update dq_function_template set template_query = '${table} where ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 7;
update dq_function_template set template_query = '${table} where length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 10;
update dq_function_template set template_query = '${table} where length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 10;
update dq_function_template set template_query = '${table} where 1=1 and ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 10;
update dq_function_template set template_query = '${table} where 1=1 and ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 10;

update dq_function_template set template_query = '${table} where 1=1 ${filter} having char_length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 31;
update dq_function_template set template_query = '${table} where 1=1 ${filter} having char_length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 31;
update dq_function_template set template_query = '${table} where 1=1 ${filter} having ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 31;
update dq_function_template set template_query = '${table} where 1=1 ${filter} having ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 31;


update dq_function_template set template_query = '${table} where char_length(${col})< ${expectation} ${filter}' where function_id=17 and data_source_type = 36;
update dq_function_template set template_query = '${table} where ${col}> ${expectation} ${filter}' where function_id=18 and data_source_type = 36;
update dq_function_template set template_query = '${table} where ${col}< ${expectation} ${filter}' where function_id=19 and data_source_type = 36;
update dq_function_template set template_query = '${table} where char_length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 36;

-- 新增 监控规则_删除 权限
INSERT INTO dq_permission VALUES('42','monitor_delete','监控规则_删除','删除','21','1',now(),now(),'0');
-- 给租户所有者、项目管理员、数据开发、项目所有者添加 监控规则_删除 权限，数据开发只能删除自己创建的规则
INSERT INTO dq_role_permission(role_id,permission_id)
SELECT
	id,
	42
	FROM dq_role
	WHERE role_value IN (1,2,4,5);


-- -----------------------------------
-- ----------新增数据源 人大金仓------------
-- -----------------------------------

alter table dq_monitor add COLUMN schema_name varchar(256) COMMENT '选择的schema';
alter table dq_verify  add COLUMN schema_name varchar(256) COMMENT '选择的schema';
alter table dq_function  add COLUMN is_multiple_support tinyint(1) DEFAULT '0' COMMENT '0-不支持多字段 1-支持多字段';
alter table dq_table add column schema_name varchar(256)  COMMENT '监控规则选定的schema';


UPDATE dq_function SET is_multiple_support = 1 WHERE id IN (3,4,5,6,7,8);

INSERT INTO  `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (1, 40, 'select count(1)  as  val  from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template`, `template_query`) VALUES ( 2, 40, 'select count(1) as val from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME=\'${table}\' and TABLE_SCHEMA=\'${db}\'', '');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (3, 40, 'select count(1) as val from ${table} where ${col} is null ${filter}',  '${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (4, 40, 'select sum(case when ${col} is null then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (5, 40, 'select sum(case when char_length(${col})=0 then 1.0 else 0.0 end) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col})=0 ${filter} ');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (6, 40, 'select sum(case when char_length(${col})=0 then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col})=0 ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (7, 40, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} where exists (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (8, 40, 'select sum(case when count>1 then 1.0 else 0.0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where exists (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (9, 40, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (10, 40, 'select sum(case when count=1 then 1.0 else 0.0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`,`template`,  `template_query`) VALUES (11, 40, 'select count(1) as val from  ${table} where  ${col} ${enum}  ${filter} ', '${table} where ${col} ${enum} ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (12, 40, 'select  count(distinct ${col})  as val from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (13, 40, 'select sum(case when ${col} < 0 then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (14, 40, 'select sum(case when ${col} = 0 then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}',  '${table} where ${col} = 0 ${filter}');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (15, 40, 'select sum(case when ${col} > 0 then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (16, 40, 'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col}) = (select max(char_length(${col})) from ${table} where 1=1 ${filter} ) ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (17, 40, 'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col}) = (select min(char_length(${col})) from ${table} where 1=1 ${filter} ) ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES ( 18, 40, 'select max(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = (select max(${col}) from ${table} where 1=1 ${filter} ) ${filter}');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (19, 40, 'select min(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = (select min(${col}) from ${table} where 1=1 ${filter} ) ${filter}');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (20, 40, 'select avg(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (21, 40, 'select sum(${col}) as val from ${table} where 1=1 ${filter}', ' ');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (22, 40, 'SELECT count(1) AS val FROM ${table} WHERE REGEXP_LIKE (${col},\'^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$\') ${filter}', '${table} WHERE REGEXP_LIKE (${col}, \'^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$\') ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (23, 40, 'SELECT count(1) AS val FROM ${table} WHERE  REGEXP_LIKE(${col},\'^[1][35678][0-9]{9}$\') ${filter}', '${table} ${filter} WHERE REGEXP_LIKE (${col}, \"^[1][35678][0-9]{9}$\")');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES ( 24, 40, 'SELECT count(1) AS val FROM ${table} WHERE  REGEXP_LIKE(${col}, \'^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\')  ${filter}', '${table}  ${filter} WHERE REGEXP_LIKE (${col}, \"^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\")');


UPDATE `dq_function_template` SET  `template_query` = '`${table}` where exists (select  ${col} from `${table}` t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'       WHERE `function_id` = 7  AND `data_source_type` = 1;
UPDATE `dq_function_template` SET  `template_query` = '\"${table}\" where exists (select  ${col} from \"${table}\" t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'              WHERE `function_id` = 7  AND `data_source_type` = 2;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'                      WHERE `function_id` = 7  AND `data_source_type` = 3;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}'         WHERE `function_id` = 7  AND `data_source_type` = 7;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(1) > 1) ${filter}'                      WHERE `function_id` = 7  AND `data_source_type` = 10;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'                      WHERE `function_id` = 7  AND `data_source_type` = 31;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'           WHERE `function_id` = 7  AND `data_source_type` = 36;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'           WHERE `function_id` = 7  AND `data_source_type` = 40;
UPDATE `dq_function_template` SET  `template_query` = '`${table}` where exists (select  ${col} from `${table}` t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'       WHERE `function_id` = 8  AND `data_source_type` = 1;
UPDATE `dq_function_template` SET  `template_query` = '\"${table}\" where exists (select  ${col} from \"${table}\" t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'              WHERE `function_id` = 8  AND `data_source_type` = 2;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'                      WHERE `function_id` = 8  AND `data_source_type` = 3;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}'         WHERE `function_id` = 8  AND `data_source_type` = 7;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(1) > 1) ${filter}'                      WHERE `function_id` = 8  AND `data_source_type` = 10;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'                      WHERE `function_id` = 8  AND `data_source_type` = 31;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'           WHERE `function_id` = 8  AND `data_source_type` = 36;
UPDATE `dq_function_template` SET  `template_query` = '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'           WHERE `function_id` = 8  AND `data_source_type` = 40;


INSERT INTO `dq_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`) VALUES ( 1, 'KingBaseEs8', 40, 'KingBaseEs8', 'KingBaseEs8', 8);


UPDATE `dq_function_template` SET `template` = 'select sum(case when char_length(text(${col}))=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}' WHERE `function_id` = 5  AND `data_source_type` = 36;
-- 处理旧数据
-- 将dq_data_source_ref 中的旧的verify数据置为1，dq_verify的monitor_id 为0说明没有监控规则，这些数据是多表校验改造前的数据，需要处理掉
update dq_data_source_ref
set is_deleted = 1
where biz_type = 2
  and relation_id in (select v.id from dq_verify v where monitor_id = 0 and v.is_deleted = 0)
  and is_deleted = 0;

-- 将dq_data_source_ref中的relation_id将verifyId改为monitorId，以后relation_id 统一用monitor_id
update dq_data_source_ref ref
set relation_id = (select v.monitor_id from dq_verify v where ref.relation_id = v.id)
where biz_type = 2 and is_deleted = 0;

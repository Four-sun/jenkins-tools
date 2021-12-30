-- 给数据源添加独立库
alter table `dq_data_source` add column `writable_db_name` varchar(256) comment '独立库的库名或Schema名';
alter table `dq_data_source` add column `writable_data_json` text comment '独立库用户名、密码';
alter table `dq_data_source` add column `expire_day` int(11) not null default 90 comment '数据存储时间，不传默认90天';
alter table `dq_data_source` add column `write_type` tinyint(1) not null default 0 comment '0-写入源库；1-写入独立库，默认写入源库';

alter table `dq_data_source` modify data_json text not null comment '链接数据源信息需要加密 json格式';

-- 增加spark数据源
insert into dq_dict values (0, 1, 'SparkThrift2.1.x', 45, 'SparkThrift2.1.x', 'SparkThrift2.1.x', 8, now(), now(), 0);


-- spark类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 45, 'select count(1)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 45, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 45, 'select count(1) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 45, 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 45, 'select sum(case when length(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 45, 'select sum(case when length(${col})=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 45, 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 45, 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 45, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 45, 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 45, 'select count(1) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 45, 'select count(1) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 45, 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 45, 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 45, 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 45, 'SELECT max(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 45, 'SELECT min(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 45, 'select max(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 45, 'select min(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 45, 'select avg(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 45, 'select sum(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 45, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter}', '${table} where ${col} NOT RLIKE ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 45, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1]([3-9])[0-9]{9}$" ${filter}', '${table} where ${col}  NOT RLIKE "^[1][35678][0-9]{9}$" ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 45, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}', '${table} where ${col}  NOT RLIKE "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}');

-- INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 7, 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
-- update dq_function_template set template_query = '${table} where char_length(${col})> ${expectation} ${filter}' where function_id=16 and data_source_type = 36;
-- 1 AS id,
-- update dq_function_template set customize_sql = 'select ${dummyCol}count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp'
-- where function_id = 7 and id = 7;

alter table dq_monitor_record add column `dirty_table` varchar(256) comment '脏数据表，一个任务生成一张临时表';
alter table dq_monitor_record add column `dirty_table_status` tinyint(1) default 0 comment '脏数据表状态，0-未删除；1-已删除';

-- 添加定时任务 定期删除脏数据表
insert into `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '* * 3 * * ?', 'temporaryTableLifecycleJob','temporaryTableLifecycleJob','temporaryTableLifecycleJobTrigger','temporaryTableLifecycleJobTriggerGroup','com.dtstack.dq.schedule.job.TemporaryTableLifecycleJob','0',null,null,now(),now(),'0');


-- 去掉 mysql table上的``
update dq_function_template set template = 'select count(1)  as  line_count  from ${table} where 1=1 ${filter}' where function_id = '1' and data_source_type = '1';
update dq_function_template set template = 'select count(1) as col_count from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME=${table} and TABLE_SCHEMA="${db}"' where function_id = '2' and data_source_type = '1';
update dq_function_template set template = 'select count(1) as null_count from ${table} where ${col} is null ${filter}', template_query = '${table} where ${col} is null ${filter}' where function_id = '3' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as null_percent from ${table} where 1=1 ${filter}', template_query = '${table} where ${col} is null ${filter}' where function_id = '4' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when char_length(${col})=0 then 1 else 0 end) as empty_count from ${table} where 1=1 ${filter}', template_query = '${table} where char_length(${col})=0 ${filter}' where function_id = '5' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when char_length(${col})=0 then 1 else 0 end) / count(1) as empty_percent from ${table} where 1=1 ${filter}', template_query = '${table} where char_length(${col})=0 ${filter}' where function_id = '6' and data_source_type = '1';
update dq_function_template set template = 'select count(1) as repeat_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp', template_query = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' where function_id = '7' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when count>1 then 1 else 0 end) / sum(count) as repeat_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', template_query = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' where function_id = '8' and data_source_type = '1';
update dq_function_template set template = 'select count(1) as unique_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', template_query = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = '9' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when count=1 then 1 else 0 end) / sum(count) as unique_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', template_query = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = '10' and data_source_type = '1';
update dq_function_template set template = 'select count(1) as enum_count from  ${table} where  ${col} ${enum}  ${filter}', template_query = '${table} where ${col} ${enum} ${filter}' where function_id = '11' and data_source_type = '1';
update dq_function_template set template = 'select count(distinct coalesce(${col},"NULL"))  as distinct_count from ${table} where 1=1 ${filter}' where function_id = '12' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as minus_percent from ${table} where 1=1 ${filter}', template_query = '${table} where ${col} < 0 ${filter}' where function_id = '13' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as zero_percent from ${table} where 1=1 ${filter}', template_query = '${table} where ${col} = 0 ${filter}' where function_id = '14' and data_source_type = '1';
update dq_function_template set template = 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as plus_percent from ${table} where 1=1 ${filter}', template_query = '${table} where ${col} > 0 ${filter}' where function_id = '15' and data_source_type = '1';
update dq_function_template set template = 'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}', template_query = '${table} where char_length(${col})> ${expectation} ${filter}' where function_id = '16' and data_source_type = '1';
update dq_function_template set template = 'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}', template_query = '${table} where char_length(${col})< ${expectation} ${filter}' where function_id = '17' and data_source_type = '1';
update dq_function_template set template = 'select max(${col}) as val from ${table} where 1=1 ${filter}', template_query = '${table} where ${col}> ${expectation} ${filter}' where function_id = '18' and data_source_type = '1';
update dq_function_template set template = 'select min(${col}) as val from ${table} where 1=1 ${filter}', template_query = '${table} where ${col}< ${expectation} ${filter}' where function_id = '19' and data_source_type = '1';
update dq_function_template set template = 'select avg(${col}) as val from ${table} where 1=1 ${filter}' where function_id = '20' and data_source_type = '1';
update dq_function_template set template = 'select sum(${col}) as val from ${table} where 1=1 ${filter}' where function_id = '21' and data_source_type = '1';
update dq_function_template set template = "SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}", template_query = "${table} where  ${col} NOT RLIKE '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}" where function_id = '22' and data_source_type = '1';
update dq_function_template set template = 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[1][35678][0-9]{9}$" ${filter}', template_query = '${table} where ${filter} ${col} NOT RLIKE "^[1][35678][0-9]{9}$"' where function_id = '23' and data_source_type = '1';
update dq_function_template set template = 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$"  ${filter}', template_query = '${table} where ${filter} ${col} NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$"' where function_id = '24' and data_source_type = '1';
-- 去掉 oracle   table 上的""
update dq_function_template set template = 'select count(1)  as  val  from ${table} where 1=1 ${filter}' where function_id = '1' and data_source_type = '2';
update dq_function_template set template = "select count(1) as col_count from user_col_comments where table_name = upper('${table}')" where function_id = '2' and data_source_type = '2';
update dq_function_template set template = 'select count(1) as val from ${table} where ${col} is null ${filter}', template_query = '${table} t2 where ${col} is null ${filter}' where function_id = '3' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where ${col} is null ${filter}' where function_id = '4' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where length(trim(${col}) is null ${filter}' where function_id = '5' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where length(trim(${col}) is null ${filter}' where function_id = '6' and data_source_type = '2';
update dq_function_template set template = 'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', template_query = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' where function_id = '7' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', template_query = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' where function_id = '8' and data_source_type = '2';
update dq_function_template set template = 'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', template_query = '${table} t2 where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' where function_id = '9' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', template_query = '${table} t2 where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' where function_id = '10' and data_source_type = '2';
update dq_function_template set template = 'select count(1) as val from  ${table}  where  ${col} ${enum}  ${filter}', template_query = '${table} t2 where ${col} ${enum} ${filter}' where function_id = '11' and data_source_type = '2';
update dq_function_template set template = 'select  count(distinct ${col})  as val from ${table} where 1=1 ${filter}' where function_id = '12' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where ${col} < 0 ${filter}' where function_id = '13' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where ${col} = 0 ${filter}' where function_id = '14' and data_source_type = '2';
update dq_function_template set template = 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where ${col} > 0 ${filter}' where function_id = '15' and data_source_type = '2';
update dq_function_template set template = 'SELECT max(nvl(length(${col}),0)) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where length(${col})> ${expectation} ${filter}' where function_id = '16' and data_source_type = '2';
update dq_function_template set template = 'SELECT min(nvl(length(${col}),0)) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where length(${col})< ${expectation} ${filter}' where function_id = '17' and data_source_type = '2';
update dq_function_template set template = 'select max(${col}) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where 1=1 and ${col}> ${expectation} ${filter}' where function_id = '18' and data_source_type = '2';
update dq_function_template set template = 'select min(${col}) as val from ${table} where 1=1 ${filter}', template_query = '${table} t2 where 1=1 and ${col}< ${expectation} ${filter}' where function_id = '19' and data_source_type = '2';
update dq_function_template set template = 'select avg(nvl(${col},0)) as val from ${table} where 1=1 ${filter}' where function_id = '20' and data_source_type = '2';
update dq_function_template set template = 'select sum(${col}) as val from ${table} where 1=1 ${filter}' where function_id = '21' and data_source_type = '2';
update dq_function_template set template = "select count(1) AS val FROM ${table} WHERE regexp_like(${col},''[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)'') ${filter}", template_query = "${table} t2 WHERE ${filter} not regexp_like(${col}  , ''[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)'')" where function_id = '22' and data_source_type = '2';
update dq_function_template set template = 'select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^1[3578]\\d{9}$\'\') ${filter}', template_query = '${table} t2 WHERE ${filter} not regexp_like(${col}, \'\'^[1][35678][0-9]{9}$\'\')' where function_id = '23' and data_source_type = '2';
update dq_function_template set template = 'select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}', template_query = '${table} t2 WHERE not regexp_like(${col},\'\'^w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}' where function_id = '24' and data_source_type = '2';

-- 子查询中添加别名
-- MySQL
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 1;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 1;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 1;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 1;
-- Hive2
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 7;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 7;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 7;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 7;
-- sqlserver
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 7 AND `data_source_type` = 3;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 8 AND `data_source_type` = 3;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 3;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 3;
-- oracle
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 7 AND `data_source_type` = 2;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 8 AND `data_source_type` = 2;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 2;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 2;
-- maxCompute
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 10;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 10;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 10;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 10;
-- TiDB
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 7 AND `data_source_type` = 31;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)' WHERE `function_id` = 8 AND `data_source_type` = 31;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 31;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 31;
-- Greenplum
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 36;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 36;
UPDATE `dq_function_template` SET `template_query` = ' ${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 36;
UPDATE `dq_function_template` SET `template_query` = ' ${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 36;
-- spark
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 45;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 45;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 45;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 45;
-- Kingbase
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 7 AND `data_source_type` = 40;
UPDATE `dq_function_template` SET `template_query` = '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}' WHERE `function_id` = 8 AND `data_source_type` = 40;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 9 AND `data_source_type` = 40;
UPDATE `dq_function_template` SET `template_query` = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' WHERE `function_id` = 10 AND `data_source_type` = 40;

update dq_dict set dict_name = 'Hive2.x',dict_name_zh = 'Hive2.x' , dict_name_en = 'Hive2.x' WHERE type = 1 and  dict_value = 7;

-- 修改表行数规则的英文名，
update dq_function set name_en = 'line_count' where name_zc = '表行数';



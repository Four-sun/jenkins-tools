insert into dq_dict(type,dict_name,dict_value,dict_name_zh,dict_name_en,dict_sort,is_deleted) VALUES
('1', 'MySQL', '1', 'MySQL', 'MySQL', '1',0),
('1', 'Oracle', '2', 'Oracle', 'Oracle', '2',0),
('1', 'SQLServer', '3', 'SQLServer', 'SQLServer', '3',0),
('1', 'Hive2.x', '7', 'Hive2.x', 'Hive2.x', '4',0),
('1', 'MaxCompute', '10', 'MaxCompute', 'MaxCompute', '5',0),
('2','固定值',1,'enum_value','固定值',0,0),
('2','1天波动检测',2,'one_day_wave','1天波动检测',1,0),
('2','7天波动检测',3,'seven_day_wave','7天波动检测',2,0),
('2','月度波动检测',4,'thirty_day_wave','月度波动检测',3,0),
('2','7天平均值波动检测',5,'one_day_avg','7天平均值波动检测',4,0),
('2','月度平均值波动检测',6,'thirty_day_avg','月度平均值波动检测',5,0),
('3','小时',1,'小时','hour',1,0),
('3','天',2,'天','day',2,0),
('3','周',3,'周','week',3,0),
('3','月',4,'月','month',4,0),
('3','手动触发',5,'手动触发','trigger',5,0),
('4','邮件',1,'邮件','mail',1,0),
('4','短信',2,'短信','sms',2,0),
('4','微信',3,'微信','weChar',3,1),
('4','钉钉',4,'钉钉','ding',4,0),
('1', 'TiDB', '31', 'TiDB', 'TiDB', '6',0),
('1', 'Greenplum', '36','Greenplum', 'Greenplum', '7', 0),
('1', 'KingBaseEs8', '40', 'KingBaseEs8', 'KingBaseEs8', '8', 0),
('1', 'SparkThrift2.1.x', '45','SparkThrift2.1.x', 'SparkThrift2.1.x', '9', 0),
('1', 'KAFKA_2X', '37', 'Kafka2.x', 'KAFKA_2X', '10', 0),
('1', 'KAFKA_10', '17', 'Kafka_0.10', 'KAFKA_10', '11', 0);


INSERT INTO `dq_role`(`id`, `tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (1, -1, -1, '租户所有者', 1, 1, '所有权限', 0, now(), now(), 0);
INSERT INTO `dq_role`(`id`, `tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (2, -1, -1, '项目管理员', 1, 2, '项目空间管理者，可使用项目空间全部功能。项目管理员不能对项目所有者操作。', 0, now(), now(), 0);
INSERT INTO `dq_role`(`id`, `tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (3, -1, -1, '数据开发', 1, 4, '可使用全部功能，不能进行用户管理', 0, now(), now(), 0);
INSERT INTO `dq_role`(`id`, `tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (4, -1, -1, '访客', 1, 3, '只有查看权限，不能新建、编辑各类质量校验任务', 0, now(), now(), 0);
INSERT INTO `dq_role`(`id`, `tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`) VALUES (5, -1, -1, '项目所有者', 1, 5, '项目空间所有者，拥有项目空间内的最高权限，可对项目空间中的全部资源和用户进行管理。', 0, now(), now(), 0);


INSERT into dq_function(id,name_zc,name_en,level,have_dirty,is_multiple_support,type,sort) VALUES
(1,'表行数','line_count',1,0,0,1,1),
(3,'空值数','null_count',0,1,1,1,2),
(4,'空值率','null_percent',0,1,1,1,3),
(5,'空串数','empty_count',0,1,1,1,4),
(6,'空串率','empty_percent',0,1,1,1,5),
(7,'重复数','repeat_count',0,1,1,4,1),
(8,'重复率','repeat_percent',0,1,1,4,2),
(9,'非重复值个数','unique_count',0,1,0,4,3),
(10,'非重复值占比','unique_percent',0,1,0,4,4),
(11,'数值-枚举范围','enum_count',0,1,0,3,2),
(12,'数值-枚举个数','distinct_count',0,0,0,3,3),
(13,'负值比','minus_percent',0,1,0,2,3),
(14,'零值比','zero_percent',0,1,0,2,4),
(15,'正值比','plus_percent',0,1,0,2,5),
(16,'字符串-最大长度','max_len',0,1,0,3,7),
(17,'字符串-最小长度','min_len',0,1,0,3,8),
(20,'求平均','avg',0,1,0,2,2),
(21,'求和','sum',0,1,0,2,1),

(22,'格式-身份证号','personalId',2,1,0,3,4),
(23,'格式-手机号','phoneNumber',2,1,0,3,5),
(24,'格式-邮箱','email',2,1,0,3,6),
(25,'数值-取值范围','value_range',0,1,0,3,1);


update dq_function set is_deleted = 1 where id = 2;



-- mysql类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 1, 'select count(1)  as  line_count  from ${table} where 1=1 ${filter}','');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 1, 'select count(1) as col_count from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME="${table}" and TABLE_SCHEMA="${db}"','');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 1, 'select count(1) as null_count from ${table} where ${col} is null ${filter}','${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 1, 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as null_percent from ${table} where 1=1 ${filter}','${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 1, 'select sum(case when char_length(${col})=0 then 1 else 0 end) as empty_count from ${table} where 1=1 ${filter}','${table} where char_length(${col})=0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 1, 'select sum(case when char_length(${col})=0 then 1 else 0 end) / count(1) as empty_percent from ${table} where 1=1 ${filter}','${table} where char_length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 1, 'select count(1) as repeat_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 1, 'select sum(case when count>1 then 1 else 0 end) / sum(count) as repeat_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 1, 'select count(1) as unique_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 1, 'select sum(case when count=1 then 1 else 0 end) / sum(count) as unique_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 1, 'select count(1) as enum_count from  ${table} where  ${col} ${enum}  ${filter} ','${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 1, 'select count(distinct coalesce(${col},"NULL"))  as distinct_count from ${table} where 1=1 ${filter}','');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 1, 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as minus_percent from ${table} where 1=1 ${filter}','${table} where ${col} < 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 1, 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as zero_percent from ${table} where 1=1 ${filter}','${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 1, 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as plus_percent from ${table} where 1=1 ${filter}','${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 1, 'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}','${table} where char_length(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 1, 'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}','${table} where char_length(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 1, 'select max(${col}) as val from ${table} where 1=1 ${filter}','${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 1, 'select min(${col}) as val from ${table} where 1=1 ${filter}','${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 1, 'select avg(${col}) as val from ${table} where 1=1 ${filter}','');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 1, 'select sum(${col}) as val from ${table} where 1=1 ${filter}',' ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 1, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}', '${table} where  ${col} NOT RLIKE ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 1, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[1][35678][0-9]{9}$" ${filter}', '${table} where ${filter} ${col} NOT RLIKE "^[1][35678][0-9]{9}$"');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 1, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$"  ${filter}', '${table} where ${filter} ${col} NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$"');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 1, 'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');

-- hive类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 7, 'select count(1)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 7, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 7, 'select count(1) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 7, 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 7, 'select sum(case when length(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 7, 'select sum(case when length(${col})=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 7, 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 7, 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 7, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 7, 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 7, 'select count(1) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 7, 'select count(1) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 7, 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 7, 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 7, 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 7, 'SELECT max(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 7, 'SELECT min(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 7, 'select max(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 7, 'select min(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 7, 'select avg(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 7, 'select sum(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 7, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter}', '${table} where ${col} NOT RLIKE ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 7, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1]([3-9])[0-9]{9}$" ${filter}', '${table} where ${col}  NOT RLIKE "^[1][35678][0-9]{9}$" ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 7, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}', '${table} where ${col}  NOT RLIKE "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 7, 'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');


-- sqlServer类型
insert into dq_function_template (function_id, data_source_type, template,template_query) values
(1,3,'select count(1)  as  line_count  from ${table} where 1=1 ${filter}',''),
(2,3,"select count(1) as col_count from syscolumns where id = object_id('${table}')",''),
(3,3,'select count(1) as null_count from ${table} where ${col} is null ${filter}','${table} where ${col} is null ${filter}'),
(4,3,'select cast(sum(case when ${col} is null then 1 else 0 end) as float) / count(1) as null_percent from ${table} where 1=1 ${filter}','${table} where ${col} is null ${filter}'),
(5,3,'select sum(case when len(${col})=0 then 1 else 0 end) as empty_count from ${table} where 1=1 ${filter}','${table} where len(${col})=0 ${filter}'),
(6,3,'select cast(sum(case when len(${col})=0 then 1 else 0 end) as float) / count(1) as empty_percent from ${table} where 1=1 ${filter}','${table} where len(${col})=0 ${filter}'),
(7,3,'select count(1) as repeat_count from (select count(${col}) as _count from ${table} where 1=1 ${filter}  group by ${col} having count(${col}) > 1) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'),
(8,3,'select cast(sum(case when count>1 then 1 else 0 end) as float) / sum(count) as repeat_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'),
(9,3,'select count(1) as unique_count from (select count(${col}) as count from ${table} where 1=1 ${filter}  group by ${col} having count(${col}) = 1) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}'),
(10,3,'select cast(sum(case when count=1 then 1 else 0 end) as float) / sum(count) as unique_percent from (select count(${col}) as count from ${table} where 1=1 ${filter}  group by ${col}) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)'),
(11,3,'select count(1) as enum_count from  ${table}  where  ${col} ${enum} ${filter}','${table} where ${col} ${enum} ${filter}'),
(12,3,'select count(1) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp',''),
(13,3,'select cast(sum(case when ${col} < 0 then 1 else 0 end) as float) / count(1) as minus_percent from ${table}  where 1=1 ${filter}','${table} where ${col} < 0 ${filter}'),
(14,3,'select cast(sum(case when ${col} = 0 then 1 else 0 end) as float) / count(1) as minus_percent from ${table}  where 1=1 ${filter}','${table} where ${col} = 0 ${filter}'),
(15,3,'select cast(sum(case when ${col} > 0 then 1 else 0 end) as float) / count(1) as minus_percent from ${table}  where 1=1 ${filter}','${table} where ${col} > 0 ${filter}'),
(16,3,'select max(len(${col})) as str_len from ${table} where 1=1 ${filter}','${table} where len(${col})> ${expectation} ${filter}'),
(17,3,'select min(len(${col})) as str_len from ${table} where 1=1 ${filter}','${table} where len(${col})< ${expectation} ${filter}'),
(18,3,'select max(${col}) as max from ${table} where 1=1 ${filter}','${table} where 1=1 and  ${col}> ${expectation} ${filter}'),
(19,3,'select min(${col}) as min from ${table} where 1=1 ${filter}','${table} where 1=1 and  ${col}< ${expectation} ${filter}'),
(20,3,'select avg(${col}) as avg from ${table} where 1=1 ${filter}',''),
(21,3,'select sum(${col}) as sum from ${table} where 1=1 ${filter}',''),
(25,3,'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}','${table} where ${reverse_range} ${filter}');

-- oracle类型
insert into dq_function_template (function_id, data_source_type, template,template_query) values
(1,2,'select count(1)  as  val  from ${table} where 1=1 ${filter}',''),
(2,2,"select count(1) as col_count from user_col_comments where table_name = upper('${table}')",''),
(3,2,'select count(1) as val from ${table} where ${col} is null ${filter}','${table} t2 where ${col} is null ${filter}'),
(4,2,'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} t2 where ${col} is null ${filter}'),
(5,2,'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}','${table} t2 where length(trim(${col})) is null ${filter}'),
(6,2,'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} t2 where length(trim(${col})) is null ${filter}'),
(7,2,'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'),
(8,2,'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)'),
(9,2,'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp','${table} t2 where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}'),
(10,2,'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)'),
(11,2,'select count(1) as val from  ${table}  where  ${col} ${enum}  ${filter}','${table} t2 where ${col} ${enum} ${filter}'),
(12,2,'select  count(distinct ${col})  as val from ${table} where 1=1 ${filter}',''),
(13,2,'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} t2 where ${col} < 0 ${filter}'),
(14,2,'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} t2 where ${col} = 0 ${filter}'),
(15,2,'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} t2 where ${col} > 0 ${filter}'),
(16,2,'SELECT max(nvl(length(${col}),0)) as val from ${table} where 1=1 ${filter}','${table} t2 where length(${col})> ${expectation} ${filter}'),
(17,2,'SELECT min(nvl(length(${col}),0)) as val from ${table} where 1=1 ${filter}','${table} t2 where length(${col})< ${expectation} ${filter}'),
(18,2,'select max(${col}) as val from ${table} where 1=1 ${filter}','${table} t2 where 1=1 and ${col}> ${expectation} ${filter}'),
(19,2,'select min(${col}) as val from ${table} where 1=1 ${filter}','${table} t2 where 1=1 and ${col}< ${expectation} ${filter}'),
(20,2,'select avg(nvl(${col},0)) as val from ${table} where 1=1 ${filter}',''),
(21,2,'select sum(${col}) as val from ${table} where 1=1 ${filter}',''),
(22,2,'select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\') ${filter}', '${table} t2 WHERE ${filter} not regexp_like(${col}  , \'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\')'),
(23,2,'select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^1[3578]\\d{9}$\'\') ${filter}','${table} t2 WHERE ${filter} not regexp_like(${col}, \'\'^[1][35678][0-9]{9}$\'\')'),
(24,2,'select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}', '${table} t2 WHERE not regexp_like(${col},\'\'^w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}'),
(25,2,'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}','${table} where ${reverse_range} ${filter}');

-- maxCompute类型
insert into dq_function_template (function_id, data_source_type, template,template_query) values
(1,10,'select count(1)  as val  from ${table} where 1=1 ${filter}',''),
(2,10,'',''),
(3,10,'select count(1) as val from ${table} where ${col} is null ${filter}','${table} where ${col} is null ${filter}'),
(4,10,'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} is null ${filter}'),
(5,10,'select sum(case when length(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}','${table} where length(${col})=0 ${filter}'),
(6,10,'select sum(case when length(${col})=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where length(${col})=0 ${filter}'),
(7,10,'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(${col}) > 1) ${filter}'),
(8,10,'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${unionFilter} group by ${col} having count(${col}) > 1) ${filter}'),
(9,10,'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}'),
(10,10,'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}'),
(11,10,'select count(1) as val from  ${table}  where  ${col} ${enum}  ${filter}','${table} where ${col} ${enum} ${filter}'),
(12,10,'select count(1) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp',''),
(13,10,'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} < 0 ${filter}'),
(14,10,'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} = 0 ${filter}'),
(15,10,'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} > 0 ${filter}'),
(16,10,'SELECT max(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})> ${expectation} ${filter}'),
(17,10,'SELECT min(length(${col})) as val from ${table} where 1=1 ${filter}','${table} where length(${col})< ${expectation} ${filter}'),
(18,10,'select max(${col}) as val from ${table} where 1=1 ${filter}','${table} where 1=1 and ${col}> ${expectation} ${filter}'),
(19,10,'select min(${col}) as val from ${table} where 1=1 ${filter}','${table} where 1=1 and ${col}< ${expectation} ${filter}'),
(20,10,'select avg(${col}) as val from ${table} where 1=1 ${filter}',''),
(21,10,'select sum(${col}) as val from ${table} where 1=1 ${filter}',''),
(22,10,'SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') =1 ${filter}','${table} WHERE   regexp_count(${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'')=0  ${filter}'),
(23,10,'SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''^[1]([3-9])[0-9]{9}$'')=1 ${filter}','${table} WHERE  regexp_count(${col}, ''^[1][35678][0-9]{9}$'')=0 ${filter}'),
(24,10,'SELECT count(1) AS val FROM ${table} WHERE regexp_count(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$'')=1 ${filter}','${table} WHERE regexp_count(${col},  ''^[-[:alnum:]_]+@[-[:alnum:]_]+\.[-[:alnum:]_]+$'')=0 ${filter}'),
(25,10,'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}','${table} where ${reverse_range} ${filter}');

-- TiDB类型
INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(1,31,'select count(1)  as  line_count  from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
,(2,31,'select count(1) as col_count from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME="${table}" and TABLE_SCHEMA="${db}"',NOW(),NOW(),1,'')
,(3,31,'select count(1) as null_count from ${table} where ${col} is null ${filter}',NOW(),NOW(),0,'${table} where ${col} is null ${filter}')
,(4,31,'select sum(case when ${col} is null then 1 else 0 end) / count(1) as null_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} is null ${filter}')
,(5,31,'select sum(case when char_length(${col})=0 then 1 else 0 end) as empty_count from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where char_length(${col})=0 ${filter} ')
,(6,31,'select sum(case when char_length(${col})=0 then 1 else 0 end) / count(1) as empty_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where char_length(${col})=0 ${filter}')
,(7,31,'select count(1) as repeat_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp',NOW(),NOW(),0,'${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)')
,(8,31,'select sum(case when count>1 then 1 else 0 end) / sum(count) as repeat_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',NOW(),NOW(),0,'${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)')
,(9,31,'select count(1) as unique_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}')
,(10,31,'select sum(case when count=1 then 1 else 0 end) / sum(count) as unique_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 group by ${col} having count(${col}) > 1) ${filter}')
;
INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(11,31,'select count(1) as enum_count from  ${table} where ${col} ${enum} ${filter}',NOW(),NOW(),0,'${table} where ${col} ${enum} ${filter}')
,(12,31,'select count(distinct coalesce(${col},"NULL"))  as distinct_count from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
,(13,31,'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as minus_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} < 0 ${filter}')
,(14,31,'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as zero_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} = 0 ${filter}')
,(15,31,'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as plus_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} > 0 ${filter}')
,(16,31,'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having char_length(${col})> ${expectation} ${filter}')
,(17,31,'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having char_length(${col})< ${expectation} ${filter}')
,(18,31,'select max(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having ${col}> ${expectation} ${filter}')
,(19,31,'select min(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having ${col}< ${expectation} ${filter}')
,(20,31,'${table} where 1=1 ${filter} having ${col}< ${expectation} ${filter}',NOW(),NOW(),0,'')
;
INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(21,31,'select sum(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
;

INSERT INTO valid.dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(22,31,'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}',now(),now(),0,'${table} where  ${col} NOT RLIKE ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}')
,(23,31,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1][35678][0-9]{9}$" ${filter}',now(),now(),0,'${table} where ${col}  NOT RLIKE "^[1][35678][0-9]{9}$" ${filter}')
,(24,31,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$" ${filter}',now(),now(),0,'${table} where ${col}  NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$" ${filter}')
,(25,31,'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}',now(),now(),0,'${table} where ${reverse_range} ${filter}')
;

-- Greenplum类型
INSERT into dq_function_template (function_id, data_source_type, template, template_query) values
(1,36,'select count(1) as val from ${table} where 1=1 ${filter}', ''),
(2,36,'select count(1) as val from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME=''${table}'' and TABLE_SCHEMA=''${db}''',''),
(3,36,'select count(1) as val from ${table} where ${col} is null ${filter}','${table} where ${col} is null ${filter}'),
(4,36,'select round(sum(case when ${col} is null then 1 else 0 end)::numeric / count(1)::numeric, 4) as val from ${table} where 1=1 ${filter}',' ${table} where ${col} is null ${filter}'),
(5,36,'select sum(case when char_length(text(${col}))=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}','${table} where char_length(text(${col}))=0 ${filter}'),
(6,36,'select round(sum(case when char_length(text(${col})) != 0 then 1 else 0 end)::numeric / count(1)::numeric, 4) as val from ${table} where 1=1 ${filter}','${table} where char_length(text(${col}))=0 ${filter}'),
(7,36,'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp ','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'),
(8,36,'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}'),
(9,36,'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp	',' ${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'),
(10,36,'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp','${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'),
(11,36,'select count(1) as val from  ${table} where  ${col} ${enum}  ${filter}','${table} where ${col} ${enum} ${filter}'),
(12,36,'select count(distinct coalesce(${col},NULL))  as val from ${table} where 1=1 ${filter}',''),
(13,36,'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} < 0 ${filter}'),
(14,36,'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} = 0 ${filter}'),
(15,36,'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} > 0 ${filter}'),
(16,36,'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}','${table} where char_length(${col})> ${expectation} ${filter}'),
(17,36,'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}','${table} where char_length(${col})< ${expectation} ${filter}'),
(18,36,'select max(${col}) as val from ${table} where 1=1 ${filter}','${table} where ${col}> ${expectation} ${filter}'),
(19,36,'select min(${col}) as val from ${table} where 1=1 ${filter}','${table} where ${col}< ${expectation} ${filter}'),
(20,36,'select avg(${col}) as val from ${table} where 1=1 ${filter}	',''),
(21,36,'select sum(${col}) as val from ${table} where 1=1 ${filter}',''),
(22,36,"SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}","${table} where text(${col}) !~ '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}"),
(23,36,"SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[1][35678][0-9]{9}$' ${filter}","${table} where text(${col}) !~ '^[1][35678][0-9]{9}$'  ${filter} "),
(24,36,"SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[-[:alnum:]_]+@[-[:alnum:]_]+.[-[:alnum:]_]+$'  ${filter}","${table} where text(${col}) !~ '^[-[:alnum:]_]+@[-[:alnum:]_]+.[-[:alnum:]_]+$'  ${filter}"),
(25,36,'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}','${table} where ${reverse_range} ${filter}')
;

-- spark类型
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 45, 'select count(1)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 45, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 45, 'select count(1) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 45, 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 45, 'select sum(case when length(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 45, 'select sum(case when length(${col})=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 45, 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 45, 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 45, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 45, 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
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
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 45, 'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');

update dq_function_template set is_deleted = 1 where function_id = 2;


-- v2.7.0 添加系统参数
INSERT INTO `dq_sys_parameter` VALUES ('1', 'bdp.system.bizdate', 'yyyyMMdd-1', '0');
INSERT INTO `dq_sys_parameter` VALUES ('2', 'bdp.system.cyctime', 'yyyyMMddHHmmss', '0');
INSERT INTO `dq_sys_parameter` VALUES ('3', 'bdp.system.currmonth', 'yyyyMM-0', '0');
INSERT INTO `dq_sys_parameter` VALUES ('4', 'bdp.system.premonth', 'yyyyMM-1', '0');
INSERT INTO `dq_sys_parameter` VALUES ('5', 'bdp.system.recentPart', '', '0');
insert into dq_sys_parameter values('6','bdp.system.bizdate2','yyyy-MM-dd','0');
insert into dq_sys_parameter values('7','bdp.system.runtime','yyyyMMddHHmmss','0');


-- -----------------------------------
-- ----------Quartz 定时任务------------
-- -----------------------------------
INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '*/20 * * * * ?', 'monitorDataSyncJob', 'monitorDataSyncJobGroup', 'monitorDataSyncTrigger', 'monitorDataSyncTriggerGroup', 'com.dtstack.dq.schedule.job.MonitorDataSyncJob', '0', null, null, now(), now(), '0'),
('dq', '*/10 * * * * ?', 'verifyReportJob', 'verifyReportJobGroup', 'verifyReportJobTrigger', 'verifyReportJobTriggerGroup', 'com.dtstack.dq.schedule.job.VerifyReportJob', '0', null, null, now(), now(), '0'),
('dq', '*/10 * * * * ?', 'verifyLifecycleJob', 'verifyLifecycleJobGroup', 'verifyLifecycleJobTrigger', 'verifyLifecycleJobTriggerGroup', 'com.dtstack.dq.schedule.job.VerifyLifecycleJob', '0', null, null, now(), now(), '0'),
('dq', '* * 2 * * ?', 'monitorDataSyncDayJob','monitorDataSyncDayJob','monitorDataSyncDayJobTrigger','monitorDataSyncDayJobTriggerGroup','com.dtstack.dq.schedule.job.MonitorDataSyncDayJob','0',null,null,now(),now(),'0'),
('dq', '* * 2 * * ?', 'verifyDataSyncDayJob','verifyDataSyncDayJob','verifyDataSyncDayJobTrigger','verifyDataSyncDayJobTriggerGroup','com.dtstack.dq.schedule.job.VerifyDataSyncDayJob','0',null,null,now(),now(),'0'),
('dq', '* * 3 * * ?', 'temporaryTableLifecycleJob','temporaryTableLifecycleJob','temporaryTableLifecycleJobTrigger','temporaryTableLifecycleJobTriggerGroup','com.dtstack.dq.schedule.job.TemporaryTableLifecycleJob','0',null,null,now(),now(),'0'),
('dq', '0 0 4 * * ?', 'streamLifecycleJob','streamLifecycleJobGroup','streamLifecycleJobTrigger','streamLifecycleJobTriggerGroup','com.dtstack.dq.schedule.job.StreamLifecycleJob','0',null,null,now(),now(),'0'),
('dq', '*/15 * * * * ?', 'streamDataSyncJob','streamDataSyncJobGroup','streamDataSyncJobTrigger','streamDataSyncJobTriggerGroup','com.dtstack.dq.schedule.job.StreamDataSyncJob','0',null,null,now(),now(),'0');


-- -----------------------------------
-- ----------新增数据源 人大金仓------------
-- -----------------------------------


INSERT INTO  `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (1, 40, 'select count(1)  as  val  from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template`, `template_query`) VALUES ( 2, 40, 'select count(1) as val from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME=\'${table}\' and TABLE_SCHEMA=\'${db}\'', '');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES (3, 40, 'select count(1) as val from ${table} where ${col} is null ${filter}',  '${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (4, 40, 'select sum(case when ${col} is null then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}','${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (5, 40, 'select sum(case when char_length(${col})=0 then 1.0 else 0.0 end) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col})=0 ${filter} ');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (6, 40, 'select sum(case when char_length(${col})=0 then 1.0 else 0.0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where char_length(${col})=0 ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (7, 40, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (8, 40, 'select sum(case when count>1 then 1.0 else 0.0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (9, 40, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
INSERT INTO `dq_function_template`(`function_id`, `data_source_type`, `template` , `template_query`) VALUES (10, 40, 'select sum(case when count=1 then 1.0 else 0.0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}');
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
INSERT INTO `dq_function_template`(`function_id`, `data_source_type` , `template`, `template_query`) VALUES (23, 40, 'SELECT count(1) AS val FROM ${table} WHERE  REGEXP_LIKE(${col},\'^[1][35678][0-9]{9}$\') ${filter}', '${table} ${filter} WHERE REGEXP_LIKE (${col}, \'^[1][35678][0-9]{9}$\')');
INSERT INTO `dq_function_template`( `function_id`, `data_source_type`, `template`, `template_query`) VALUES ( 24, 40, 'SELECT count(1) AS val FROM ${table} WHERE  REGEXP_LIKE(${col}, \'^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\')  ${filter}', '${table}  ${filter} WHERE REGEXP_LIKE (${col}, \'^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\')');
INSERT INTO `dq_function_template` (`function_id`, `data_source_type`, `template`, `template_query`) VALUES (25, 40, 'SELECT count(1) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');


-- Kafka2x(对应Flink Streaming SQL)
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 37, 'select cast(count(1) as VARCHAR)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 37, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 37, 'select cast(count(1) as VARCHAR) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 37, 'select cast(sum(case when ${col} is null then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 37, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 37, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 37, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 37, 'select cast(sum(case when c>1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 37, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 37, 'select cast(sum(case when c=1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 37, 'select cast(count(1) as VARCHAR) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 37, 'select cast(count(1) as VARCHAR) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 37, 'select cast(sum(case when ${col} < 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 37, 'select cast(sum(case when ${col} = 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 37, 'select cast(sum(case when ${col} > 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 37, 'SELECT cast(max(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 37, 'SELECT cast(min(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 37, 'select cast(max(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 37, 'select cast(min(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 37, 'select cast(avg(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 37, 'select cast(sum(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter}', '${table} where NOT REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[1]([3-9])[0-9]{9}$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[1][35678][0-9]{9}$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');



-- KAFKA_10(对应Flink Streaming SQL)
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 17, 'select cast(count(1) as VARCHAR)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 17, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 17, 'select cast(count(1) as VARCHAR) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 17, 'select cast(sum(case when ${col} is null then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 17, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 17, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 17, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 17, 'select cast(sum(case when c>1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 17, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 17, 'select cast(sum(case when c=1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 17, 'select cast(count(1) as VARCHAR) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 17, 'select cast(count(1) as VARCHAR) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 17, 'select cast(sum(case when ${col} < 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 17, 'select cast(sum(case when ${col} = 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 17, 'select cast(sum(case when ${col} > 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 17, 'SELECT cast(max(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 17, 'SELECT cast(min(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 17, 'select cast(max(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 17, 'select cast(min(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 17, 'select cast(avg(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 17, 'select cast(sum(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter}', '${table} where NOT REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[1]([3-9])[0-9]{9}$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[1][35678][0-9]{9}$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');

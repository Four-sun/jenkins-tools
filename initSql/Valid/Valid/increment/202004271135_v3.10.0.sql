insert into dq_dict values(default ,1,'TiDB',31,'TiDB','TiDB',6,now(),now(),0);


INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(1,31,'select count(1)  as  line_count  from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
,(2,31,'select count(1) as col_count from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME="${table}" and TABLE_SCHEMA="${db}"',NOW(),NOW(),1,'')
,(3,31,'select count(1) as null_count from ${table} where ${col} is null ${filter}',NOW(),NOW(),0,'${table} where ${col} is null ${filter}')
,(4,31,'select sum(case when ${col} is null then 1 else 0 end) / count(1) as null_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} is null ${filter}')
,(5,31,'select sum(case when char_length(${col})=0 then 1 else 0 end) as empty_count from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where char_length(${col})=0 ${filter} ')
,(6,31,'select sum(case when char_length(${col})=0 then 1 else 0 end) / count(1) as empty_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where char_length(${col})=0 ${filter}')
,(7,31,'select count(1) as repeat_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count > 1) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)')
,(8,31,'select sum(case when count>1 then 1 else 0 end) / sum(count) as repeat_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)')
,(9,31,'select count(1) as unique_count from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}')
,(10,31,'select sum(case when count=1 then 1 else 0 end) / sum(count) as unique_percent from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',NOW(),NOW(),0,'${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}')
;
INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(11,31,'select count(1) as enum_count from  ${table} where ${col} ${enum} ${filter}',NOW(),NOW(),0,'${table} where ${col} ${enum} ${filter}')
,(12,31,'select count(distinct coalesce(${col},"NULL"))  as distinct_count from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
,(13,31,'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as minus_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} < 0 ${filter}')
,(14,31,'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as zero_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} = 0 ${filter}')
,(15,31,'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as plus_percent from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where ${col} > 0 ${filter}')
,(16,31,'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having max(char_length(${col}))')
,(17,31,'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having min(char_length(${col}))')
,(18,31,'select max(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having max(${col})')
,(19,31,'select min(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'${table} where 1=1 ${filter} having min(${col})')
,(20,31,'select avg(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
;
INSERT INTO dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(21,31,'select sum(${col}) as val from ${table} where 1=1 ${filter}',NOW(),NOW(),0,'')
;

INSERT INTO valid.dq_function_template (function_id,data_source_type,template,gmt_create,gmt_modified,is_deleted,template_query) VALUES
(22,31,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}',now(),now(),0,'${table} where ${col}  NOT RLIKE ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}')
,(23,31,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1]([3-9])[0-9]{9}$" ${filter}',now(),now(),0,'${table} where ${col}  NOT RLIKE "^[1][35678][0-9]{9}$" ${filter}')
,(24,31,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}',now(),now(),0,'${table} where ${col}  NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$" ${filter}')
;
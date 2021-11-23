-- 更新mysql数据源类型的函数模板，因为表名存在特殊字符，所以在表名的外面加上`号
update dq_function_template set template = 'select count(1)  as  line_count  from `${table}` where 1=1 ${filter}' where function_id = 1 and data_source_type = 1;

update dq_function_template set template = 'select count(1) as null_count from `${table}` where ${col} is null ${filter}', template_query = '`${table}` where ${col} is null ${filter}' where function_id = 3 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as null_percent from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} is null ${filter}' where function_id = 4 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when char_length(${col})=0 then 1 else 0 end) as empty_count from `${table}` where 1=1 ${filter}', template_query = '`${table}` where char_length(${col})=0 ${filter} ' where function_id = 5 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when char_length(${col})=0 then 1 else 0 end) / count(1) as empty_percent from `${table}` where 1=1 ${filter}', template_query = '`${table}` where char_length(${col})=0 ${filter}' where function_id = 6 and data_source_type = 1;

update dq_function_template set template = 'select count(1) as repeat_count from (select count(${col}) as count from `${table}` where 1=1 ${filter} group by ${col} having count > 1) temp', template_query = '`${table}` where ${col} in (select  ${col} from `${table}` where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = 7 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when count>1 then 1 else 0 end) / sum(count) as repeat_percent from (select count(${col}) as count from `${table}` where 1=1 ${filter} group by ${col}) temp', template_query = '`${table}` where ${col} in (select  ${col} from `${table}` where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = 8 and data_source_type = 1;

update dq_function_template set template = 'select count(1) as unique_count from (select count(${col}) as count from `${table}` where 1=1 ${filter} group by ${col} having count = 1) temp', template_query = '`${table}` where ${col} in (select  ${col} from `${table}` where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = 9 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when count=1 then 1 else 0 end) / sum(count) as unique_percent from (select count(${col}) as count from `${table}` where 1=1 ${filter} group by ${col}) temp', template_query = '`${table}` where ${col} in (select  ${col} from `${table}` where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}' where function_id = 10 and data_source_type = 1;

update dq_function_template set template = 'select count(1) as enum_count from  `${table}` where  ${col} ${enum}  ${filter} ', template_query = '`${table}` where ${col} ${enum} ${filter}' where function_id = 11 and data_source_type = 1;

update dq_function_template set template = 'select count(distinct coalesce(${col},"NULL"))  as distinct_count from `${table}` where 1=1 ${filter}' where function_id = 12 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as minus_percent from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} < 0 ${filter}' where function_id = 13 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as zero_percent from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} = 0 ${filter}' where function_id = 14 and data_source_type = 1;

update dq_function_template set template = 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as plus_percent from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} > 0 ${filter}' where function_id = 15 and data_source_type = 1;

update dq_function_template set template = 'SELECT max(char_length(${col})) as val from `${table}` where 1=1 ${filter}', template_query = '`${table}` where char_length(${col}) = (select max(char_length(${col})) from `${table}` where 1=1 ${filter} ) ${filter}' where function_id = 16 and data_source_type = 1;

update dq_function_template set template = 'SELECT min(char_length(${col})) as val from `${table}` where 1=1 ${filter}', template_query = '`${table}` where char_length(${col}) = (select min(char_length(${col})) from `${table}` where 1=1 ${filter} ) ${filter}' where function_id = 17 and data_source_type = 1;

update dq_function_template set template = 'select max(${col}) as val from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} = (select max(${col}) from `${table}` where 1=1 ${filter} ) ${filter}' where function_id = 18 and data_source_type = 1;

update dq_function_template set template = 'select min(${col}) as val from `${table}` where 1=1 ${filter}', template_query = '`${table}` where ${col} = (select min(${col}) from `${table}` where 1=1 ${filter} ) ${filter}' where function_id = 19 and data_source_type = 1;

update dq_function_template set template = 'select avg(${col}) as val from `${table}` where 1=1 ${filter}' where function_id = 20 and data_source_type = 1;

update dq_function_template set template = 'select sum(${col}) as val from `${table}` where 1=1 ${filter}' where function_id = 21 and data_source_type = 1;

update dq_function_template set template = "SELECT count(1) AS val FROM `${table}` WHERE ${col}  REGEXP '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}", template_query = "`${table}` where ${filter} ${col} NOT RLIKE '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'" where function_id = 22 and data_source_type = 1;

update dq_function_template set template = 'SELECT count(1) AS val FROM `${table}` WHERE ${col}  REGEXP "^[1][35678][0-9]{9}$" ${filter}', template_query = '`${table}` where ${filter} ${col} NOT RLIKE "^[1][35678][0-9]{9}$"' where function_id = 23 and data_source_type = 1;

update dq_function_template set template = 'SELECT count(1) AS val FROM `${table}` WHERE ${col}  REGEXP "^[-[:alnum:]_]+@[-[:alnum:]_]+\.[-[:alnum:]_]+$"  ${filter}', template_query = '`${table}` where ${filter} ${col} NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\.[-[:alnum:]_]+$"' where function_id = 24 and data_source_type = 1;

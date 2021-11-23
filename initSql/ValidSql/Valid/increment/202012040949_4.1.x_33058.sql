-- hive2数据源-重复数模板更新
-- 在子查询中添加表别名
update dq_function_template
set template       = 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp',
    template_query = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}'
where function_id = 7
  and data_source_type = 7;
-- hive2数据源-重复率模板更新
-- 在子查询中添加表别名
update dq_function_template
set template       = 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col}) temp',
    template_query = '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}'
where function_id = 8
  and data_source_type = 7;

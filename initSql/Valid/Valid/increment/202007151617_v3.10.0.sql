-- 更新oracle类型的规则模板，针对特殊表名导致的执行sql失败，加双引号
update dq_function_template set template = 'select count(1)  as  val  from "${table}" where 1=1 ${filter}', template_query=''
where function_id = 1 and data_source_type = 2;
update dq_function_template set template = 'select count(1) as val from "${table}" where ${col} is null ${filter}', template_query='"${table}" where ${col} is null ${filter}'
where function_id = 3 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where ${col} is null ${filter}'
where function_id = 4 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where length(trim(${col}) is null ${filter}'
where function_id = 5 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) / count(1) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where length(trim(${col}) is null ${filter}'
where function_id = 6 and data_source_type = 2;
update dq_function_template set template = 'select count(1) as val from (select count(${col}) from "${table}" where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', template_query='"${table}" where ${col} in (select  ${col} from "${table}" where 1=1 ${filter} group by ${col} having count(${col}) > 1)'
where function_id = 7 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from "${table}" where 1=1 ${filter} group by ${col}) temp', template_query='"${table}" where ${col} in (select  ${col} from "${table}" where 1=1 ${filter} group by ${col} having count(${col}) > 1)'
where function_id = 8 and data_source_type = 2;
update dq_function_template set template = 'select count(1) as val from (select count(${col}) from "${table}" where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', template_query='"${table}" where ${col} in (select  ${col} from "${table}" where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
where function_id = 9 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from "${table}" where 1=1 ${filter} group by ${col}) temp', template_query='"${table}" where ${col} in (select  ${col} from "${table}" where 1=1 ${filter} group by ${col} having count(${col}) > 1)'
where function_id = 10 and data_source_type = 2;
update dq_function_template set template = 'select count(1) as val from  "${table}"  where  ${col} ${enum}  ${filter}', template_query='"${table}" where ${col} ${enum} ${filter}'
where function_id = 11 and data_source_type = 2;
update dq_function_template set template = 'select  count(distinct ${col})  as val from "${table}" where 1=1 ${filter}', template_query=''
where function_id = 12 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where ${col} < 0 ${filter}'
where function_id = 13 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where ${col} = 0 ${filter}'
where function_id = 14 and data_source_type = 2;
update dq_function_template set template = 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where ${col} > 0 ${filter}'
where function_id = 15 and data_source_type = 2;
update dq_function_template set template = 'SELECT max(nvl(length(${col}),0)) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where length(${col}) = (select max(length(${col})) from "${table}" ${filter}) ${filter} '
where function_id = 16 and data_source_type = 2;
update dq_function_template set template = 'SELECT min(nvl(length(${col}),0)) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where length(${col}) = (select min(length(${col})) from "${table}" ${filter}) ${filter} '
where function_id = 17 and data_source_type = 2;
update dq_function_template set template = 'select max(${col}) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where 1=1 and ${col}=(select max(${col}) from "${table}"  ) ${filter} '
where function_id = 18 and data_source_type = 2;
update dq_function_template set template = 'select min(${col}) as val from "${table}" where 1=1 ${filter}', template_query='"${table}" where 1=1 and ${col}=(select min(${col}) from "${table}"  ) ${filter} '
where function_id = 19 and data_source_type = 2;
update dq_function_template set template = 'select avg(nvl(${col},0)) as val from "${table}" where 1=1 ${filter}', template_query=''
where function_id = 20 and data_source_type = 2;
update dq_function_template set template = 'select sum(${col}) as val from "${table}" where 1=1 ${filter}', template_query=''
where function_id = 21 and data_source_type = 2;
update dq_function_template set template = 'select count(1) AS val FROM "${table}" WHERE regexp_like(${col},\'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\') ${filter}', template_query='"${table}" WHERE ${filter} not regexp_like(${col}  , \'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\')'
where function_id = 22 and data_source_type = 2;
update dq_function_template set template = 'select count(1) AS val FROM "${table}" WHERE regexp_like(${col},\'\'^1[3578]\\d{9}$\'\') ${filter}', template_query='"${table}" WHERE ${filter} not regexp_like(${col}, \'\'^[1][35678][0-9]{9}$\'\')'
where function_id = 23 and data_source_type = 2;
update dq_function_template set template = 'select count(1) AS val FROM "${table}" WHERE regexp_like(${col},\'\'^\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}', template_query='"${table}" WHERE not regexp_like(${col},\'\'^w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}'
where function_id = 24 and data_source_type = 2;
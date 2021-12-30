update dq_function_template
set template_query ='${table} where length(trim(${col})) is null ${filter}',
template='select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}'
where function_id=5 and data_source_type=2;

update dq_function_template
set template_query ='${table} where length(trim(${col})) is null ${filter}',
template='select sum(case when nvl(length(trim(${col})),0)=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}'
where function_id=6 and data_source_type=2;


update dq_function_template
set template_query ='${table} where length(${col}) = (select max(length(${col})) from ${table} ${filter}) ${filter} '
where function_id=16 and data_source_type=2;

update dq_function_template
set template_query ='${table} where length(${col}) = (select min(length(${col})) from ${table} ${filter}) ${filter}'
where function_id=17 and data_source_type=2;


update dq_function_template set template_query='${table} where len(${col}) = (select max(len(${col})) from ${table} ${filter}) ${filter} '
 where function_id= 16 and data_source_type =3;

update dq_function_template set template_query='${table} where len(${col}) = (select min(len(${col})) from ${table} ${filter}) ${filter} '
 where function_id= 17 and data_source_type =3;



update dq_function_template set template_query='${table} where length(${col}) = (select max(length(${col})) from ${table} ${filter}) ${filter} '
 where function_id= 16 and data_source_type =10;

update dq_function_template set template_query='${table} where length(${col}) = (select min(length(${col})) from ${table} ${filter}) ${filter}'
 where function_id= 17 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 9 and data_source_type =1;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 9 and data_source_type =2;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 9 and data_source_type =3;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 9 and data_source_type =7;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 9 and data_source_type =10;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 10 and data_source_type =2;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 10 and data_source_type =3;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 10 and data_source_type =7;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 10 and data_source_type =10;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'
 where function_id= 10 and data_source_type =1;





update dq_function_template set template_query='${table} where 1=1 ${filter} and  ${col}=(select min(${col}) from ${table} )'
 where function_id= 19 and data_source_type =3;


update dq_function_template set template_query='${table} where 1=1 ${filter} and  ${col}=(select max(${col}) from ${table} )'
 where function_id= 18 and data_source_type =3;

 update dq_function_template set template='select count(1) as enum_count from  ${table} where ${col} ${enum} ${filter}',
 template_query='${table} where ${col} ${enum} ${filter}'
 where function_id= 11 and data_source_type =1;
 update dq_function_template set template='select count(1) as val from  ${table}  where  ${col} ${enum} ${filter}',
 template_query='${table} where ${col} ${enum} ${filter}'
 where function_id= 11 and data_source_type =2;
  update dq_function_template set template='select count(1) as enum_count from  ${table}  where  ${col} ${enum} ${filter}',
  template_query='${table} where ${col} ${enum} ${filter}'
 where function_id= 11 and data_source_type =3;
  update dq_function_template set template='select count(1) as val from  ${table} where ${col} ${enum} ${filter}',
  template_query='${table} where ${col} ${enum} ${filter}'
 where function_id= 11 and data_source_type =7;
update dq_function_template set template='select count(1) as val from  ${table}  where  ${col} ${enum} ${filter}',
template_query='${table} where ${col} ${enum} ${filter}'
 where function_id= 11 and data_source_type =10;

  update dq_function_template set template='SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''^[1]([3-9])[0-9]{9}$'')=1 ${filter}'
 where function_id= 23 and data_source_type =10;

  update dq_function_template set template='select count(1) as val from ${table} where ${col} is null ${filter}'
 where function_id= 3 and data_source_type =7;

   update dq_function_template set template='select count(1)  as val  from ${table} where 1=1 ${filter}'
 where function_id= 1 and data_source_type =7;
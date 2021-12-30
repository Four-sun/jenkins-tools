-- sqlserver脚本
update dq_function_template set template_query='${table} where ${col} is null ${filter}' where function_id= 3 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} is null ${filter}'  where function_id= 4 and data_source_type =3;

update dq_function_template set template_query='${table} where len(${col})=0 ${filter}'  where function_id= 5 and data_source_type =3;

update dq_function_template set template_query='${table} where len(${col})=0 ${filter}'  where function_id= 6 and data_source_type =3;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)' ,  template= 'select count(1) as repeat_count from (select count(${col}) as _count from ${table} where 1=1 ${filter}  group by ${col} having count(${col}) > 1) temp' where function_id= 7 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)'  where function_id= 8 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1)'  where function_id= 9 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1)'
 where function_id= 10 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} is null  ${filter}'
 where function_id= 11 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} < 0 ${filter}'
 where function_id= 13 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} = 0 ${filter}'
 where function_id= 14 and data_source_type =3;

update dq_function_template set template_query='${table} where ${col} > 0 ${filter}'
 where function_id= 15 and data_source_type =3;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,max(len(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} ) as temp) '
 where function_id= 16 and data_source_type =3;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,min(len(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} ) as temp) '
 where function_id= 17 and data_source_type =3;

update dq_function_template set template_query='${table} where 1=1 ${filter} having max(${col})'
 where function_id= 18 and data_source_type =3;

update dq_function_template set template_query='${table} where 1=1 ${filter} having min(${col})'
 where function_id= 19 and data_source_type =3;


-- oracle脚本
update dq_function_template set template_query='${table} where ${col} is null ${filter}' where function_id= 3 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} is null ${filter}'  where function_id= 4 and data_source_type =2;

update dq_function_template set template_query='${table} where length(${col})=0 ${filter}'  where function_id= 5 and data_source_type =2;

update dq_function_template set template_query='${table} where length(${col})=0 ${filter}'  where function_id= 6 and data_source_type =2;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)' where function_id= 7 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)'  where function_id= 8 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1)'  where function_id= 9 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1)'
 where function_id= 10 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} is null  ${filter}'
 where function_id= 11 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} < 0 ${filter}'
 where function_id= 13 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} = 0 ${filter}'
 where function_id= 14 and data_source_type =2;

update dq_function_template set template_query='${table} where ${col} > 0 ${filter}'
 where function_id= 15 and data_source_type =2;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,max(length(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} )
) '
 where function_id= 16 and data_source_type =2;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,min(length(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} )
) '
 where function_id= 17 and data_source_type =2;

update dq_function_template set template_query='${table} where 1=1 and ${col}=(select max(${col}) from ${table}  ) ${filter} '
 where function_id= 18 and data_source_type =2;

update dq_function_template set template_query='${table} where 1=1 and ${col}=(select min(${col}) from ${table}  ) ${filter}  '
 where function_id= 19 and data_source_type =2;

update dq_function_template set
template='select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\') ${filter}',
 template_query='${table} WHERE ${filter} not regexp_like(${col}  , \'\'[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)\'\')'
 where function_id= 22 and data_source_type =2;

update dq_function_template set
template='select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^1[3578]\\d{9}$\'\') ${filter}',
 template_query='${table} WHERE ${filter} not regexp_like(${col}, \'\'^[1][35678][0-9]{9}$\'\')'
 where function_id= 23 and data_source_type =2;
update dq_function_template set
template='select count(1) AS val FROM ${table} WHERE regexp_like(${col},\'\'^\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}\\w+((-\\w+)|(.\\w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}',
 template_query='${table} WHERE not regexp_like(${col},\'\'^w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+(;{1,1}w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+)*$\'\') ${filter}'
 where function_id= 24 and data_source_type =2;

-- odps脚本
update dq_function_template set template='select count(1)  as val  from ${table} where 1=1 ${filter}' where function_id= 1 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} is null ${filter}' where function_id= 3 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} is null ${filter}'  where function_id= 4 and data_source_type =10;

update dq_function_template set template_query='${table} where length(${col})=0 ${filter}'  where function_id= 5 and data_source_type =10;

update dq_function_template set template_query='${table} where length(${col})=0 ${filter}'  where function_id= 6 and data_source_type =10;

 update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}' where function_id= 7 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) > 1) ${filter}'  where function_id= 8 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) = 1) ${filter}'  where function_id= 9 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} in (select  ${col} from ${table} where 1=1 group by ${col} having count(${col}) = 1) ${filter}'
 where function_id= 10 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} is null  ${filter}'
 where function_id= 11 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} < 0 ${filter}'
 where function_id= 13 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} = 0 ${filter}'
 where function_id= 14 and data_source_type =10;

update dq_function_template set template_query='${table} where ${col} > 0 ${filter}'
 where function_id= 15 and data_source_type =10;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,max(length(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} ) node_temp2) '
 where function_id= 16 and data_source_type =10;

update dq_function_template set template_query='${table} where  ${col} in ( select ${col} from (select ${col} ,min(length(${col}))as leng  from ${table} where 1=1 ${filter}  group by ${col} )node_temp2 ) '
 where function_id= 17 and data_source_type =10;

update dq_function_template set template_query='${table} where 1=1 and ${col}=(select max(${col}) from ${table}  ) ${filter} '
 where function_id= 18 and data_source_type =10;

update dq_function_template set template_query='${table} where 1=1 and ${col}=(select min(${col}) from ${table}  ) ${filter}  '
 where function_id= 19 and data_source_type =10;



update dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') =1${filter}',
template_query='${table} WHERE   regexp_count(${col},''[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)'')=0  ${filter}'
 where function_id= 22 and data_source_type =10;

 update dq_function_template set
 template='SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col}，''^[1]([3-9])[0-9]{9}$'')=1 ${filter}',
 template_query='${table} WHERE  regexp_count(${col}, ''^[1][35678][0-9]{9}$'')=0 ${filter}'
 where function_id= 23 and data_source_type =10;

 update dq_function_template set
 template='SELECT count(1) AS val FROM ${table} WHERE regexp_count(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$'')=1 ${filter}',
template_query='${table} WHERE regexp_count(${col},  ''^[-[:alnum:]_]+@[-[:alnum:]_]+\.[-[:alnum:]_]+$'')=0 ${filter}'
 where function_id= 24 and data_source_type =10;
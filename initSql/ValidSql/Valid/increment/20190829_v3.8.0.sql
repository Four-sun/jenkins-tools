update dq_function_template set template='select count(1) as enum_count from  ${table} where  ${col} not in  (${enum})  ${filter} '
 where function_id= 11 and data_source_type =1;



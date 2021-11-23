-- 修复Oracle单表规则模板 空串数、空串率规则SQL不正确
update dq_function_template set template_query='${table} t2 where length(trim(${col})) is null ${filter}'
where function_id = 5 and data_source_type = 2;
update dq_function_template set template_query='${table} t2 where length(trim(${col})) is null ${filter}'
where function_id = 6 and data_source_type = 2;
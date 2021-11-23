-- 修改kingbase关于手机号和邮箱格式校验填充创建脏表数据的模板sql
UPDATE dq_function_template set template_query = '${table} ${filter} WHERE REGEXP_LIKE (${col}, \'^[1][35678][0-9]{9}$\')' where function_id = 23 and data_source_type = 40;

UPDATE dq_function_template set template_query = '${table}  ${filter} WHERE REGEXP_LIKE (${col}, \'^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\')' where function_id = 24 and data_source_type = 40;
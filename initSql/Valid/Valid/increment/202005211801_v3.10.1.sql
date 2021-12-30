-- 修改mysql tidb身份证号格式校验正则
update dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}',
template_query=
'${table} where  ${col} NOT RLIKE ''^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$'' ${filter}'
where (data_source_type = 1 or data_source_type = 31) and function_id = 22;


-- 修改hive的身份证号格式校验正则
update  dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter}',
template_query=
'${table} where ${col} NOT RLIKE ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'' ${filter} '
where data_source_type = 7 and function_id = 22;

-- 修改maxCompute的身份证号格式校验正则
update  dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') =1 ${filter}',
template_query=
'${table} WHERE   regexp_count(${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'')=0  ${filter}'
where data_source_type = 10 and function_id = 22;

-- 修改maxCompute的身份证号格式校验正则
update  dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE  regexp_count( ${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') =1 ${filter}',
template_query=
'${table} WHERE   regexp_count(${col},''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'')=0  ${filter}'
where data_source_type = 10 and function_id = 22;

update  dq_function_template set
template='SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1][35678][0-9]{9}$" ${filter}',
template_query=
'${table} where ${col}  NOT RLIKE "^[1][35678][0-9]{9}$" ${filter}'
where data_source_type = 31 and function_id = 23;

update  dq_function_template set
template=
'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$" ${filter}',
template_query=
'${table} where ${col}  NOT RLIKE "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$" ${filter}'
where data_source_type = 31 and function_id = 24;


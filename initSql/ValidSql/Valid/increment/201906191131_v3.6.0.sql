-- 新增格式校验函数
INSERT into dq_function(id,name_zc,name_en,level) VALUES
(22,'身份证号','personalId',2),
(23,'手机号','phoneNumber',2),
(24,'邮箱','email',2);


-- mysql类型
insert into dq_function_template (function_id, data_source_type, template) values
(22,1,'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)" ${filter}'),
(23,1,'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[1][35678][0-9]{9}$" ${filter}'),
(24,1,'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP "^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$"  ${filter}');

-- oracle类型  execute Immediate 中的单引号要用单引号转义
insert into dq_function_template (function_id, data_source_type, template) values
(22,2,'select count(1) AS val FROM ${table} WHERE regexp_like("${col}",''''[[:digit:]]{6}(18|19|20)[[:digit:]]{2}(0[1-9]|1[120])(0[1-9]|[12][[:digit:]]|3[01])[[:digit:]]{3}([[:digit:]]|X)'''') ${filter}'),
(23,2,'select count(1) AS val FROM ${table} WHERE regexp_like("${col}",''''^1[3578]\\d{9}$'''') ${filter}'),
(24,2,'select count(1) AS val FROM ${table} WHERE regexp_like("${col}",''''^\\w+((-\\w+)|(\.\\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+(;{1,1}\\w+((-\\w+)|(\.\\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+)*$'''') ${filter}');


-- hive类型
insert into dq_function_template (function_id, data_source_type, template) values
(22,7,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)" ${filter}'),
(23,7,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1]([3-9])[0-9]{9}$" ${filter}'),
(24,7,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}');

-- maxCompute类型
insert into dq_function_template (function_id, data_source_type, template) values
(22,10,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)" ${filter}'),
(23,10,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[1]([3-9])[0-9]{9}$" ${filter}'),
(24,10,'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$" ${filter}');



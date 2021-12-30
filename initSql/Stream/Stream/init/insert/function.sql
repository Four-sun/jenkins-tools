begin;
INSERT into rdos_stream_catalogue(tenant_id,project_id,node_name,node_pid,order_val,level,create_user_id,modify_user_id,is_deleted) VALUES (-1,-1,'系统函数',-1,3,1,-1,-1,0);
set @stream_sys_id=(select id from rdos_stream_catalogue where node_name='系统函数');
INSERT into rdos_stream_catalogue(tenant_id,project_id,node_name,node_pid,level,create_user_id,modify_user_id,is_deleted)
VALUES (-1,-1,'数学函数',@stream_sys_id,2,-1,-1,0),
(-1,-1,'日期函数',@stream_sys_id,2,-1,-1,0),
(-1,-1,'字符函数',@stream_sys_id,2,-1,-1,0),
(-1,-1,'聚合函数',@stream_sys_id,2,-1,-1,0),
(-1,-1,'其它函数',@stream_sys_id,2,-1,-1,0);
commit;

begin;
set @math=(select id from rdos_stream_catalogue where node_name='数学函数');
INSERT INTO `rdos_stream_function`(name,class_name,purpose,command_format,param_desc,node_pid,tenant_id,project_id,create_user_id,modify_user_id, resource_id ,udf_type,type,gmt_create,gmt_modified,is_deleted)
VALUES ('POWER', 'null', '计算次幂', 'POWER(numeric1, numeric2)', '返回 numeric1 的 numeric2 次幂.', @math, -1, -1, -1, -1, -1, 0 , 1, now(), now(), 0),
('ABS', 'null', '计算numeric的绝对值', 'ABS(numeric)', '计算numeric的绝对值.', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('MOD', 'null', 'numeric1 对 numeric2 取模', 'MOD(numeric1, numeric2)', '返回numeric1除以numeric2的余数(模数). 仅当numeric1为负时结果为负.', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('SQRT', 'null', '计算平方根', 'SQRT(numeric)', '计算numeric平方根.', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('LN', 'null', '	计算自然数的对数', 'LN(numeric)', '返回numeric的自然对数(以e为底)', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('LOG10', 'null', '	返回数字10的对数', 'LOG10(numeric) ', '返回numeric的对数(以10为底)', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('EXP', 'null', '	计算自然指数的指数', 'EXP(numeric)', '返回自然对数e的numeric幂次方', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('CEIL', 'null', '向上取整', 'CEIL(numeric) or CEILING(numeric)', '求其不小于小给定实数的最小整数如：ceil(6.1)= ceil(6.9) = 7', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('FLOOR', 'null', '向下取整', 'FLOOR(numeric)', '求其不大于给定实数的最小整数如：FLOOR(6.1)= FLOOR(6.9) = 6', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('SIN', 'null', '计算正弦值', 'SIN(numeric)', '计算正弦值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('COS', 'null', '计算余弦值', 'COS(numeric)', '计算余弦值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('TAN', 'null', '计算正切值', 'TAN(numeric)', '计算正切值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('COT', 'null', '计算余切值', 'COT(numeric)', '计算余切值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('ASIN', 'null', '计算反正弦值', 'ASIN(numeric)', '计算反正弦值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('ACOS', 'null', '计算反余弦值', 'ACOS(numeric)', '计算反余弦值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('ATAN', 'null', '计算反正切值', 'ATAN(numeric)', '计算反正切值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('DEGREES', 'null', '弧度值转换角度值', 'DEGREES(numeric)', '弧度值转换角度值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('RADIANS', 'null', '将角度值转换成弧度值', 'RADIANS(numeric)', '将角度值转换成弧度值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('SIGN', 'null', '计算数字的标志', 'SIGN(numeric)', '如果numeric是正数则返回1.0, 是负数则返回-1.0, 否则返回0.0 ', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('ROUND', 'null', '取近似值', 'ROUND(numeric, int)', '返回numeric的保留int位小数的近似值', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('PI', 'null', '取数学常数pi', 'PI()', '取数学常数pi', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('E', 'null', '取数学常数e', 'E()', '取数学常数e', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('RAND', 'null', '取随机数', 'RAND() or RAND(seed integer)', '返回一个0到1范围内的随机数,如果指定种子seed，则会等到一个稳定的随机数序列.', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('RAND_INTEGER', 'null', '取随机数', 'RAND_INTEGER(bound integer) or RAND_INTEGER(seed integer, bound integer) ', '返回0.0(包含)和指定值(不包括)之间的伪随机整数值, 如果指定种子seed，则会等到一个稳定的随机数序列 ', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('LOG', 'null', '计算对数', 'LOG(x numeric) or LOG(base numeric, x numeric)', '未指定base 则以自然数e为底', @math, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0);

SET @id1=(SELECT id FROM rdos_stream_resource WHERE resource_name='timeToSecondUdf' AND is_system=1 LIMIT 1);
SET @id2=(SELECT id FROM rdos_stream_resource WHERE resource_name='timeToMilliSecondUdf' AND is_system=1 LIMIT 1);
set @date=(select id from rdos_stream_catalogue where node_name='日期函数');
INSERT INTO `rdos_stream_function`(name,class_name,purpose,command_format,param_desc,node_pid,tenant_id,project_id,create_user_id,modify_user_id, resource_id, udf_type, type,gmt_create,gmt_modified,is_deleted)
VALUES ('EXTRACT', 'null', '提取指定单位的时间数值', 'EXTRACT(timeintervalunit FROM temporal)', '提取部分的时间数值,并返回长整形, 比如 EXTRACT(DAY FROM DATE \'2006-06-05\') 返回 5.', @date, -1, -1, -1, -1, -1,  0, 1, now(), now(), 0),
('QUARTER', 'null', '计算季节', 'QUARTER(date)', '返回当前时间属性哪个季度 如QUARTER(DATE \'1994-09-27\') 返回 3', @date, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('DATE_FORMAT', 'null', '时间格式化', 'DATE_FORMAT(timestamp, format)', '根据指定format 格式化timestamp 并返回字符串, format 必须和mysql的格式化语法兼容(date_parse), 比如:DATE_FORMAT(ts, \'%Y, %d %M\') results in strings formatted as \'2017, 05 May\'', @date, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('TIMESTAMPADD', 'null', '时间加减操作', 'TIMESTAMPADD(unit, interval, timestamp)', '将(有符号)整数interval添加到timestamp. interval的单位由unit参数给出, 它应该是以下值之一：SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, or YEAR. 比如：TIMESTAMPADD(WEEK, 1, \'2003-01-02\') 返回 2003-01-09', @date, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0);


set @char=(select id from rdos_stream_catalogue where node_name='字符函数');
INSERT INTO `rdos_stream_function`(name,class_name,purpose,command_format,param_desc,node_pid,tenant_id,project_id,create_user_id,modify_user_id, resource_id, udf_type, type, gmt_create,gmt_modified,is_deleted)
VALUES ('CHAR_LENGTH', 'null', '计算字符串长度', 'CHAR_LENGTH(string)', '返回字符串的长度', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('CHARACTER_LENGTH', 'null', '计算字符串长度', 'CHARACTER_LENGTH(string)', '返回字符串的长度', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('UPPER', 'null', '将字符串的字母转换成大写字母', 'UPPER(string)', '将字符串的字母转换成大写字母', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('LOWER', 'null', '将字符串的字母转换成小写字母', 'LOWER(string)', '将字符串的字母转换成小写字母', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('POSITION', 'null', '返回string2中第一次出现string1的位置', 'POSITION(string1 IN string2)', '返回string2中第一次出现string1的位置', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('TRIM', 'null', '删除指定字符', 'TRIM( { BOTH | LEADING | TRAILING } string1 FROM string2)', '从string2 中删除指定位置的String1, 默认是删除前后的空格', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('OVERLAY', 'null', '替换字符串', 'OVERLAY(string1 PLACING string2 FROM integer [ FOR integer2 ])', '用string2替换string1的子字符串', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('SUBSTRING', 'null', '截取字符串', 'SUBSTRING(string FROM integer) or SUBSTRING(string FROM integer FOR integer)', '截取字符串中start位置之后的字符串并返回 截取字符串中start位置之后的长度为length的字符串', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('INITCAP', 'null', '字符串中的单词首字母大写', 'INITCAP(string)', '返回字符串，每个单词的第一个字母大写, 所有其他字母以小写形式显示. 单词由空格分割.', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('CONCAT', 'null', '字符串和字节拼接', 'CONCAT(string1, string2,...)', '将字符串或字节拼接，如：concat(\'foo\', \'bar\') = \'foobar\', 函数可以拼接任意数量的字符串或字节。', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('CONCAT_WS', 'null', '使用指定的分隔符拼接字符串', 'CONCAT_WS(separator, string1, string2,...)', '使用指定的分隔符拼接字符串', @char, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0);

set @merge=(select id from rdos_stream_catalogue where node_name='聚合函数');
INSERT INTO `rdos_stream_function`(name,class_name,purpose,command_format,param_desc,node_pid,tenant_id,project_id,create_user_id,modify_user_id, resource_id, udf_type, type,gmt_create,gmt_modified,is_deleted)
VALUES ('COUNT', 'null', '统计总行数', 'COUNT(*) or COUNT(value [, value]* )', '统计总行数，包括含有NULL值的行, 统计提供非NULL的expr表达式值的行数.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('AVG', 'null', '求指定列的平均值', 'AVG(numeric)', '求指定列的平均值.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('SUM', 'null', '求指定列的和', 'SUM(numeric)', '求指定列的和.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('MAX', 'null', '求指定列的最大值', 'MAX(value)', '求指定列的最大值.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('MIN', 'null', '求指定列的最小值', 'MIN(value)', '求指定列的最小值.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('STDDEV_POP', 'null', '求指定列数值的标准偏差', 'STDDEV_POP(value)', '求指定列数值的标准偏差.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('STDDEV_SAMP', 'null', '求指定列数值的样本标准偏差', 'STDDEV_SAMP(value)', '求指定列数值的样本标准偏差.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('VAR_POP', 'null', '求指定列数值的方差', 'VAR_POP(value)', '求指定列数值的方差.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('VAR_SAMP', 'null', '求指定列数值的样本方差', 'VAR_POP(value)', '求指定列数值的样本方差.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('COLLECT', 'null', '返回包含值的multiset', 'COLLECT(value)', '返回包含值的multiset. null将被忽略.如果仅添加null,则返回一个空multiset.', @merge, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0);

set @other=(select id from rdos_stream_catalogue where node_name='其它函数');
INSERT INTO `rdos_stream_function`(name,class_name,purpose,command_format,param_desc,node_pid,tenant_id,project_id,create_user_id,modify_user_id, resource_id, udf_type, type,gmt_create,gmt_modified,is_deleted)
VALUES ('NULLIF', 'null', '如果值相同着返回null', 'NULLIF(value, value)', '如果值相同着返回null, 比如 NULLIF(5, 5) 返回 NULL; NULLIF(5, 0) 返回 5.', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('COALESCE', 'null', '返回第一非null的值', 'COALESCE(value, value [, value ]* )', '返回第一非null的值, 比如: COALESCE(NULL, 5) 返回 5.', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('CAST', 'null', '类型转换', 'CAST(value AS type)', '将value 转换为指定type', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('GROUP_ID', 'null', '返回一个唯一标识分组键的整数', 'GROUP_ID()', '返回一个唯一标识分组键的整数.', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('GROUPING', 'null', '如果表达式在当前行的分组集合中返回1, 否则返回0', 'GROUPING(expression)', '如果表达式在当前行的分组集合中返回1, 否则返回0.', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0),
('GROUPING_ID', 'null', '返回给定分组表达式的位向量', 'GROUPING_ID(expression [, expression]* )', '返回给定分组表达式的位向量.', @other, -1, -1, -1, -1, -1, 0, 1, now(), now(), 0);

commit;
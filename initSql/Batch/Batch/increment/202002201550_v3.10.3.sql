-- 数据字典增加 TiDB SQL函数
INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES ('6', 'TiDBSQLFunction', '4', 'TiDB SQL', 'TiDBSQLFunction', '5', now(), now(), '0');

-- 插入 TiDB 系统函数目录
-- 系统函数
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, '系统函数', -3, 3, 1, 4, now(), now(), -1, 0);

-- 插入系统函数的子节点 操作符、控制流程函数、字符串函数、数学函数、日期与时间函数、位函数与操作符、cast函数与操作符、加密与压缩函数、信息函数、JSON函数、group by聚合函数、窗口函数、其他函数
set @system_tidb_function_id=(select id from rdos_batch_catalogue where node_pid = -3 and engine_type = 4 limit 1);
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, '操作符', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '控制流程函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '字符串函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '数学函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '日期与时间函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '位函数与操作符', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, 'cast函数与操作符', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '加密与压缩函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '信息函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, 'JSON函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, 'group by聚合函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '窗口函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0),
(-1, -1, '其他函数', @system_tidb_function_id, null, 2, 4, now(), now(), -1, 0);

-- 插入函数管理下的TiDB SQL目录
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
SELECT tenant_id, id as project_id, 'TiDB SQL',
    IFNULL((select id from rdos_batch_catalogue where node_name = '函数管理' and project_id = rdos_project.id), -1) as node_pid,
    1, 4, now(), now(), -1, 0
FROM rdos_project where is_deleted = 0 and status = 1;

-- 插入TiDB SQL目录下的系统函数
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
select tenant_id, project_id, '系统函数', id, 1, engine_type, now(), now(), create_user_id, 0
from rdos_batch_catalogue
where node_name = 'TiDB SQL';

-- 插入系统函数
set @operate_id=(select id from rdos_batch_catalogue where node_name='操作符' AND engine_type = 4 AND is_deleted = 0);
set @control_id=(select id from rdos_batch_catalogue where node_name='控制流程函数' AND engine_type = 4 AND is_deleted = 0);
set @string_id=(select id from rdos_batch_catalogue where node_name='字符串函数' AND engine_type = 4 AND is_deleted = 0);
set @number_id=(select id from rdos_batch_catalogue where node_name='数学函数' AND engine_type = 4 AND is_deleted = 0);
set @date_id=(select id from rdos_batch_catalogue where node_name='日期与时间函数' AND engine_type = 4 AND is_deleted = 0);
set @bit_id=(select id from rdos_batch_catalogue where node_name='位函数与操作符' AND engine_type = 4 AND is_deleted = 0);
set @cast_id=(select id from rdos_batch_catalogue where node_name='cast函数与操作符' AND engine_type = 4 AND is_deleted = 0);
set @encode_id=(select id from rdos_batch_catalogue where node_name='加密与压缩函数' AND engine_type = 4 AND is_deleted = 0);
set @info_id=(select id from rdos_batch_catalogue where node_name='信息函数' AND engine_type = 4 AND is_deleted = 0);
set @json_id=(select id from rdos_batch_catalogue where node_name='JSON函数' AND engine_type = 4 AND is_deleted = 0);
set @group_id=(select id from rdos_batch_catalogue where node_name='group by聚合函数' AND engine_type = 4 AND is_deleted = 0);
set @window_id=(select id from rdos_batch_catalogue where node_name='窗口函数' AND engine_type = 4 AND is_deleted = 0);
set @other_id=(select id from rdos_batch_catalogue where node_name='其他函数' AND engine_type = 4 AND is_deleted = 0);

-- 操作符
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('AND', '', '逻辑与', 'AND', 'AND', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('&&', '', '逻辑与', '&&', '&&', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('=', '', '赋值 (可用于 SET 语句中, 或用于 UPDATE 语句的 SET 中 )', '=', '=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
(':=', '', '赋值', ':=', ':=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('BETWEEN ... AND ...', '', '判断值满足范围', 'BETWEEN ... AND ...', 'BETWEEN ... AND ...', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('BINARY', '', '将一个字符串转换为一个二进制字符串', 'BINARY', 'BINARY', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('&', '', '位与', '&', '&', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('~', '', '位非', '~', '~', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('|', '', '位或', '|', '|', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('^', '', '按位异或', '^', '^', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CASE', '', 'case 操作符', 'CASE', 'CASE', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DIV', '', '整数除', 'DIV', 'DIV', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('/', '', '除法', '/', '/', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('=', '', '相等比较', '=', '=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('<=>', '', '空值安全型相等比较', '<=>', '<=>', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('>', '', '大于', '>', '>', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('>=', '', '大于或等于', '>=', '>=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS', '', '判断一个值是否等于一个布尔值', 'IS', 'IS', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS NOT', '', '判断一个值是否不等于一个布尔值', 'IS NOT', 'IS NOT', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS NOT NULL', '', '非空判断', 'IS NOT NULL', 'IS NOT NULL', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS NULL', '', '空值判断', 'IS NULL', 'IS NULL', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('<<', '', '左移', '<<', '<<', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('<', '', '小于', '<', '<', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('<=', '', '小于或等于', '<=', '<=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LIKE', '', '简单模式匹配', 'LIKE', 'LIKE', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('-', '', '减', '-', '-', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('%', '', '求余', '%', '%', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MOD', '', '求余', 'MOD', 'MOD', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT, !', '', '取反', 'NOT', 'NOT', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT BETWEEN ... AND ...', '', '判断值是否不在范围内', 'NOT BETWEEN ... AND ...', 'NOT BETWEEN ... AND ...', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('!=', '', '不等于', '!=', '!=', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('<>', '', '不等于', '<>', '<>', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT LIKE', '', '不符合简单模式匹配', 'NOT LIKE', 'NOT LIKE', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT REGEXP', '', '不符合正则表达式模式匹配', 'NOT REGEXP', 'NOT REGEXP', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('||', '', '逻辑或', '||', '||', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('OR', '', '逻辑或', 'OR', 'OR', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('+', '', '加', '+', '+', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('REGEXP', '', '使用正则表达式进行模式匹配', 'REGEXP', 'REGEXP', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('>>', '', '右移', '>>', '>>', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RLIKE', '', 'REGEXP 同义词', 'RLIKE', 'RLIKE', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('!', '', 'REGEXP 同义词', '!', '!', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('*', '', '乘', '*', '*', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('-', '', '取反符号', '-', '-', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('XOR, !', '', '逻辑亦或', 'XOR', 'XOR', @operate_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 控制流程函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('CASE', '', 'Case 操作符', 'CASE()', 'CASE()', @control_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IF', '', '构建 if/else', 'IF()', 'IF()', @control_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IFNULL', '', '构建 Null if/else', 'IFNULL()', 'IFNULL()', @control_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NULLIF', '', '如果 expr1 = expr2，返回 NULL', 'NULLIF()', 'NULLIF()', @control_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 字符串函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('ASCII', '', '返回最左字符的数值', 'ASCII()', 'ASCII()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('BIN', '', '返回一个数的二进制值的字符串表示', 'BIN()', 'BIN()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('BIT_LENGTH', '', '返回字符串的位长度', 'BIT_LENGTH()', 'BIT_LENGTH()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CHAR', '', '返回由整数的代码值所给出的字符组成的字符串', 'CHAR()', 'CHAR()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CHAR_LENGTH', '', '返回字符串的字符长度', 'CHAR_LENGTH()', 'CHAR_LENGTH()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CHARACTER_LENGTH', '', '与 CHAR_LENGTH() 功能相同', 'CHARACTER_LENGTH()', 'CHARACTER_LENGTH()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONCAT', '', '返回连接的字符串', 'CONCAT()', 'CONCAT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONCAT_WS', '', '返回由分隔符连接的字符串', 'CONCAT_WS()', 'CONCAT_WS()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ELT', '', '返回指定位置的字符串', 'ELT()', 'ELT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('EXPORT_SET', '', '返回一个字符串，其中值位中设置的每个位，可以得到一个 on 字符串，而每个未设置的位，可以得到一个 off 字符串', 'EXPORT_SET()', 'EXPORT_SET()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FIELD', '', '返回参数在后续参数中出现的第一个位置', 'FIELD()', 'FIELD()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FIND_IN_SET', '', '返回第一个参数在第二个参数中出现的位置', 'FIND_IN_SET()', 'FIND_IN_SET()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FORMAT', '', '返回指定小数位数格式的数字', 'FORMAT()', 'FORMAT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FROM_BASE64', '', '解码 base-64 表示的字符串，并返回结果', 'FROM_BASE64()', 'FROM_BASE64()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('HEX', '', '返回一个十进制数或字符串值的 16 进制表示', 'HEX()', 'HEX()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INSERT', '', '在指定位置插入一个子字符串，最多不超过指定字符数', 'INSERT()', 'INSERT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INSTR', '', '返回第一次出现的子字符串的索引', 'INSTR()', 'INSTR()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LCASE', '', '与 LOWER() 功能相同', 'LCASE()', 'LCASE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LEFT', '', '返回最左侧指定长度的字符', 'LEFT()', 'LEFT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LENGTH', '', '返回字符串长度，单位为字节', 'LENGTH()', 'LENGTH()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LIKE', '', '进行简单模式匹配', 'LIKE', 'LIKE', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOCATE', '', '返回第一次出现的子字符串的位置', 'LOCATE()', 'LOCATE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOWER', '', '返回全小写的参数', 'LOWER()', 'LOWER()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LPAD', '', '返回字符串参数，左侧添加指定字符串', 'LPAD()', 'LPAD()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LTRIM', '', '去掉前缀空格', 'LTRIM()', 'LTRIM()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MAKE_SET', '', '返回一组用逗号分隔的字符串，这些字符串的位数与给定的 bits 参数对应', 'MAKE_SET()', 'MAKE_SET()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MID', '', '返回一个以指定位置开始的子字符串', 'MID()', 'MID()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT LIKE', '', '否定简单模式匹配', 'NOT LIKE', 'NOT LIKE', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOT REGEXP', '', 'REGEXP 的否定形式', 'NOT REGEXP', 'NOT REGEXP', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('OCT', '', '返回一个数值的八进制表示，形式为字符串', 'OCT()', 'OCT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('OCTET_LENGTH', '', '与 LENGTH() 功能相同', 'OCTET_LENGTH()', 'OCTET_LENGTH()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ORD', '', '返回该参数最左侧字符的字符编码', 'ORD()', 'ORD()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('POSITION', '', '与 LOCATE() 功能相同', 'POSITION()', 'POSITION()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('QUOTE', '', '使参数逃逸，为了在 SQL 语句中使用', 'QUOTE()', 'QUOTE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('REGEXP', '', '使用正则表达式匹配模式', 'REGEXP', 'REGEXP', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('REPEAT', '', '以指定次数重复一个字符串', 'REPEAT()', 'REPEAT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('REPLACE', '', '替换所有出现的指定字符串', 'REPLACE()', 'REPLACE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('REVERSE', '', '反转字符串里的所有字符', 'REVERSE()', 'REVERSE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RIGHT', '', '返回指定数量的最右侧的字符', 'RIGHT()', 'RIGHT()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RLIKE', '', '与 REGEXP 功能相同', 'RLIKE', 'RLIKE', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RPAD', '', '以指定次数添加字符串', 'RPAD()', 'RPAD()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RTRIM', '', '去掉后缀空格', 'RTRIM()', 'RTRIM()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SPACE', '', '返回指定数量的空格，形式为字符串', 'SPACE()', 'SPACE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('STRCMP', '', '比较两个字符串', 'STRCMP()', 'STRCMP()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUBSTR', '', '返回指定的子字符串', 'SUBSTR()', 'SUBSTR()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUBSTRING', '', '返回指定的子字符串', 'SUBSTRING()', 'SUBSTRING()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUBSTRING_INDEX', '', '从一个字符串中返回指定出现次数的定界符之前的子字符串', 'SUBSTRING_INDEX()', 'SUBSTRING_INDEX()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TO_BASE64', '', '返回转化为 base-64 表示的字符串参数', 'TO_BASE64()', 'TO_BASE64()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TRIM', '', '去掉前缀和后缀空格', 'TRIM()', 'TRIM()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UCASE', '', '与 UPPER() 功能相同', 'UCASE()', 'UCASE()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UNHEX', '', '返回一个数的十六进制表示，形式为字符串', 'UNHEX()', 'UNHEX()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UPPER', '', '参数转换为大写形式', 'UPPER()', 'UPPER()', @string_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 数学函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('POW', '', '返回参数的指定乘方的结果值', 'POW()', 'POW()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('POWER', '', '返回参数的指定乘方的结果值', 'POWER()', 'POWER()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('EXP', '', '返回 e（自然对数的底）的指定乘方后的值', 'EXP()', 'EXP()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SQRT', '', '返回非负数的二次方根', 'SQRT()', 'SQRT()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LN', '', '返回参数的自然对数', 'LN()', 'LN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOG', '', '返回第一个参数的自然对数', 'LOG()', 'LOG()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOG2', '', '返回参数以 2 为底的对数', 'LOG2()', 'LOG2()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOG10', '', '返回参数以 10 为底的对数', 'LOG10()', 'LOG10()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('PI', '', '返回 pi 的值', 'PI()', 'PI()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TAN', '', '返回参数的正切值', 'TAN()', 'TAN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('COT', '', '返回参数的余切值', 'COT()', 'COT()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SIN', '', '返回参数的正弦值', 'SIN()', 'SIN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('COS', '', '返回参数的余弦值', 'COS()', 'COS()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ATAN', '', '返回参数的反正切值', 'ATAN()', 'ATAN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ATAN2', '', '返回两个参数的反正切值', 'ATAN2()', 'ATAN2()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASIN', '', '返回参数的反正弦值', 'ASIN()', 'ASIN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ACOS', '', '返回参数的反余弦值', 'ACOS()', 'ACOS()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RADIANS', '', '返回由度转化为弧度的参数', 'RADIANS()', 'RADIANS()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DEGREES', '', '返回由弧度转化为度的参数', 'DEGREES()', 'DEGREES()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MOD', '', '返回余数', 'MOD()', 'MOD()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ABS', '', '返回参数的绝对值', 'ABS()', 'ABS()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CEIL', '', '返回不小于参数的最小整数值', 'CEIL()', 'CEIL()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CEILING', '', '返回不小于参数的最小整数值', 'CEILING()', 'CEILING()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FLOOR', '', '返回不大于参数的最大整数值', 'FLOOR()', 'FLOOR()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ROUND', '', '返回参数最近似的整数或指定小数位数的数值', 'ROUND()', 'ROUND()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RAND', '', '返回一个随机浮点值', 'RAND()', 'RAND()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SIGN', '', '返回参数的符号', 'SIGN()', 'SIGN()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONV', '', '不同数基间转换数字，返回数字的字符串表示', 'CONV()', 'CONV()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TRUNCATE', '', '返回被舍位至指定小数位数的数字', 'TRUNCATE()', 'TRUNCATE()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CRC32', '', '计算循环冗余码校验值并返回一个 32 位无符号值', 'CRC32()', 'CRC32()', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 日期与时间函数 date_id
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('ADDDATE', '', '将时间间隔添加到日期上', 'ADDDATE()', 'ADDDATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ADDTIME', '', '时间数值相加', 'ADDTIME()', 'ADDTIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONVERT_TZ', '', '转换时区', 'CONVERT_TZ()', 'CONVERT_TZ()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURDATE', '', '返回当前日期', 'CURDATE()', 'CURDATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_DATE', '', '与 CURDATE() 同义', 'CURRENT_DATE()', 'CURRENT_DATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_DATE', '', '与 CURDATE() 同义', 'CURRENT_DATE', 'CURRENT_DATE', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_TIME', '', '与 CURTIME() 同义', 'CURRENT_TIME()', 'CURRENT_TIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_TIME', '', '与 CURTIME() 同义', 'CURRENT_TIME', 'CURRENT_TIME', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_TIMESTAMP', '', '与 NOW() 同义', 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_TIMESTAMP', '', '与 NOW() 同义', 'CURRENT_TIMESTAMP()', 'CURRENT_TIMESTAMP()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURTIME', '', '返回当前时间', 'CURTIME()', 'CURTIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATE', '', '从日期或日期/时间表达式中提取日期部分', 'DATE()', 'DATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATE_ADD', '', '将时间间隔添加到日期上', 'DATE_ADD()', 'DATE_ADD()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATE_FORMAT', '', '返回满足指定格式的日期/时间', 'DATE_FORMAT()', 'DATE_FORMAT()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATE_SUB', '', '从日期减去指定的时间间隔', 'DATE_SUB()', 'DATE_SUB()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATEDIFF', '', '返回两个日期间隔的天数', 'DATEDIFF()', 'DATEDIFF()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DAY', '', '与 DAYOFMONTH() 同义', 'DAY()', 'DAY()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DAYNAME', '', '返回星期名称', 'DAYNAME()', 'DAYNAME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DAYOFMONTH', '', '返回参数对应的天数部分(1-31)', 'DAYOFMONTH()', 'DAYOFMONTH()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DAYOFWEEK', '', '返回参数对应的星期下标', 'DAYOFWEEK()', 'DAYOFWEEK()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DAYOFYEAR', '', '返回参数代表一年的哪一天 (1-366)', 'DAYOFYEAR()', 'DAYOFYEAR()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('EXTRACT', '', '提取日期/时间中的单独部分', 'EXTRACT()', 'EXTRACT()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FROM_DAYS', '', '将天数转化为日期', 'FROM_DAYS()', 'FROM_DAYS()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FROM_UNIXTIME', '', '将 Unix 时间戳格式化为日期', 'FROM_UNIXTIME()', 'FROM_UNIXTIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('GET_FORMAT', '', '返回满足日期格式的字符串', 'GET_FORMAT()', 'GET_FORMAT()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('HOUR', '', '提取日期/时间表达式中的小时部分', 'HOUR()', 'HOUR()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LAST_DAY', '', '返回参数中月份的最后一天', 'LAST_DAY()', 'LAST_DAY()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOCALTIME', '', '与 NOW() 同义', 'LOCALTIME', 'LOCALTIME', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOCALTIME', '', '与 NOW() 同义', 'LOCALTIME()', 'LOCALTIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOCALTIMESTAMP', '', '与 NOW() 同义', 'LOCALTIMESTAMP()', 'LOCALTIMESTAMP()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LOCALTIMESTAMP', '', '与 NOW() 同义', 'LOCALTIMESTAMP', 'LOCALTIMESTAMP', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MAKEDATE', '', '根据给定的年份和一年中的天数生成一个日期', 'MAKEDATE()', 'MAKEDATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MAKETIME', '', '根据给定的时、分、秒生成一个时间', 'MAKETIME()', 'MAKETIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MICROSECOND', '', '返回参数的微秒部分', 'MICROSECOND()', 'MICROSECOND()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MINUTE', '', '返回参数的分钟部分', 'MINUTE()', 'MINUTE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MONTH', '', '返回参数的月份部分', 'MONTH', 'MONTH', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MONTHNAME', '', '返回参数的月份名称', 'MONTHNAME()', 'MONTHNAME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NOW', '', '返回当前日期和时间', 'NOW()', 'NOW()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('PERIOD_ADD', '', '在年-月表达式上添加一段时间(数个月)', 'PERIOD_ADD()', 'PERIOD_ADD()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('PERIOD_DIFF', '', '返回间隔的月数', 'PERIOD_DIFF()', 'PERIOD_DIFF()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('QUARTER', '', '返回参数对应的季度(1-4)', 'QUARTER()', 'QUARTER()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SEC_TO_TIME', '', '将秒数转化为 ‘HH:MM:SS’ 的格式', 'SEC_TO_TIME()', 'SEC_TO_TIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SECOND', '', '返回秒数(0-59)', 'SECOND', 'SECOND', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('STR_TO_DATE', '', '将字符串转化为日期', 'STR_TO_DATE', 'STR_TO_DATE', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUBDATE', '', '当传入三个参数时作为 DATE_SUB() 的同义', 'SUBDATE()', 'SUBDATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUBTIME', '', '从一个时间中减去一段时间', 'SUBTIME()', 'SUBTIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SYSDATE', '', '返回该方法执行时的时间', 'SYSDATE()', 'SYSDATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIME', '', '返回参数的时间表达式部分', 'TIME()', 'TIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIME_FORMAT', '', '格式化时间', 'TIME_FORMAT()', 'TIME_FORMAT()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIME_TO_SEC', '', '返回参数对应的秒数', 'TIME_TO_SEC()', 'TIME_TO_SEC()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIMEDIFF', '', '返回时间间隔', 'TIMEDIFF()', 'TIMEDIFF()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIMESTAMP', '', '传入一个参数时候,该方法返回日期或日期/时间表达式, 传入两个参数时候, 返回参数的和', 'TIMESTAMP', 'TIMESTAMP', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIMESTAMPADD', '', '在日期/时间表达式上增加一段时间间隔', 'TIMESTAMPADD()', 'TIMESTAMPADD()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIMESTAMPDIFF', '', '从日期/时间表达式中减去一段时间间隔', 'TIMESTAMPDIFF()', 'TIMESTAMPDIFF()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TO_DAYS', '', '将参数转化对应的天数(从第 0 年开始)', 'TO_DAYS()', 'TO_DAYS()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TO_SECONDS', '', '将日期或日期/时间参数转化为秒数(从第 0 年开始)', 'TO_SECONDS()', 'TO_SECONDS()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UNIX_TIMESTAMP', '', '返回一个 Unix 时间戳', 'UNIX_TIMESTAMP()', 'UNIX_TIMESTAMP()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UTC_DATE', '', '返回当前的 UTC 日期', 'UTC_DATE()', 'UTC_DATE()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UTC_TIME', '', '返回当前的 UTC 时间', 'UTC_TIME()', 'UTC_TIME()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UTC_TIMESTAMP', '', '返回当前的 UTC 日期和时间', 'UTC_TIMESTAMP()', 'UTC_TIMESTAMP()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('WEEK', '', '返回参数所在的一年中的星期数', 'WEEK()', 'WEEK()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('WEEKDAY', '', '返回星期下标', 'WEEKDAY()', 'WEEKDAY()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('WEEKOFYEAR', '', '返回参数在日历中对应的一年中的星期数', 'WEEKOFYEAR()', 'WEEKOFYEAR()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('YEAR', '', '返回参数对应的年数', 'YEAR()', 'YEAR()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('YEARWEEK', '', '返回年数和星期数', 'YEARWEEK()', 'YEARWEEK()', @date_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 位函数与操作符
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('BIT_COUNT', '', '返回参数二进制表示中为 1 的个数', 'BIT_COUNT()', 'BIT_COUNT()', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('&', '', '位与', '&', '&', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('~', '', '按位取反', '~', '~', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('|', '', '位或', '|', '|', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('^', '', '位亦或', '^', '^', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('«', '', '左移', '«', '«', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('»', '', '右移', '»', '»', @bit_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- cast函数与操作符
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
 VALUES
('BINARY', '', '将一个字符串转换成一个二进制字符串', 'BINARY', 'BINARY', @cast_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CAST', '', '将一个值转换成一个确定类型', 'CAST()', 'CAST()', @cast_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONVERT', '', '将一个值转换成一个确定类型', 'CONVERT()', 'CONVERT()', @cast_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 加密与压缩函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('MD5', '', '计算字符串的 MD5 校验和', 'MD5()', 'MD5()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('PASSWORD', '', '计算并返回密码字符串', 'PASSWORD()', 'PASSWORD()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RANDOM_BYTES', '', '返回随机字节向量', 'RANDOM_BYTES()', 'RANDOM_BYTES()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SHA', '', '计算 SHA-1 160 位校验和', 'SHA()', 'SHA()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SHA1', '', '计算 SHA-1 160 位校验和', 'SHA1()', 'SHA1()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SHA2', '', '计算 SHA-2 校验和', 'SHA2()', 'SHA2()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('AES_DECRYPT', '', '使用 AES 解密', 'AES_DECRYPT()', 'AES_DECRYPT()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('AES_ENCRYPT', '', '使用 AES 加密', 'AES_ENCRYPT()', 'AES_ENCRYPT()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('COMPRESS', '', '返回经过压缩的二进制字符串', 'COMPRESS()', 'COMPRESS()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UNCOMPRESS', '', '解压缩字符串', 'UNCOMPRESS()', 'UNCOMPRESS()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UNCOMPRESSED_LENGTH', '', '返回字符串解压后的长度', 'UNCOMPRESSED_LENGTH()', 'UNCOMPRESSED_LENGTH()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CREATE_ASYMMETRIC_PRIV_KEY', '', '创建私钥', 'CREATE_ASYMMETRIC_PRIV_KEY()', 'CREATE_ASYMMETRIC_PRIV_KEY()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CREATE_ASYMMETRIC_PUB_KEY', '', '创建公钥', 'CREATE_ASYMMETRIC_PUB_KEY()', 'CREATE_ASYMMETRIC_PUB_KEY()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CREATE_DH_PARAMETERS', '', '创建 DH 共享密钥', 'CREATE_DH_PARAMETERS()', 'CREATE_DH_PARAMETERS()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CREATE_DIGEST', '', '从字符串创建摘要', 'CREATE_DIGEST()', 'CREATE_DIGEST()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASYMMETRIC_DECRYPT', '', '使用公钥或私钥解密密文', 'ASYMMETRIC_DECRYPT()', 'ASYMMETRIC_DECRYPT()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASYMMETRIC_DERIVE', '', '从非对称密钥导出对称密钥', 'ASYMMETRIC_DERIVE()', 'ASYMMETRIC_DERIVE()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASYMMETRIC_ENCRYPT', '', '使用公钥或私钥加密明文', 'ASYMMETRIC_ENCRYPT()', 'ASYMMETRIC_ENCRYPT()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASYMMETRIC_SIGN', '', '从摘要创建签名', 'ASYMMETRIC_SIGN()', 'ASYMMETRIC_SIGN()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ASYMMETRIC_VERIFY', '', '验证签名字符串是否匹配摘要字符串', 'ASYMMETRIC_VERIFY()', 'ASYMMETRIC_VERIFY()', @encode_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 信息函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('BENCHMARK', '', '循环执行一个表达式', 'BENCHMARK()', 'BENCHMARK()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CONNECTION_ID', '', '返回当前连接的连接 ID (线程 ID)', 'CONNECTION_ID()', 'CONNECTION_ID()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_USER', '', '返回当前用户的用户名和主机名', 'CURRENT_USER()', 'CURRENT_USER()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('CURRENT_USER', '', '返回当前用户的用户名和主机名', 'CURRENT_USER', 'CURRENT_USER', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DATABASE', '', '返回默认(当前)的数据库名', 'DATABASE()', 'DATABASE()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FOUND_ROWS', '', '该函数返回对于一个包含 LIMIT 的 SELECT 查询语句，在不包含 LIMIT 的情况下回返回的记录数', 'FOUND_ROWS()', 'FOUND_ROWS()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LAST_INSERT_ID', '', '返回最后一条 INSERT 语句中自增列的值', 'LAST_INSERT_ID()', 'LAST_INSERT_ID()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ROW_COUNT', '', '影响的行数', 'ROW_COUNT()', 'ROW_COUNT()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SCHEMA', '', '与 DATABASE() 同义', 'SCHEMA()', 'SCHEMA()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SESSION_USER', '', '与 USER() 同义', 'SESSION_USER()', 'SESSION_USER()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SYSTEM_USER', '', '与 USER() 同义', 'SYSTEM_USER()', 'SYSTEM_USER()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('USER', '', '返回客户端提供的用户名和主机名', 'USER()', 'USER()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('VERSION', '', '返回当前 MySQL 服务器的版本信息', 'VERSION()', 'VERSION()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('TIDB_VERSION', '', '返回当前 TiDB 服务器的版本信息', 'TIDB_VERSION()', 'TIDB_VERSION()', @info_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- JSON函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('JSON_ARRAY', '', '根据一系列元素创建一个 JSON 文档', 'JSON_ARRAY([val[, val] …])', 'JSON_ARRAY()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_OBJECT', '', '根据一系列 K/V 对创建一个 JSON 文档', 'JSON_OBJECT(key, val[, key, val] …)', 'JSON_OBJECT()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_QUOTE', '', '返回一个字符串，该字符串为带引号的 JSON 值', 'JSON_QUOTE(string)', 'JSON_QUOTE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_CONTAINS', '', '通过返回 1 或 0 来表示目标 JSON 文档中是否包含给定的 candidate JSON 文档', 'JSON_CONTAINS(target, candidate[, path])', 'JSON_CONTAINS()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_CONTAINS_PATH', '', '通过返回 0 或 1 来表示一个 JSON 文档在给定路径是否包含数据', 'JSON_CONTAINS_PATH(json_doc, one_or_all, path[, path] …)', 'JSON_CONTAINS_PATH()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_EXTRACT', '', '从 JSON 文档中解出某一路径对应的子文档', 'JSON_EXTRACT(json_doc, path[, path] …)', 'JSON_EXTRACT()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('->', '', '返回执行路径后面的 JSON 列的值；JSON_EXTRACT(doc, path_literal) 的语法糖', '->', '->', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('-»', '', '返回执行路径后面的 JSON 列的值和转义后的结果； JSON_UNQUOTE(JSON_EXTRACT(doc, path_literal)) 的语法糖', '-»', '-»', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_KEYS', '', '返回从 JSON 对象的顶级值作为 JSON array 的键，如果给定了路径参数，则从选定路径中获取顶级键', 'JSON_KEYS(json_doc[, path])', 'JSON_KEYS()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_INSERT', '', '在 JSON 文档中在某一路径下插入子文档', 'JSON_INSERT(json_doc, path, val[, path, val] …)', 'JSON_INSERT()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_MERGE', '', '已废弃的 JSON_MERGE_PRESERVE 别名', 'JSON_MERGE(json_doc, json_doc[, json_doc] …)', 'JSON_MERGE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_MERGE_PRESERVE', '', '将两个或多个 JSON 文档合并成一个文档，并返回合并结果', 'JSON_MERGE_PRESERVE(json_doc, json_doc[, json_doc] …)', 'JSON_MERGE_PRESERVE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_REMOVE', '', '移除 JSON 文档中某一路径下的子文档', 'JSON_REMOVE(json_doc, path[, path] …)', 'JSON_REMOVE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_REPLACE', '', '替换 JSON 文档中的某一路径下的子文档', 'JSON_REPLACE(json_doc, path, val[, path, val] …)', 'JSON_REPLACE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_SET', '', '在 JSON 文档中为某一路径设置子文档', 'JSON_SET(json_doc, path, val[, path, val] …)', 'JSON_SET()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_UNQUOTE', '', '去掉 JSON 值外面的引号，返回结果为字符串', 'JSON_UNQUOTE(json_val)', 'JSON_UNQUOTE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_DEPTH', '', '返回 JSON 文档的最大深度', 'JSON_DEPTH(json_doc)', 'JSON_DEPTH()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_LENGTH', '', '返回 JSON 文档的长度；如果路径参数已定，则返回该路径下值的长度', 'JSON_LENGTH(json_doc[, path])', 'JSON_LENGTH()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('JSON_TYPE', '', '检查某 JSON 文档内部内容的类型', 'JSON_TYPE(json_val)', 'JSON_TYPE()', @json_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- group by聚合函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('COUNT', '', '返回检索到的行的数目', 'COUNT()', 'COUNT()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('COUNT', '', '返回检索到的行的数目', 'COUNT(DISTINCT)', 'COUNT()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SUM', '', '返回和', 'SUM()', 'SUM()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('AVG', '', '返回平均值', 'AVG()', 'AVG()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MAX', '', '返回最大值', 'MAX()', 'MAX()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('MIN', '', '返回最小值', 'MIN()', 'MIN()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('GROUP_CONCAT', '', '返回连接的字符串', 'GROUP_CONCAT()', 'GROUP_CONCAT()', @group_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 窗口函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('CUME_DIST', '', '返回一组值中的累积分布', 'CUME_DIST()', 'CUME_DIST()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DENSE_RANK', '', '返回分区中当前行的排名，并且排名是连续的', 'DENSE_RANK()', 'DENSE_RANK()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('FIRST_VALUE', '', '当前窗口中第一行的表达式值', 'FIRST_VALUE()', 'FIRST_VALUE()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LAG', '', '分区中当前行前面第 N 行的表达式值', 'LAG()', 'LAG()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LAST_VALUE', '', '当前窗口中最后一行的表达式值', 'LAST_VALUE()', 'LAST_VALUE()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('LEAD', '', '分区中当前行后面第 N 行的表达式值', 'LEAD()', 'LEAD()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NTH_VALUE', '', '当前窗口中第 N 行的表达式值', 'NTH_VALUE()', 'NTH_VALUE()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NTILE', '', '将分区划分为 N 桶，为分区中的每一行分配桶号', 'NTILE()', 'NTILE()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('PERCENT_RANK', '', '返回分区中小于当前行的百分比', 'PERCENT_RANK()', 'PERCENT_RANK()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('RANK', '', '返回分区中当前行的排名，排名可能不连续', 'RANK()', 'RANK()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('ROW_NUMBER', '', '返回分区中当前行的编号', 'ROW_NUMBER()', 'ROW_NUMBER()', @window_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

-- 其他函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('ANY_VALUE', '', '在 ONLY_FULL_GROUP_BY 模式下，防止带有 GROUP BY 的语句报错', 'ANY_VALUE()', 'ANY_VALUE()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('DEFAULT', '', '返回表的某一列的默认值', 'DEFAULT()', 'DEFAULT()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INET_ATON', '', '将 IP 地址转换为数值', 'INET_ATON()', 'INET_ATON()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INET_NTOA', '', '将数值转换为 IP 地址', 'INET_NTOA()', 'INET_NTOA()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INET6_ATON', '', '将 IPv6 地址转换为数值', 'INET6_ATON()', 'INET6_ATON()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('INET6_NTOA', '', '将数值转换为 IPv6 地址', 'INET6_NTOA()', 'INET6_NTOA()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS_IPV4', '', '判断参数是否为 IPv4 地址', 'IS_IPV4()', 'IS_IPV4()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS_IPV4_COMPAT', '', '判断参数是否为兼容 IPv4 的地址', 'IS_IPV4_COMPAT()', 'IS_IPV4_COMPAT()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS_IPV4_MAPPED', '', '判断参数是否为 IPv4 映射的地址', 'IS_IPV4_MAPPED()', 'IS_IPV4_MAPPED()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('IS_IPV6', '', '判断参数是否为 IPv6 地址', 'IS_IPV6()', 'IS_IPV6()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('NAME_CONST', '', '可以用于重命名列名', 'NAME_CONST()', 'NAME_CONST()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('SLEEP', '', '让语句暂停执行几秒时间', 'SLEEP()', 'SLEEP()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('UUID', '', '返回一个通用唯一识别码 (UUID)', 'UUID()', 'UUID()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('VALUES', '', '定义 INSERT 语句使用的值', 'VALUES()', 'VALUES()', @other_id, -1, -1, -1, -1, 1, 4, now(), now(), 0);

commit;
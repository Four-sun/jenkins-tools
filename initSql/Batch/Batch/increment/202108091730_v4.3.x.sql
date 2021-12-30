-- 目录表新增字段type，当前目录表的engine_type不能区分是sparkSql和hiveSql
alter table rdos_batch_catalogue add column engine_catalogue_type int(11) COMMENT '1: sparksql 2:libra 3:kylin 4:tidb 5:oracle 6:greenplum 7:presto 9:adb 100:hivesql';
update rdos_batch_catalogue set engine_catalogue_type = engine_type;

-- 插入hive函数
INSERT INTO rdos_dict (type, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified, is_deleted)
VALUES (6, 'HiveSQLFunction', 4, 'Hive SQL', 'HiveSQLFunction', 4, now(), now(), 0);

-- 新增函数类型字段
ALTER TABLE rdos_batch_function ADD COLUMN function_type int(11) COMMENT '函数类型，1:spark, 2:libra, 4:tidb, 5:oracle, 6:greenplum, 7:hive';
-- 刷历史数据函数类型字段
update rdos_batch_function set function_type = engine_type;

-- 插入系统函数目录
-- 系统函数
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted, engine_catalogue_type)
VALUES
(-1, -1, '系统函数', -6, 6, 1, 1, now(), now(), -1, 0, 100);
-- hive系统函数目录id
set @hiveSystemId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '系统函数' and node_pid = -6 and engine_type = 1 limit 1);
-- 插入hive系统函数一级目录
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '数学函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '集合函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '日期函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '其它函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '字符函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '聚合函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);
INSERT INTO `rdos_batch_catalogue` (tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, engine_catalogue_type, is_deleted) VALUES (-1, -1, '表生成函数', @hiveSystemId, NULL, 2, 1, now(), now(), -1, 100, 0);

-- 数学函数目录id
set @hiveSystemMathId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '数学函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 集合函数目录ID
set @hiveSystemListId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '集合函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 日期函数目录ID
set @hiveSystemDateId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '日期函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 其他函数目录ID
set @hiveSystemOtherId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '其它函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 字符函数目录ID
set @hiveSystemCharaId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '字符函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 聚合函数目录ID
set @hiveSystemGroupId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '聚合函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);
-- 表生成函数目录ID
set @hiveSystemTableId = (select id from rdos_batch_catalogue where tenant_id = -1 and project_id = -1 and node_name = '表生成函数' and node_pid = @hiveSystemId and engine_type = 1 limit 1);

-- 插入系统函数
INSERT INTO `rdos_batch_function`
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted, function_type)
VALUES
('round', '', '取近似值', 'double  round(double a)  double  round(double a, int d)', 'round(double a)：返回对a四舍五入的bigint值  round(double a, int d)：返回double型a的保留d位小数的double型的近似值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('bround', '', '银行家舍入法', 'double  bround(double a)  double  bround(double a, int d)', 'bround(double a)：1~4：舍，6~9：进，5->前位数是偶：舍，5->前位数是奇：进  bround(double a, int d)：保留d位小数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('floor', '', '向下取整', 'bigint  floor(double a)', '，在数轴上最接近要求的值的左边的值 ?如：6.10->6 ? -3.4->-4', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('ceil', '', '取整', 'bigint  ceil(double a)', '求其不小于小给定实数的最小整数如：ceil(6) = ceil(6.1)= ceil(6.9) = 6', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('rand', '', '取随机数', 'double  rand()  double  rand(int seed)', '返回一个0到1范围内的随机数。如果指定种子seed，则会等到一个稳定的随机数序列', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('exp', '', '计算自然指数的指数', 'double  exp(double a)  double  exp(decimal a)', '返回自然对数e的a幂次方， a可为小数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('ln', '', '计算自然数的对数', 'double  ln(double a)  double  ln(decimal a)', '以自然数为底d的对数，a可为小数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('log10', '', '计算10为底的对数', 'double  log10(double a)  double  log10(decimal a)', '计算以10为底d的对数，a可为小数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('log2', '', '计算2为底数的对数', 'double  log2(double a)  double  log2(decimal a)', '以2为底数d的对数，a可为小数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('log', '', '计算对数', 'double  log(double base, double a)  double  log(decimal base, decimal a)', '以base为底的对数，base 与 a都是double类型', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('pow', '', '计算次幂', 'double  pow(double a, double p)', '计算a的p次幂', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sqrt', '', '计算平方根', 'double  sqrt(double a)  double  sqrt(decimal a)', '计算a的平方根', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('bin', '', '计算二进制a的string类型，a为bigint类型', 'string  bin(bigint a)', '计算二进制a的string类型，a为bigint类型', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('hex', '', '计算十六进制的string类型', 'string  hex(bigint a)   string  hex(string a)   string  hex(binary a)', '计算十六进制a的string类型，如果a为string类型就转换成字符相对应的十六进制', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('unhex', '', 'hex的逆方法', 'binary  unhex(string a)', 'hex的逆方法', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('conv', '', '进制转换', 'string  conv(bigint num, int from_base, int to_base)  string  conv(string num, int from_base, int to_base)', '将bigint/string类型的num从from_base进制转换成to_base进制', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('abs', '', '计算a的绝对值', 'double  abs(double a)', '计算a的绝对值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('pmod', '', 'a对b取模', 'int  pmod(int a, int b),   double  pmod(double a, double b)', 'a对b取模', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sin', '', '计算正弦值', 'double  sin(double a)  double  sin(decimal a)', '计算正弦值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('asin', '', '计算反正弦值', 'double  asin(double a)  double  asin(decimal a)', '计算反正弦值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('cos', '', '计算余弦值', 'double  cos(double a)  double  cos(decimal a)', '计算余弦值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('acos', '', '计算反余弦值', 'double  acos(double a)  double  acos(decimal a)', '计算反余弦值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('tan', '', '计算正切值', 'double  tan(double a)  double  tan(decimal a)', '计算正切值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('atan', '', '计算反正切值', 'double  atan(double a)  double  atan(decimal a)', '计算反正切值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('degrees', '', '弧度值转换角度值', 'double  degrees(double a)  double  degrees(decimal a)', '弧度值转换角度值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('radians', '', '将角度值转换成弧度值', 'double  radians(double a)  double  radians(double a)', '将角度值转换成弧度值', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('positive', '', '返回a', 'int positive(int a),   double  positive(double a)', '返回a', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('negative', '', '计算相反数', 'int negative(int a),   double  negative(double a)', '返回a的相反数', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sign', '', '计算数字的标志', 'double  sign(double a)  int  sign(decimal a)', 'sign(double a)：如果a是正数则返回1.0，是负数则返回-1.0，否则返回0.0  sign(decimal a)：同上，返回值为整型', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('e', '', '取数学常数e', 'double  e()', '取数学常数e', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('pi', '', '取数学常数pi', 'double  pi()', '取数学常数pi', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('factorial', '', '计算阶乘', 'bigint  factorial(int a)', '求a的阶乘', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('cbrt', '', '计算立方根', 'double  cbrt(double a)', '计算a的立方根', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('shiftleft', '', '按位左移', 'int   shiftleft(TINYint|SMALLint|int a, int b)  bigint  shiftleft(bigint a, int燽)', '按位左移', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('shiftright', '', '按拉右移', 'int  shiftright(TINYint|SMALLint|int a, intb)  bigint  shiftright(bigint a, int燽)', '按拉右移', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('shiftrightunsigned', '', '无符号按位右移（<<<）', 'int  shiftrightunsigned(TINYint|SMALLint|inta, int b)  bigint  shiftrightunsigned(bigint a, int b)', '无符号按位右移（<<<）', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('greatest', '', '求最大值', 'T  greatest(T v1, T v2, ...)', '返回数据列表中的最大值，当有元素时返回NULL', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('least', '', '求最小值', 'T  least(T v1, T v2, ...)', '返回数据列表中的最小值，当有NULL元素时返回NULL', @hiveSystemMathId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('size', '', '求集合的长度', 'int  size(Map<K.V>)  int  size(Array<T>)', '参数为Map类型时，计算Map的长度，参数为数组时计算数组的长度', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('map_keys', '', '返回map中的所有key', 'array<K>  map_keys(Map<K.V>)', '返回map中的所有key', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('map_values', '', '返回map中的所有value', 'array<V>  map_values(Map<K.V>)', '返回map中的所有value', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('array_contains', '', '判断数组是否包含指定值', 'boolean  array_contains(Array<T>, value)', '如该数组Array<T>包含value返回true。，否则返回false', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sort_array', '', '数组排序', 'array  sort_array(Array<T>)', '按自然顺序对数组进行排序并返回', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('row_number', '', '排序并获得排序后的编号', 'row_number() OVER (partition by COL1 order by COL2 desc ) rank', '表示根据COL1分组，在分组内部根据 COL2排序，而此函数计算的值就表示每组内部排序后的顺序编号（组内连续的唯一的)', @hiveSystemListId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('from_unixtime', '', '格式化时间', 'string  from_unixtime(bigint unixtime[, string format])', '将时间的秒值转换成format格式（format可为“yyyy-MM-dd hh:mm:ss”,“yyyy-MM-dd hh”,“yyyy-MM-dd hh:mm”等等）如from_unixtime(1250111000,\"yyyy-MM-dd\") 得到2009-03-12', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('unix_timestamp', '', '计算时间戳', 'bigint  unix_timestamp()  bigint  unix_timestamp(string date)  bigint  unix_timestamp(string date, string pattern)', '1.unix_timestamp()：获取本地时区下的时间戳  2.unix_timestamp(string date)：将格式为yyyy-MM-dd HH:mm:ss的时间字符串转换成时间戳，如unix_timestamp(\"2009-03-20 11:30:01\") = 1237573801  3.unix_timestamp(string date, string pattern)：将指定时间字符串格式字符串转换成Unix时间戳，如果格式不对返回0 如：unix_timestamp(\"2009-03-20\", \"yyyy-MM-dd\") = 1237532400', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('to_date', '', '计算日期', 'string  to_date(string timestamp)', '返回时间字符串的日期部分，如：to_date(\"1970-01-01 00:00:00\") = \"1970-01-01\".', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('year', '', '计算年份', 'int  year(string date)', '返回时间字符串的年份部分，如：year(\"1970-01-01 00:00:00\") = 1970, year(\"1970-01-01\") = 1970.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('quarter', '', '计算季节', 'int  quarter(date/timestamp/string)', '返回当前时间属性哪个季度 如quarter(\"2015-04-08\") = 2', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('month', '', '计算月份', 'int  month(string date)', '返回时间字符串的月份部分，如：month(\"1970-11-01 00:00:00\") = 11, month(\"1970-11-01\") = 11.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('day', '', '计算天', 'int  day(string date)', '返回时间字符串中的天部分，如：day(\"1970-11-01 00:00:00\") = 1, day(\"1970-11-01\") = 1.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('hour', '', '计算小时', 'int  hour(string date)', '返回时间字符串的小时，如： hour(\"2009-07-30 12:58:59\") = 12, hour(\"12:58:59\") = 12.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('minute', '', '计算分钟', 'int  minute(string date)', '返回时间字符串的分钟', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('second', '', '计算秒数', 'int  second(string date)', '返回时间字符串的秒', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('weekofyear', '', '计算周', 'int  weekofyear(string date)', '返回时间字符串位于一年中的第几个周内，如：weekofyear(\"1970-11-01 00:00:00\") = 44, weekofyear(\"1970-11-01\") = 44', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('datediff', '', '计算时间差', 'int  datediff(string enddate, string startdate)', '计算开始时间startdate到结束时间enddate相差的天数，如：datediff(\"2009-03-01\", \"2009-02-27\") = 2.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('date_add', '', '从开始时间startdate加上days', 'string  date_add(string startdate, int days)', '从开始时间startdate加上days，如：date_add(\"2008-12-31\", 1) = \"2009-01-01\".', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('date_sub', '', '从开始时间startdate减去days', 'string  date_sub(string startdate, int days)', '从开始时间startdate减去days，如：date_sub(\"2008-12-31\", 1) = \"2008-12-30\".', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('from_utc_timestamp', '', '时间戳转换', 'timestamp  from_utc_timestamp(timestamp, string timezone)', '如果给定的时间戳是UTC，则将其转化成指定的时区下时间戳，如：from_utc_timestamp(\"1970-01-01 08:00:00\",\"PST\")=1970-01-01 00:00:00.', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('to_utc_timestamp', '', '时间戳转换', 'timestamp  to_utc_timestamp(timestamp, string timezone)', '将给定的时间戳转换到UTC下的时间戳，如：to_utc_timestamp(\"1970-01-01 00:00:00\",\"PST\") =1970-01-01 08:00:00', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('current_date', '', '返回当前时间日期', 'date  current_date', '返回当前时间日期', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('current_timestamp', '', '返回当前时间戳', 'timestamp  current_timestamp', '返回当前时间戳', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('add_months', '', '返回当前时间下再增加num_months个月的日期', 'string  add_months(string start_date, int num_months)', '返回start_date之后的num_months的日期。 start_date是一个字符串，日期或时间戳。 num_months是一个整数。 start_date的时间部分被忽略。 如果start_date是本月的最后一天，或者如果生成的月份比start_date的日期组件少，那么结果是最后一个月的最后一天。 否则，结果与start_date具有相同的日期组件', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('last_day', '', '返回这个月的最后一天的日期', 'string  last_day(string date)', '返回日期所属的月份的最后一天。 date是格式为\"yyyy-MM-dd HH：mm：ss\"或\"yyyy-MM-dd\"的字符串。 日期的时间部分被忽略。', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('next_day', '', '返回当前时间的下一个星期X所对应的日期', 'string  next_day(string start_date, string day_of_week)', '返回当前时间的下一个星期X所对应的日期，如：next_day(\"2015-01-14\", \"TU\") = 2015-01-20 ?以2015-01-14为开始时间，其下一个星期二所对应的日期为2015-01-20', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('trunc', '', '返回时间的开始年份或月份', 'string  trunc(string date, string format)', '返回时间的开始年份或月份，如：trunc(\"2016-06-26\",“MM”)=2016-06-01 ?trunc(\"2016-06-26\",“YY”)=2016-01-01 ? 注意所支持的格式为MONTH/MON/MM, YEAR/YYYY/YY', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('months_between', '', '返回date1与date2之间相差的月份', 'double  months_between(date1, date2)', '返回date1与date2之间相差的月份，如date1>date2，则返回正，如果date1<date2,则返回负，否则返回0.0 ?如：months_between(\"1997-02-28 10:30:00\", \"1996-10-30\") = 3.94959677 ?1997-02-28 10:30:00与1996-10-30相差3.94959677个月', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('date_format', '', '时间格式化', 'string  date_format(date/timestamp/string ts, string fmt)', '按指定格式返回时间date，如：date_format(\"2016-06-22\",\"MM-dd\")=06-22', @hiveSystemDateId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('if', '', '如果testCondition 为true就返回valueTrue,否则返回valueFalseOrNull ', 'T  if(boolean testCondition, T valueTrue, T valueFalseOrNull)', 'valueTrue，valueFalseOrNull为泛型', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('nvl', '', '如果value值为NULL就返回default_value,否则返回value', 'T  nvl(T value, T default_value)', '如果value值为NULL就返回default_value,否则返回value', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('coalesce', '', '返回第一非null的值', 'T  coalesce(T v1, T v2, ...)', '如果全部都为NULL就返回NULL ?如：COALESCE (100,44,55)=44', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('isnull', '', '判断a是否为空', 'boolean  isnull( a )', '如果a为null就返回true，否则返回false', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('isnotnull', '', '判断a是否不为空', 'boolean  isnotnull ( a )', '如果a为非null就返回true，否则返回false', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('assert_true', '', '判断条件是否为真', 'assert_true(boolean condition)', '如果“条件”不为真，则抛出异常，否则返回null（从Hive 0.8.0开始）', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('cast', '', '类型转换', 'type  cast(expr as <type>)', '将表达式expr的结果转换为<type>。 例如，cast（\"1\"为BIGINT）将字符串\"1\"转换为其整数表示。 如果转换不成功，则返回null。', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('binary', '', '将输入的值转换成二进制', 'binary  binary(string|binary)', '将输入的值转换成二进制', @hiveSystemOtherId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('ascii', '', '返回str中首个ASCII字符串的整数值', 'int  ascii(string str)', '返回str中首个ASCII字符串的整数值', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('base64', '', '二进制转字符串', 'string  base64(binary bin)', '将二进制bin转换成64位的字符串', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('concat', '', '字符串和字节拼接', 'string  concat(string|binary A, string|binary B...)', '将字符串或字节拼接，如：concat(\"foo\", \"bar\") = \"foobar\"，次函数可以拼接任意数量的字符串或字节。', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('chr', '', '返回A对应的ASCII字符', 'string chr(bigint|double A)', '返回A对应的ASCII字符。如果A大于256，则结果相当于chr（A％256）。 示例：chr（@date）=“X”。', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('context_ngrams', '', '返回出现次数TOP K的的子序列', 'array<struct<string,double>>  context_ngrams(array<array<string>>, array<string>, int K, int pf)', '返回出现次数TOP K的的子序列，但context_ngram()允许你预算指定上下文(数组)来去查找子序列', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('concat_ws', '', '使用指定的分隔符拼接字符串', 'string  concat_ws(string SEP, string A, string B...)  string  concat_ws(string SEP, array<string>)', '使用指定的分隔符拼接字符串', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('decode', '', '解码', 'string  decode(binary bin, string charset)', '使用指定的字符集charset将二进制值bin解码成字符串，支持的字符集有：\"US-ASCII\", \"ISO-8@math9-1\", \"UTF-8\", \"UTF-16BE\", \"UTF-16LE\", \"UTF-16\"，如果任意输入参数为NULL都将返回NULL', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('encode', '', '编码', 'binary  encode(string src, string charset)', '使用指定的字符集charset将字符串编码成二进制值，支持的字符集有：\"US-ASCII\", \"ISO-8@math9-1\", \"UTF-8\", \"UTF-16BE\", \"UTF-16LE\", \"UTF-16\"，如果任一输入参数为NULL都将返回NULL', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('find_in_set', '', '返回以逗号分隔的字符串中str出现的位置', 'int  find_in_set(string str, string strList)', '返回以逗号分隔的字符串中str出现的位置，如果参数str为逗号或查找失败将返回0，如果任一参数为NULL将返回NULL回', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('format_number', '', '格式转换', 'string  format_number(number x, int d)', '将数值X转换成\"#,###,###.##\"格式字符串，并保留d位小数，如果d为0，将进行四舍五入且不保留小数', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('get_json_object', '', '从指定路径获取JSON对象', 'string  get_json_object(string json_string, string path)', '从指定路径上的JSON字符串抽取出JSON对象，并返回这个对象的JSON格式，如果输入的JSON是非法的将返回NULL,注意此路径上JSON字符串只能由数字 字母 下划线组成且不能有大写字母和特殊字符，且key不能由数字开头，这是由于Hive对列名的限制', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('in_file', '', '在指定文件中索引指定字符串', 'boolean  in_file(string str, string filename)', '如果文件名为filename的文件中有一行数据与字符串str匹配成功就返回true', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('instr', '', '查找字符串str中子字符串substr出现的位置', 'int  instr(string str, string substr)', '查找字符串str中子字符串substr出现的位置，如果查找失败将返回0，如果任一参数为Null将返回null，注意位置为从1开始的', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('length', '', '计算字符串长度', 'int  length(string A)', '返回字符串的长度', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('locate', '', '在位置pos之后返回str中第一次出现substr的位置', 'int  locate(string substr, string str[, int pos])', '在位置pos之后返回str中第一次出现substr的位置', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('lower', '', '将字符串A的所有字母转换成小写字母', 'string  lower(string A)', '将字符串A的所有字母转换成小写字母', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('lpad', '', '从左边开始对字符串str使用字符串pad填充，最终len长度为止，如果字符串str本身长度比len大的话，将去掉多余的部分', 'string  lpad(string str, int len, string pad)', '从左边开始对字符串str使用字符串pad填充，一直到长度为len为止，如果字符串str本身长度比len大的话，将去掉多余的部分', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('ltrim', '', '去掉字符串A前面的空格', 'string  ltrim(string A)', '去掉字符串A前面的空格', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('ngrams', '', '返回出现次数TOP K的的子序列', 'array<struct<string,double>>  ngrams(array<array<string>>, int N, int燢, int pf)', '返回出现次数TOP K的的子序列,n表示子序列的长度', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('parse_url', '', '返回从URL中抽取指定部分的内容', 'string  parse_url(string urlstring, string partToExtract [, string keyToExtract])', '返回从URL中抽取指定部分的内容，参数url是URL字符串，而参数partToExtract是要抽取的部分，这个参数包含(HOST, PATH, QUERY, REF, PROTOCOL, AUTHORITY, FILE, and USERINFO,例如：parse_url(\"http://facebook.com/path1/p.php?k1=v1&k2=v2#Ref1\", \"HOST\") =\"facebook.com\"，如果参数partToExtract值为QUERY则必须指定第三个参数key ?如：parse_url(\"http://facebook.com/path1/p.php?k1=v1&k2=v2#Ref1\", \"QUERY\", \"k1\") =‘v1’', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('printf', '', '按照printf风格格式输出字符串', 'string  printf(string format, Obj... args)', '按照printf风格格式输出字符串', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('regexp_extract', '', '返回使用模式提取的字符串', 'string  regexp_extract(string subject, string pattern, int index)', '抽取字符串subject中符合正则表达式pattern的第index个部分的子字符串， 例如，regexp_extract(\"foothebar\", \"foo(.*?)(bar)\", 2)=\"bar\"。 请注意，在使用预定义的字符类时需要注意：使用“ s”作为第二个参数将匹配字母s; \"\"需要匹配空格等', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('regexp_replace', '', '使用模式匹配替换字符串', 'string regexp_replace(string INITIAL_STRING, string PATTERN, string REPLACEMENT)', '按照Java正则表达式PATTERN将字符串INITIAL_STRING中符合条件的部分替换成REPLACEMENT所指定的字符串，如里REPLACEMENT为空的话，将符合正则的部分将被去掉 ?如：regexp_replace(\"foobar\", \"oo|ar\", \"\") = \"fb.\"。', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('repeat', '', '重复输出n次字符串str', 'string  repeat(string str, int n)', '重复输出n次字符串str', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('reverse', '', '反转字符串', 'string  reverse(string A)', '反转字符串', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('rpad', '', '字符串填充', 'string  rpad(string str, int len, string pad)', '从右边开始对字符串str使用字符串pad填充，一直到长度为len为止，如果字符串str本身长度比len大的话，将去掉多余的部分', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('rtrim', '', '去掉字符串后面出现的空格', 'string  rtrim(string A)', '去掉字符串后面出现的空格', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sentences', '', '将字符串str将转换成单词数组', 'array<array<string>>  sentences(string str, string lang, string locale)', '字符串str将被转换成单词数组，如：sentences(\"Hello there! How are you?\") =( (\"Hello\", \"there\"), (\"How\", \"are\", \"you\") )', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('space', '', '返回n个空格', 'string  space(int n)', '返回n个空格', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('split', '', '按照正则表达式pat来分割字符串str', 'array  split(string str, string pat)', '按照正则表达式pat来分割字符串str,分割后以数组字符串的形式返回', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('str_to_map', '', '将字符串str按照指定分隔符转换成Map', 'map<string,string>  str_to_map(text[, delimiter1, delimiter2])', '将字符串str按照指定分隔符转换成Map，第一个参数是需要转换的字符串，第二个参数是键值对之间的分隔符，默认为逗号;第三个参数是键值之间的分隔符，默认为\"=\"', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('substr', '', '截取字符串', 'string  substr(string|binary A, int start) string  substr(string|binary A, int start, int len) ', '截取字符串A中start位置之后的字符串并返回  截取字符串A中start位置之后的长度为length的字符串', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('substring_index', '', '截取字符串', 'string  substring_index(string A, string delim, int count)', '截取第count分隔符之前的字符串，如count为正则从左边开始截取，如果为负则从右边开始截取', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('translate', '', '字符串替换', 'string  translate(string|char|varchar input, string|char|varchar from, string|char|varchar to)', '将input出现在from中的字符串替换成to中的字符串 如：translate(\"MOBIN\",\"BIN\",\"M\")=\"MOM\"', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('trim', '', '将字符串A前后出现的空格去掉', 'string  trim(string A)', '将字符串A前后出现的空格去掉', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('unbase64', '', '将64位的字符串转换二进制值', 'binary  unbase64(string str)', '将64位的字符串转换二进制值', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('upper', '', '将字符串A中的字母转换成大写字母', 'string  upper(string A)', '将字符串A中的字母转换成大写字母', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('initcap', '', '字符串中的单词首字母大写', 'string  initcap(string A)', '返回字符串，每个单词的第一个字母大写，所有其他字母以小写形式显示。 单词由空格分割。', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('levenshtein', '', '计算两个字符串之间的差异大小', 'int  levenshtein(string A, string B)', '计算两个字符串之间的差异大小 ?如：levenshtein(\"kitten\", \"sitting\") = 3', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('soundex', '', '将普通字符串转换成soundex字符串', 'string  soundex(string A)', '将普通字符串转换成soundex字符串，如：soundex(\"Miller\") = M460.', @hiveSystemCharaId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('count', '', '统计总行数', 'bigint  count(*)  bigint  count(expr)  bigint  count(DISTINCT expr[, expr...])', '统计总行数，包括含有NULL值的行  统计提供非NULL的expr表达式值的行数  统计提供非NULL且去重后的expr表达式值的行数', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('sum', '', '表示求指定列的和', 'double  sum(col)  double  sum(DISTINCT col)', 'sum(col),表示求指定列的和，sum(DISTINCT col)表示求去重后的列的和', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('avg', '', '求指定列的平均值', 'double  avg(col)  double  avg(DISTINCT col)', 'avg(col),表示求指定列的平均值，avg(DISTINCT col)表示求去重后的列的平均值', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('min', '', '求指定列的最小值', 'double  min(col)', '求指定列的最小值', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('max', '', '求指定列的最大值', 'double  max(col)', '求指定列的最大值', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('variance', '', '求指定列数值的方差', 'double  variance(col)  double  var_pop(col)', '求指定列数值的方差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('var_samp', '', '求指定列数值的样本方差', 'double  var_samp(col)', '求指定列数值的样本方差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('stddev_pop', '', '求指定列数值的标准偏差', 'double  stddev_pop(col)', '求指定列数值的标准偏差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('stddev_samp', '', '求指定列数值的样本标准偏差', 'double  stddev_samp(col)', '求指定列数值的样本标准偏差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('covar_pop', '', '求指定列数值的协方差', 'double  covar_pop(col1, col2)', '求指定列数值的协方差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('covar_samp', '', '求指定列数值的样本协方差', 'double  covar_samp(col1, col2)', '求指定列数值的样本协方差', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('corr', '', '返回两列数值的相关系数', 'double  corr(col1, col2)', '返回两列数值的相关系数', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('percentile', '', '返回col的p%分位数', 'double  percentile(bigint col, p)', ' p必须在0和1之间。注意：只能对整数值计算真正的百分位数。 ', @hiveSystemGroupId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('explode', '', '对于a中的每个元素，生成包含该元素的行', 'Array Type  explode(array<TYPE> a)  N rows  explode(ARRAY)  N rows  explode(MAP)', '对于a中的每个元素，生成包含该元素的行  从数组中的每个元素返回一行  从输入映射中为每个键值对返回一行，每行中有两列：一个用于键，另一个用于该值', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('posexplode', '', '从数组中的每个元素返回一行', 'N rows  posexplode(ARRAY)', '与explode类似，不同的是还返回各元素在数组中的位置', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('stack', '', '把M列转换成N行', 'N rows  stack(int n, v_1, v_2, ..., v_k)', '将v_1，...，v_k分解成n行。 每行将有k / n列。 n必须是常数。', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('json_tuple', '', '从一个JSON字符串中获取多个键并作为一个元组返回', 'tuple  json_tuple(jsonStr, k1, k2, ...)', '从一个JSON字符串中获取多个键并作为一个元组返回，与get_json_object不同的是此函数能一次获取多个键值', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('parse_url_tuple', '', '返回从URL中抽取指定N部分的内容', 'tuple  parse_url_tuple(url, p1, p2, ...)', '返回从URL中抽取指定N部分的内容，参数url是URL字符串，而参数p1,p2,....是要抽取的部分，这个参数包含HOST, PATH, QUERY, REF, PROTOCOL, AUTHORITY, FILE, USERINFO, QUERY:<KEY>', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100),
('inline', '', '将结构体数组提取出来并插入到表中', 'inline(ARRAY<STRUCT[,STRUCT]>)', '将结构体数组提取出来并插入到表中', @hiveSystemTableId, -1, -1, -1, -1, 1, 1, now(), now(), 0, 100);

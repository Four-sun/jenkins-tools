-- 增加Oracle数据源

INSERT INTO rdos_dict (type, dict_name, dict_value, dict_name_zh, dict_name_en, dict_sort, gmt_create, gmt_modified,
                       is_deleted)
VALUES   ('6', 'OracleSQLFunction', '4', 'Oracle SQL', 'OracleSQLFunction', '5', now(), now(), '0');


begin;
-- 插入 oracle 系统函数目录
-- 系统函数
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, '系统函数', -4, 4, 1, 5, now(), now(), -1, 0);

-- 插入系统函数的子节点 数值型函数 返回字符值的字符函数 返回数值的字符函数 字符集函数 日期时间函数 一般比较功能函数 转换功能函数 大对象函数 层次函数 数挖掘函数
-- 编码和解码函数  相关函数   统计函数
set @system_oracle_function_id=(select id from rdos_batch_catalogue where node_pid = -4 and engine_type = 5 limit 1);
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, '数值型函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '字符函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '日期时间函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '比较函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '转换函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '大对象函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '层次函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '数据挖掘函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '编码和解码函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '统计函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0),
(-1, -1, '其他函数', @system_oracle_function_id, null, 2, 5, now(), now(), -1, 0);


-- 插入函数管理下的Oracle SQL目录
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
SELECT tenant_id, id as project_id, 'Oracle SQL',
       IFNULL((select id from rdos_batch_catalogue where node_name = '函数管理' and project_id = rdos_project.id), -1) as node_pid,
       1, 5, now(), now(), -1, 0
FROM rdos_project where is_deleted = 0 and status = 1;

-- 插入Oracle SQL目录下的系统函数
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
select tenant_id, project_id, '系统函数', id, 1, engine_type, now(), now(), create_user_id, 0
from rdos_batch_catalogue
where node_name = 'Oracle SQL';

-- 插入系统函数
set @number_id=(select id from rdos_batch_catalogue where node_name='数值型函数' AND engine_type = 5 AND is_deleted = 0);
set @char_id=(select id from rdos_batch_catalogue where node_name='字符函数' AND engine_type = 5 AND is_deleted = 0);
set @date_id=(select id from rdos_batch_catalogue where node_name='日期时间函数' AND engine_type = 5 AND is_deleted = 0);
set @compare_id=(select id from rdos_batch_catalogue where node_name='比较函数' AND engine_type = 5 AND is_deleted = 0);
set @conversion_id=(select id from rdos_batch_catalogue where node_name='转换函数' AND engine_type = 5 AND is_deleted = 0);
set @bigobject_id=(select id from rdos_batch_catalogue where node_name='大对象函数' AND engine_type = 5 AND is_deleted = 0);
set @level_id=(select id from rdos_batch_catalogue where node_name='层次函数' AND engine_type = 5 AND is_deleted = 0);
set @data_mining_id=(select id from rdos_batch_catalogue where node_name='数据挖掘函数' AND engine_type = 5 AND is_deleted = 0);
set @encoding_decoding_id=(select id from rdos_batch_catalogue where node_name='编码和解码函数' AND engine_type = 5 AND is_deleted = 0);
set @statistical_id=(select id from rdos_batch_catalogue where node_name='统计函数' AND engine_type = 5 AND is_deleted = 0);
set @other_id=(select id from rdos_batch_catalogue where node_name='其他函数' AND engine_type = 5 AND is_deleted = 0);

-- 数值型函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('ABS', '', '取绝对值', 'ABS(n)', '精确数值或近似数值数据类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）的表达式。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ACOS', '', '返回反余弦值n，返回的范围是[0,pi]的值', 'ACOS(n)', '参数必须在[-1,1]范围内', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ASIN', '', '返回反正弦值，返回的范围是[-pi/2,pi/2]的值', 'ASIN(n)', '参数必须在[-1,1]范围内', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ATAN', '', '返回反正切值，范围的范围是[-pi/2,pi/2]的值', 'ATAN(n)', '参数可以是无界范围和范围内的值', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ATAN2', '', '对于任意不同时等于0的实参数x和y，atan2(y,x)所表达的意思是坐标原点为起点，指向(x,y)的射线在坐标平面上与x轴正方向之间的角的角度。当y>0时，射线与x轴正方向的所得的角的角度指的是x轴正方向绕逆时针方向到达射线旋转的角的角度；而当y<0时，射线与x轴正方向所得的角的角度指的是x轴正方向绕顺时针方向达到射线旋转的角的角度。', 'ATAN2(x,y)', '参数x,y不同时等于0', @number_id, -1, -1, -1, -1, 1, 4, now(), now(), 0),
('BITAND', '', '返回两个数值型数值在按位进行AND运算后的结果', 'BITAND(p1,p2)', '参数范围必须要在[-(2^(n-1)),((2^(n-1))-1)]', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CEIL', '', '函数返回大于等于指定值(value)的最小整数', 'CEIL(x)', '参数为任意实数', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('COS', '', '返回余弦值', 'COS(x)', '参数为以弧度表示的角度', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('COSH', '', '返回双曲余弦值', 'COSH(X)', '参数为任意数值，如果参数为BINARY_FLOAT，则函数返回BINARY_DOUBLE。否则，该函数将返回与参数相同的数字数据类型。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('EXP', '', '返回e的次幂', 'EXP(x)', '"参数为任意实数，该函数返回与参数类型相同的值。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FLOOR', '', '函数返回小于等于指定值(value)的最大整数', 'FLOOR(x)', '参数为任意实数', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LN', '', '返回自然对数', 'LN(n)', '参数n>0', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LOG', ''	,'返回以x为底数，n的对数值	','LOG(x,n)',	'参数n>0，x>0且x不等于1', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('MOD', ''	,'返回x除以y的余数',	'MOD(x,y)',	'参数x和y可以是两个整数，也可以是表中的整数列', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NANVL', ''	 ,'如果x是数字，则返回x；如果x不是数字，则返回value。','NANVL(x,value)',	'参数是浮点数类型binary_float或binary_double', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('POWER', ''	,'返回x的y次方',	'POWER(x,y)',	'参数为任意数字类型', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REMAINDER', ''	,'返回第1个参数除以第2个参数时的余数',	'REMAINDER(x1,x2)',	'x1 和 x2为数值型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）表达式。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ROUND', ''	,'将参数n按照n2指定的小数位进行四舍五入',	'ROUND(n,n2)',	'参数n为任意实数，n2为任意整数，不指定n2时默认n2为0,即近似到个位.如果第2个参数为负数时将对小数点左边的数作四舍五入,会入到左面的|n|+1位.', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SIGN'	, '','返回参数n的符号，参数n<0,返回-1;参数n=0,返回0;参数n>0,返回1;如果参数为BINARY_FLOAT或BINARY_DOUBLE,且小于0,返回-1;如果参数为BINARY_FLOAT或BINARY_DOUBLE,且大于或等于0,返回1;','	SIGN(n)','参数n自定义数值', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SIN'	, '','返回参数的正弦',	'SIN(n)',	'参数为数值型值或可以隐式地转换为数值型值的值.该参数应该是一个表示为弧度的角度', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SINH'	, '','返回参数的双曲正弦.',	'SINH(n)',	'参数为任意数值，如果参数为BINARY_FLOAT，则函数返回BINARY_DOUBLE。否则，该函数将返回与参数相同的数字数据类型。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SQRT'	, '','返回参数的平方根',	'SQRT(n)',	'参数为实数时，n非负，参数也为二进制浮点数，则n>0,结果为正，n=0结果为0，n<0结果为负', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TAN'	, '','返回参数的正切值',	'TAN(n)',	 '参数为数值型值或可以隐式地转换为数值型值的值.该参数应该是一个表示为弧度的角度.', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TANH'	, '','返回参数的双曲正切','TANH(n)','参数为数值型值或可以隐式地转换为数值型值的值.该参数应该是一个表示为弧度的角度', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TRUNC', ''	,'将参数n截取到n2指定的小数位',	'TRUNC(n,n2)',	'参数n2可以是一个指定截取小数点右面的正整数,也可以是一个指定截取小数点右边的负整数(这时的位数为|n2|+1).如果n2为0或不输入n2则截取到小数点左侧的个位数.', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('WIDTH_BUCKET', ''	,'可以构造等宽直方图，其中直方图范围分为大小相同的间隔',	'WIDTH_BUCKET(X,MIN,MAX,NUM_BUCKETS)', 	'范源围MIN到MAX被分为num_buckets节，每节有相同的大小。返回X所在的那一节。如果X小于MIN，将知返回0，如果X大于或等于MAX，将返回num_buckets+1.MIN和MAX都不能为NULL，num_buckets必须是一个正整数道。如果X是NULL，则返回NULL。', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_CHARSET_DECL_LEN', '',	'该函数用于返回字节数在特定字符集中占有的字符个数。',	'NLS_CHARSET_DECL_LEN(byte_count,charset_id)',	'byte_count:字符类型；charset_id:整数型数据', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_CHARSET_ID', '',	'该函数用于返回字符集的ID号','NLS_CHARSET_ID(string)',	'string是字符串数据类型', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_CHARSET_NAME', '',	'该函数用于返回字符集ID号所对应的字符集名',	'NLS_CHARSET_NAME(number)',	'number是int型数据', @number_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 字符函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('CHR', ''	,'返回在数据库字符集中与X拥有等价数值的字符。CHR和ASCII是一对反函数。经过CHR转换后的字符再经过ASCII转换又得到了原来的字符。'	,'CHR(x)'	,'x为0 ~ 255位，整数' , @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CONCAT', ''	,'返回string1，并且在后面连接string2。'	,'CONCAT(char1,char2)'	,'参数可以是任何数据类型的CHAR，VARCHAR2，NCHAR，NVARCHAR2，CLOB，或NCLOB。返回的字符串与相同char1', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('INITCAP', ''	,'返回字符串的每个单词的第一个字母大写而单词中的其他字母小写的string。单词是用.空格或给字母数字字符进行分隔。不是字母的字符不变动。'	,'INITCAP(string)'	,'参数为字符型表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LOWER', '','将字符串全部转为小写'	,'LOWER(string)'	,'参数为字符型表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LPAD', ''	,'在字符串c1的左边用字符串c2填充，直到长度为n时为止'	,'LPAD(c1,n,c2)'	,'参数c1 字符串,n 追加后字符总长度,c2 追加字符串,默认为空格', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LTRIM', '','去除指定字符的前面空格'	,'LTRIM(string1)'	,'srting1字符串数据表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NCHR', '','返回与number等效的二进制字符。返回的值始终为NVARCHAR2，此函数等效于将CHR函数与USING NCHAR_CS子句一起使用。'	,'NCHR()'	,'x为0 ~ 255位，整数', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_INITCAP', ''	,'返回字符串每个单词第一个字母大写而单词中的其他字母小写的string，nlsparams指定了不同于该会话缺省值的不同排序序列。如果不指定参数，则功能和INITCAP相同。'	,'NLS_INITCAP(string,nlsparams)'	,'string字符型表达式,nlsparam可选', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_LOWER', '','返回字符串中的所有字母都是小写形式的string。不是字母的字符不变。'	,'NLS_LOWER(string,nlsparams)'	,'string字符型表达式,nlsparam可选', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLS_UPPER', '','返回字符串中的所有字母都是大写的形式的string。不是字母的字符不变。nlsparams参数的形式与用途和NLS_INITCAP中的相同。如果没有设定参数，则NLS_UPPER功能和UPPER相同。'	,'NLS_UPPER(string,nlsparams)'	,'string字符型表达式,nlsparam可选', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NLSSORT', '','得到用于排序string的字符串字节'	,'NLSSORT(string,nlsparams)'	,'string字符型表达式,nlsparams的作用和NLS_INITCAP中的相同.如果忽略参数,会话使用缺省排序.', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REGEXP_REPLACE', '','该函数返回source_char与replace_string取代了正则表达式模式的每个实例'	,'REGEXP_REPLACE(source_char, pattern , replace_string , position , occurrence , match_parameter  )'	,'source_char搜索值的字符表达式。这通常是一个字符列，可以是任何数据类型CHAR，VARCHAR2，NCHAR，NVARCHAR2，CLOB或NCLOB;pattern正则表达式；replace_string可选，匹配的模式将被替换replace_string字符串；如果省略replace_string参数，将删除所有匹配的模式，并返回结果字符串；position可选，在字符串中的开始位置搜索，如果省略，则默认为1；occurrence可选，是一个非负整数默认为1，指示替换操作的发生：如果指定0，那么所有出现将被替换字符串，如果指定了正整数n，那么将替换第n次出现；match_parameter可选，它允许你修改REGEXP_REPLACE功能匹配的行为，可填‘c’‘i’‘n’‘m’‘x’', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REGEXP_SUBSTR', '','使用正则表达式从字符串中抽取子串'	,'REGEXP_SUBSTR(String, pattern, position, occurrence, modifier)'	,'srcstr     ：需要进行正则处理的字符串pattern    ：进行匹配的正则表达式position   ：起始位置，从第几个字符开始正则表达式匹配（默认为1）occurrence ：标识第几个匹配组，默认为1modifier   ：模式（"i"不区分大小写进行检索；"c"区分大小写进行检索。默认为"c"。）', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REPLACE', ''	,'替换特定字符串'	,'replace(string1,retring,str)'	,'string1:将要更改的字符串；retring:被替换掉的字符串；str;替换字符串', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('RPAD'	, '','在字符串c1的右边用字符串c2填充，直到长度为n时为止'	,'RPAD(c1,n,c2)'	,'参数c1 字符串,n 追加后字符总长度,c2 追加字符串,默认为空格', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('RTRIM'	, '','去除指定字符后面后空格'	,'RTRIM(string)'	,'srting字符串数据表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SOUNDEX'	, '','函数返回字符串参数的语音表示形式'	,'SOUNDEX(string)'	,'srting字符串数据表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SUBSTR'	, '','截取字符串内容'	,'substr(string, a, b)' 	,'string:要处理的字符串 a:截取字符串的开始位置（起始位置是0） b: 截取的字符串的长度(而不是字符串的结束位置) ,若b缺省时，a 可以理解为从索引a（注意：起始索引是0）处开始截取字符串，也可以理解为从第 （a+1）个字符开始截取字符串', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TRANSLATE', ''	,'translate返回expr，其中from_string中的每个字符的所有出现都被to_string中的相应字符替换'	,'translate(expr, from_strimg, to_string)'	,'expr是待处理的字符串；from_string是按顺序排列若干个要被替换的字符集合，注意是字符集合而不是字符串；to_string 是按顺序对应from_str要被替换成的字符集合。', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TRIM'	, '','删除字符串两边的空格，参数非缺省时则分别从string的两边开始，删除指定的char'	,'trim()或trim(char  from  string)' 	,'char指定删除的字符；string处理的字符串', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('UPPER'	, '','小写字符转化成大写的函数'	,'UPPER(string)'	,'参数为字符型表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ASCII', '',	'用于将字符转换成其相应的ASCII码'	,'ASCLL("x")'	,'输入的任意字符', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('INSTR', '',	'函数返回要截取的字符串在源字符串中的位置，string2 的值要在string1中查找，是从start_position给出的数值（即：位置）开始在string1检索，检索第nth_appearance（几）次出现string2。'	,'instr( string1, string2 , start_position , nth_appearance )'	,'string1源字符串, string2目标字符串, start_position起始位置, nth_appearance匹配序号，start_position和nth_appearance可缺省', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LENGTH', '',	'返回字符串的字符数',	'LENGTH(string)'	,'string字符型表达式', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REGEXP_COUNT', '',	'返回pattern 在source_char 串中出现的次数,如果未找到匹配，则函数返回0。'	,'REGEXP_COUNT ( source_char, pattern , position , match_param)',	'source_char是字符串类型数据，pattern是待匹配的，position是开始搜索的索引位置，match_param 变量支持下面几个值：
‘i’ 用于不区分大小写的匹配；
‘c’ 用于区分大小写的匹配；
‘n’ 允许句点(.)作为通配符去匹配换行符；
‘m’ 将源串视为多行。即Oracle 将^和$分别看作源串中任意位置任何行的开始和结束，而不是仅仅看作整个源串的开始或结束。如果省略该参数，则Oracle将源串看作一行。
‘x’ 忽略空格字符。默认情况下，空格字符与自身相匹配。', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('REGEXP_INSTR', '',	'搜索一个正则表达式模式字符串，返回一个整数，指示开始或结束匹配的子位置，这取决于return_option参数的值，如果没有找到匹配，则函数返回0。',	'REGEXP_INSTR (source_char, pattern , position , occurrence , return_option , match_parameter )',	'source_char搜索值的字符表达式，可以是任何数据类型CHAR，VARCHAR2，NCHAR，NVARCHAR2，CLOB或NCLOB的；pattern正则表达式；position可选，搜索在字符串中的开始位置，如果省略，则默认为1，这是字符串中的第一个位置；occurrence可选，它是模式字符串中的第n个匹配位置，如果省略，默认为1；return_option可选 指定Oracle返回的位置：如果指定0，那么Oracle将返回出现的第一个字符的位置。这是默认的。
如果指定1，则Oracle返回字符之后发生的位置。match_parameter
可选。它允许你修改REGEXP_INSTR功能匹配的行为。它可以是以下的组合：‘i’ 用于不区分大小写的匹配；
‘c’ 用于区分大小写的匹配；
‘n’ 允许句点(.)作为通配符去匹配换行符；
‘m’ 将源串视为多行。即Oracle 将^和$分别看作源串中任意位置任何行的开始和结束，而不是仅仅看作整个源串的开始或结束。如果省略该参数，则Oracle将源串看作一行。
‘x’ 忽略空格字符。默认情况下，空格字符与自身相匹配。', @char_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 日期时间函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('ADD_MONTHS'	, '','返回日期及月份'	,'ADD_MONTHS(date,integer)'	,'date参数可以是datetime值，也可以是任何可以隐式转换为date的值，integer参数可以是一个整数或者是可以隐式转换为一个整数的任意值', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CURRENT_DATE'	, '','返回当前会话时区中的当前日期'	,'current_date'	,'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CURRENT_TIMESTAMP', '',	'以timestamp with time zone数据类型返回当前会话时区中的当前日期'	,'CURRENT_TIMESTAMP'	,'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('DBTIMEZONE', '','返回时区'	,'DBTIMEZONE'	,'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('EXTRACT', '', '用于从一个date或者interval类型中截取到特定的部分' 	,'EXTRACT ({ YEAR | MONTH | DAY | HOUR | MINUTE | SECOND }  | { TIMEZONE_HOUR | TIMEZONE_MINUTE }   | { TIMEZONE_REGION | TIMEZONE_ABBR }  FROM { date_value | interval_value } )' 	,'参数均是时间类型', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FROM_TZ', '',	'将一个 TIMSTAMP 数据类型的值和时区信息拼成一个 TIMESTAMP WITH TIME ZONE 数据类型的时间值'	,'FROM_TZ(timestamp_value,time_zone_value)',	'timestamp_value：TIMSTAMP 数据类型的时间值；time_zone_value：时区信息', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LAST_DAY'	, '','函数返回日期 date 所在月份的最后一天的日期',	'LAST_DAY (date)',	'date：所有包含日期信息的数据类型（DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE、TIMESTAMP WITH LOCAL TIME ZONE）的值', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LOCALTIMESTAMP', '',	'函数返回当前会话时区中的当前日期，返回 TIMESTAMP 数据类型的值'	,'LOCALTIMESTAMP(timestamp_precision)'	,'imestamp_precision:表示秒的小数位的精度，默认值为 6，取值范围 0~9。', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('MONTHS_BETWEEN', '',	'函数是返回返回参数 date1 到 date2 之间的月数',	'THS_BETWEEN (date1，date2)','date1,date2均是DATE 数据类型的值', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NEW_TIME', '',	'给出时间dt1在c1时区对应c2时区的日期和时间',	'NEW_TIME(dt1,c1,c2)',	'dt1对应Date型数据，c1,c2对应的时区及其简写', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NEXT_DAY', '',	'函数是返回日期 d1 的下一周中 c1（星期值）所在的日期值	','NEXT_DAY (d1,c1)','"d1:DATE 数据类型的值；c1:星期值MONDAY、TUESDAY、WEDNESDAY、THURSDAY、FRIDAY、SATURDAY 和 SUNDAY"', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NUMTODSINTERVAL', '',	'函数是把参数 n 转为以参数 interval_unit 为单位的 INTERVAL DAY TO SECOND 数据类型的值',   'NUMTODSINTERVAL( n,interval_unit)','n:NUMBER 数据类型的值;interval_unit:单位值：DAY、HOUR、MINUTE、MINUTE', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NUMTOYMINTERVAL', '',	'函数是把参数 n 转为以 interval_unit 为单位的 INTERVAL YEAR TO MONTH 数据类型的值','NUMTOYMINTERVAL (n,interval_unit)',	'n:NUMBER 数据类型的值;interval_unit:单位值：YEAR,MONTH', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ROUND', '',	'函数返回以参数 fmt 为单位距离的离指定日期 date 最近的日期时间值',	'ROUND(date,fmt)',	'date:所有包含日期的数据类型的值：DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE、TIMESTAMP WITH LOCAL TIME ZONE;fmt:指定了函数返回值与 date 的距离单位，以下表格列举了该参数的可取值，大小写不敏感', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SESSIONTIMEZONE', '',	'函数是返回当前会话时区',	'SESSIONTIMEZONE',	'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SYS_EXTRACT_UTC', '',	'函数是返回与指定时间相对应的标准 UTC 时间',	'SYS_EXTRACT_UTC (datetime_with_timezone)',	'datetime_with_timezone：TIMESTAMP WITH TIME ZONE 和 TIMESTAMP WITH LOCAL TIME ZONE 数据类型的值', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SYSDATE', '',	'函数返回当前日期',	'SYSDATE',	'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SYSTIMESTAMP', '',	'函数返回系统当前日期，返回值的秒的小数位包含 6 位精度，且包含当前时区信息',	'SYSTIMESTAMP'	,'没有参数，没有括号', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_CHAR', '',	'函数将 DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE、TIMESTAMP WITH LOCAL TIME ZONE、INTERVAL DAY TO SECOND 和 INTERVAL YEAR TO MONTH 等数据类型的值按照参数 fmt 指定的格式转换为 VARCHAR2 数据类型的值。 如果不指定参数 fmt，则参数 datetime 的值将按如下格式转换为 VARCHAR2 数据类型：DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE 和 TIMESTAMP WITH LOCAL TIME ZONE 的值被转换为数据库中日期时间值的默认格式；INTERVAL DAY TO SECOND 和 INTERVAL YEAR TO MONTH 数据类型的值转换为数字格式的间隔值；',	'TO_CHAR( datetime , fmt , nlsparam)',	'datetime：DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE、TIMESTAMP WITH LOCAL TIME ZONE、INTERVAL DAY TO SECOND 和 INTERVAL YEAR TO MONTH 等数据类型的值；fmt：可选，输出格式参数nlsparam：可选，用来控制返回的月份和日份所使用的语言', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_DSINTERVAL', '',	'函数将一个 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串转换为一个 INTERVAL DAY TO SECOND 数据类型的值，该函数可以用来对一个日期时间值进行加减计算',	'TO_DSINTERVAL (days hours：minutes：seconds[.frac_secs])',	'days hours：minutes：seconds[.frac_secs]：符合该参数格式的 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_TIMESTAMP', '',	'函数将字符串转换为 TIMESTAMP 数据类型',	'TO_TIMESTAMP (char，fmt,nlsparam)',	'char：CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串；fmt：可选，指定返回值的格式；nlsparam：可选，用来控制返回的月份和日份所使用的语言', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_TIMESTAMP_TZ', '',	'函数将字符串转换为 TIMESTAMP WITH TIME ZONE 数据类型，包含时区信息',	'TO_TIMESTAMP_TZ (char，fmt,nlsparam)',	'char：CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串；fmt：可选，指定返回值的格式；nlsparam：可选，用来控制返回的月份和日份所使用的语言', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_YMINTERVAL', '',	'函数将一个 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串转换为一个 INTERVAL YEAR TO MONTH 数据类型的值，该函数可以用来对一个日期时间值进行加减计算',	'TO_YMINTERVAL (years-months)'	,'years-months：符合该参数格式的 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TRUNC', '',	'函数返回以参数 fmt 为单位距离的离指定日期 date 最近的日期时间值，并且返回的日期值在 date 之前',	'TRUNC (date,fmt)',	'date：DATE 数据类型；fmt：指定了函数返回值与 date 的距离单位', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TZ_OFFSET', '','函数返回时区 n 的时区偏移量'	,'TZ_OFFSET (n)',	'n：时区区域名称，eg:TZ_OFFSET("US/EASTERN")', @date_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 比较函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('GREATEST', '',	'函数返回一个或多个表达式列表中的最大值。 数据库使用第一个参数 expr 来确定返回类型',	'GREATEST(expr [, expr ]...)',	'expr:一个表达式或表达式列表。数据类型可以是：NUMBER、FLOAT、BINARY_FLOAT、BINARY_DOUBLE、CHAR、VARCHAR2、NCHAR、NVARCHAR2、或 CLOB。', @compare_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LEAST', '',	'函数返回一个或多个表达式列表中的最小值'	,'LEAST(expr [, expr ]...)',	'expr:一个表达式或表达式列表。数据类型可以是：NUMBER、FLOAT、BINARY_FLOAT、BINARY_DOUBLE、CHAR、VARCHAR2、NCHAR、NVARCHAR2、或 CLOB。', @compare_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 转换函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('ASCIISTR', '',	'可以使用数据库字符集将任何字符集中的字符串转换为ASCII字符串。',	'ASCLLSTR(str)',	'输入的任意字符串', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('BIN_TO_NUM', '',	'二进制到十进制的转换',	'BIN_TO_NUM(num1,num2,..)',	'参数为二进制数值', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CAST', '',	'函数用于将源数据类型的表达式显式转换为另一种数据类型',	'CAST (expr AS type_name )',	'expr：列名或者表达式
AS：用于分隔两个参数，在 AS 之前的是要处理的数据，在 AS 之后是要转换的数据类型
type_name：oracle的数据类型"', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CHARTOROWID', '',	'转换varchar2类型为rowid值',	'hartorowid(c1)',	'c1,字符串，长度为18的字符串，字符串必须符合rowid格式', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('COMPOSE', '',	'函数可以返回一个规范化Unicode字符串',	'COMPOSE( string )',	'string：用于创建Unicode字符串的输入值， 它可以是char，varchar2，nchar，nvarchar2，clob或nclob。', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CONVERT', '',	'函数可以将字符串从一个字符集转换为另一个字符集',	'CONVERT( string1, char_set_to , char_set_from )',	'string1：要转换的字符串。
char_set_to：要转换为的字符集。
char_set_from：可选的，要从中转换的字符集。', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('DECOMPOSE', '','返回一个Unicode字符串',	'COMPOSE( string )',	'string：用于创建Unicode字符串的输入值， 它可以是char，varchar2，nchar，nvarchar2，clob或nclob。', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('HEXTORAW', '','函数将 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型中包含十六进制数字的字符转换为 RAW 数据类型',	'HEXTORAW (char)',	'char：十六进制的字符串，字符串类型可为：CHAR、VARCHAR2、NCHAR 或 NVARCHAR2', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NUMTODSINTERVAL', '',	'函数把x转为interval day to second数据类型',	'numtodsinterval(x,c)' 	,'x是一个数字类型,c是一个字符串，常用的单位有 ("day","hour","minute","second")', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NUMTOYMINTERVAL', '',	'将x转为interval year to month数据类型',	'NUMTOYMINTERVAL(x,c)'	,'x是一个数字类型,c是一个字符串，常用的单位有"year","month"', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('RAWTOHEX', '',	'函数将二进制数转换为一个相应的十六进制表示的字符串',	'RAWTOHEX (raw)',	'raw:二进制的字符串', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ROWIDTOCHAR', '',	'转换rowid值为varchar2类型',	'ROWIDTOCHAR(rowid)',	'rowid,固定参数', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SCN_TO_TIMESTAMP', '',	'返回与该SCN关联的近似时间戳',	'scn_to_timestamp(number)'	,'number指的是系统当前生产的SCN', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TIMESTAMP_TO_SCN', '',	'以时间戳记值作为参数，并返回与该时间戳记关联的近似系统更改号',	'TIMESTAMP_TO_SCN(SCN)',	'参数是时间戳', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_BINARY_DOUBLE', '',	'函数返回一个双精度的 64 位浮点数',	'TO_BINARY_DOUBLE(expr , fmt , nlsparam)',	'expr：字符串或 NUMBER、BINARY_FLOAT 或 BINARY_DOUBLE 数值数据类型；fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_BINARY_FLOAT', '',	'函数返回一个单精度的 32 位浮点数',	'TO_BINARY_FLOAT(expr , fmt ，nlsparam)',	'expr：字符串或 NUMBER、BINARY_FLOAT 或 BINARY_DOUBLE 数值数据类型；fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_BLOB', '',	'将数据转换为BLOB值',	'TO_BLOB(raw_column)',	'raw_column为LONG RAW或RAW', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_CHAR(字符)', '',	'函数将 NCHAR、NVARCHAR2 或 CLOB 数据转换为数据库字符集',	'TO_CHAR(character )'	,'character：可以是 NCHAR、NVARCHAR2 或 CLOB 数据类型', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_CHAR(日期时间)', '',	'函数将 DATE、TIMESTAMP、TIMESTAMP WITH TIME ZONE、TIMESTAMP WITH LOCAL TIME ZONE、INTERVAL DAY TO SECOND 和 INTERVAL YEAR TO MONTH 等数据类型的值按照参数 fmt 指定的格式转换为 VARCHAR2 数据类型的值',	'TO_CHAR( datetime , fmt , nlsparam)',	'datetime：日期时间或间隔数据类型的值
fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_CHAR(数字)', '',	'函数将 NUMBER、BINARY_FLOAT 或 BINARY_DOUBLE 类型的数值 n 按照指定数值格式 fmt 转换为 varchar2 数据类型的值',	'TO_CHAR(n , fmt , nlsparam)',	'n：精确数值或近似数值数据类型类别的表达式。数值数据类型可以为 NUMBER、BINARY_FLOAT 或 BINARY_DOUBLE 数值数据类型；fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_CLOB', '',	'将数据转换为CLOB值',	'TO_CLOB（char）',	'char可以是任何数据类型CHAR，VARCHAR2，NCHAR，NVARCHAR2，CLOB，或NCLOB', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_DATE', '',	'函数将 CHAR、VARCHAR、NCHAR 或 NVARCHAR2 数据类型的字符转换为日期数据类型的值',	'DATE(char , fmt , nlsparam)',	'char	CHAR、VARCHAR、NCHAR 或 NVARCHAR2 字符数据；fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_DSINTERVAL', '',	'函数将一个 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串转换为一个 INTERVAL DAY TO SECOND 数据类型的值',	'TO_DSINTERVAL (days hours：minutes：seconds[.frac_secs])',	'days hours：minutes：seconds[.frac_secs]	：符合该参数格式的 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串。', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_LOB', '',	'将数据转换为LOB值',	'TO_LOB(char)',	'输入char是LONG或LONG RAW类型的变量', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_NUMBER', '',	'函数将 expr 转换为数值数据类型的值',	'TO_NUMBER(expr [, fmt [, "nlsparam" ] ])',	'expr 可以是 CHAR、VARCHAR2、NCHAR、NVARCHAR2、BINARY_FLOAT 或 BINARY_DOUBLE 数据类型的数值;fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_SINGLE_BYTE', '',	'将字符串中的全角转化为半角	','to_single_byte(c1)','c1,字符型', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_TIMESTAMP', '',	'将数据转化为timestamp类型',	'TO_TIMESTAMP(date)',	'date为字符', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_TIMESTAMP_TZ', '',	'函数将字符串转换为 TIMESTAMP WITH TIME ZONE 数据类型，包含时区信息',	'TO_TIMESTAMP_TZ (char，[fmt],["nlsparam"])',	'char	CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串，fmt 和 nlsparam 参数是可选', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('TO_YMINTERVAL', '',	'函数将一个 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串转换为一个 INTERVAL YEAR TO MONTH 数据类型的值',	'TO_YMINTERVAL (years-months)',	'years-months：符合该参数格式的 CHAR、VARCHAR2、NCHAR 或 NVARCHAR2 数据类型的字符串', @conversion_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 大对象函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('BFILENAME', '',	'函数返回一个空的BFILE位置值指示符，函数用于初始化BFILE变量或者是BFILE列',	'BFILENAME(dir,file)',	'dir是一个directory类型的对象，file为一文件名', @bigobject_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('EMPTY_BLOB，EMPTY_CLOB', '',	'返回一个空的LOB定位符，可用于初始化LOB变量，或者在INSERT或UPDATE语句中用于将LOB列或属性初始化为EMPTY','EMPTY_BLOB()','无参数', @bigobject_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 层次函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('SYS_CONNECT_BY_PATH', '',	'把一个父节点下的所有子节点通过某个字符进行区分，然后连接在一个列中显示',	'SYS_CONNECT_BY_PATH(string,flag)',	'string:字符串数据，flag:连接符', @level_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 数据挖掘函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('CLUSTER_DETAILS', '',	'返回选择中每一行的集群详细信息，返回值是一个XML字符串',	'CLUSTER_DETAILS(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CLUSTER_DISTANCE'	, '','返回选择中每一行的聚类距离',	'CLUSTER_DISTANCE(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CLUSTER_ID', '','返回选择中每一行的最高概率簇的标识符',	'CLUSTER_ID(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CLUSTER_PROBABILITY'	, '','选择中的每一行返回一个概率',	'CLUSTER_PROBABILITY(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CLUSTER_SET'	, '','选择中的每一行返回一组聚类ID和概率对',	'CLUSTER_SET(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FEATURE_DETAILS'	, '','返回选择中的每一行的功能细节',	'FEATURE_DETAILS(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FEATURE_ID', '','	返回选定内容中每一行的最高值特征的标识符',	'FEATURE_ID(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FEATURE_SET', '','	为选定内容中的每一行返回各个FEATURE ID和FEATURE值对',	'FEATURE_SET(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FEATURE_VALUE	', '','为所选内容中的每一行返回一个FEATURE值',	'FEATURE_VALUE(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION', '','返回选择中每一行的预测,返回的预测的数据类型取决于函数是否执行回归，分类或异常检测',	'PREDICTION(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION_BOUNDS', '', '应用广义线性模型（GLM）来预测选择中每一行的类或值',	'PREDICTION_BOUNDS(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION_COST', '', '返回选择中每一行的cost',	'PREDICTION_COST(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION_DETAILS', '', '返回选择中每一行的预测详细信息,返回值是描述预测属性的XML字符串',	'PREDICTION_DETAILS(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION_PROBABILITY', '','返回选择中每一行的概率',	'PREDICTION_PROBABILITY(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PREDICTION_SET',  '','对于选择中的每一行，返回一组具有概率或cost的预测',	'PREDICTION_SET(raw)',	'参数为行信息',@data_mining_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 编码和解码函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('DECODE', '','DECODE 函数依次用参数 search 与 condition 做比较，直至 condition 与 search 的值相等，则返回对应 search 后跟随的参数 result 的值。如果没有 search 与 condition 相等，则返回参数 default 的值。','DECODE (condition, search 1, result 1, search 2, result 2 ... search n, result n, default)',	'condition、search 1…search n、result 1…result n、default：数值型（NUMBER、FLOAT、BINARY_FLOAT 或 BINARY_DOUBLE）或字符型（ CHAR、VARCHAR2、NCHAR 或 NVARCHAR2）的表达式。', @encoding_decoding_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('DUMP', '',	'返回一个VARCHAR2值',	'DUMP(expr[,return_fmt[,start_position][,length]])',	'基本参数时4个，最少可以填的参数是0个。当完全没有参数时，直接返回null。另外3个参数也都有各自的默认值：
expr：这个参数是要进行分析的表达式（数字或字符串等，可以是各个类型的值）
return_fmt：指返回参数的格式，有5种用法：
          1）8：以8进制返回结果的值
          2）10：以10进制返回结果的值（默认）
          3）16：以16进制返回结果的值
          4）17：以单字符的形式返回结果的值
          5）1000：以上4种加上1000，表示在返回值中加上当前字符集
start_position：开始进行返回的字符位置
length：需要返回的字符长度', @encoding_decoding_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ORA_HASH', '',	'函数获取对应表达式的 HASH 值',	'ORA_HASH(expr , max_bucket , seed_value )',	'expr：通常为数据库表的列名，数据类型可以是数值类型、字符类型、日期时间类型 或 RAW 类型；
max_bucket	：可选的 max_bucket 参数确定哈希函数返回的最大桶数，取值范围为 0~4294967295，默认值是 4294967295；
seed_value：可选的 seed_value 参数使 OceanBase 能够为同一组数据产生许多不同的结果。 您可以指定 0~4294967295 之间的任何值。默认值为 0。', @encoding_decoding_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('VSIZE', '',	'函数返回 X 的字节大小数',	'VSIZE(X)'	,'各种数据类型。', @encoding_decoding_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);

-- 统计函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('AVG'	,'','函数返回数值列的平均值',	'AVG([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]',	'DISTINCT：查询时去除数据中的重复值，且忽略数据中的 NULL 值；
ALL：查询时不去除数据中的重复值，且忽略数据中的 NULL 值。ALL 为默认值。
Expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）或者可以转换成数值类型的表达式；
OVER：使用 OVER 子句定义窗口进行计算。',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('COUNT','',	'函数用于查询 expr 的行数',	'COUNT({ * | [ DISTINCT | ALL ] expr }) [ OVER (analytic_clause) ]',	'*：表示满足条件的所有行，且包含值为 NULL 的行
DISTINCT：返回的行中去除重复行，且忽略值为 NULL 的行
ALL：返回所有值，包含重复行，且忽略值为 NULL 的行
expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）或者可以转换成数值类型的表达式
OVER：使用 OVER 子句定义窗口进行计算。',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('SUM',	'','函数返回参数中指定列的和',	'SUM([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]','DISTINCT：去除重复行，且忽略值为 NULL 的行
ALL：返回所有值，包含重复行，且忽略值为 NULL 的行
expr：可为数值、字符、日期型或其它类型的数据列或表达式
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('MAX'	,'','函数返回参数中指定的列中的最大值',	'MAX([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]',	'DISTINCT：去除重复行，且忽略值为 NULL 的行
ALL：返回所有值，包含重复行，且忽略值为 NULL 的行
expr：可为数值、字符、日期型或其它类型的数据列或表达式
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('MIN',	'','函数返回参数中指定的列中的最小值',	'MIN([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]',	'DISTINCT：去除重复行，且忽略值为 NULL 的行
ALL：返回所有值，包含重复行，且忽略值为 NULL 的行
expr：可为数值、字符、日期型或其它类型的数据列或表达式
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LISTAGG',	'','LISTAGG函数用于列转行，LISTAGG 对 ORDER BY 子句中指定的每个组内的数据进行排序，然后合并度量列的值'	,'LISTAGG（measure_expr [,"delimiter"]）WITHIN GROUP (order_by_clause)[OVER query_partition_clause]',	'OVER：使用 OVER 子句定义窗口进行计算
measure_expr	：可以是任何表达式，度量列中的空值将被忽略
delimiter：指定用于分隔度量值的字符串，此子句是可选的，默认为 NULL',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('STDDEV','','函数用于计算总体标准差',	'STDDEV([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]',	'DISTINCT：去重关键字，表示计算唯一值的总体标准差
ALL：全部数值列
expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）或者可以转换成数值类型的表达式
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('STDDEV_POP','',	'函数计算总体标准差',	'STDDEV_POP(expr) [ OVER (analytic_clause) ]',	'OVER：使用 OVER 子句定义窗口进行计算
expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）的表达式。',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('STDDEV_SAMP','',	'函数计算样本标准差'	,'STDDEV_SAMP(expr) [ OVER (analytic_clause) ]',	'OVER：使用 OVER 子句定义窗口进行计算
expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）的表达式',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('VARIANCE','',	'函数返回参数指定列的方差',	'VARIANCE([ DISTINCT | ALL ] expr) [ OVER (analytic_clause) ]',	'DISTINCT：查询时去除列中的重复值，且忽略列中的 NULL 值；
ALL：查询时不去除列中的重复值，且忽略列中的 NULL 值，ALL 为默认值；
expr：可为数值、字符、日期型或其它类型的数据列或表达式
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('CUME_DIST','',	'计算一个值在一组值中的累积分布',	'CUME_DIST() OVER ([ query_partition_clause ] order_by_clause)',	'expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）或者可以转换成数值类型的表达式
{RESPECT | IGNORE} NULLS	：表示是否忽略 NULL 值。默认值为 RESPECT NULLS，考虑 NULL 值',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('DENSE_RANK','',	'计算有序行组中行的秩，并将秩作为 NUMBER 返回',	'DENSE_RANK( ) OVER([ query_partition_clause ] order_by_clause)',	'OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('FIRST_VALUE','',	'FIRST_VALUE 是一个分析函数，它返回有序值中的第一个值，如果集合中的第一个值为 NULL，则函数返回NULL',	'FIRST_VALUE { (expr) [ {RESPECT | IGNORE} NULLS ] | (expr [ {RESPECT | IGNORE} NULLS ]) } OVER (analytic_clause)',	'expr：参数类型不限
OVER：使用 OVER 子句定义窗口进行计算
{RESPECT | IGNORE} NULLS：表示是否忽略 NULL 值，默认值为 RESPECT NULLS，考虑 NULL 值
FROM { FIRST | LAST }：确定计算方向是从窗口的第一行还是最后一行开始，默认值为 FROM FIRST。如果您指定 IGNORE NULLS，则 FIRST_VALUE 返回集合中的第一个非空值，如果所有值都为 NULL，则返回 NULL。',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LAG',	'','LAG 是一个分析函数，它同时提供对多行表的访问，而不需要自连接，给定从查询返回的一系列行和游标的位置，LAG 可以访问位于该位置之前给定物理偏移量的行','LAG { (value_expr [,offset [,default]]) [RESPECT|IGNORE] NULLS
|(value_expr [RESPECT | IGNORE] NULLS [,offset [,default] ]) }
OVER([query_partition_clause] order_by_clause)',	'value_expr：是要做比对的字段。您不能使用 LAG 函数或其他分析函数来嵌套 value_expr
offset：是 value_expr 的可选参数偏移量
default：如果未指定默认值，则其默认值为 NULL，如果在 LEAD 没有显式的设置 default 值的情况下，返回值为 NULL
{RESPECT | IGNORE} NULLS：表示是否忽略 NULL 值，默认值为 RESPECT NULLS，考虑 NULL 值
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LAST_VALUE','',	'返回一组有序值中的最后一个值，如果集合中的最后一个值为 NULL，则该函数将返回为 NULL',	'LAST_VALUE {(expr) [RESPECT|IGNORE NULLS] | (expr [RESPECT|IGNORE NULLS])}OVER (analytic_clause)',	'OVER：使用 OVER 子句定义窗口进行计算
expr：不能将 LAST_VALUE 或其他分析函数用于 expr 来嵌套分析函数
FROM { FIRST | LAST }：确定计算方向是从窗口的第一行还是最后一行开始，默认值为 FROM FIRST
{RESPECT | IGNORE} NULLS：表示是否忽略 NULL 值，默认值为 RESPECT NULLS，考虑 NULL 值，如果您指定 IGNORE NULLS，则 LAST_VALUE 返回集合中的最后一个非空值，如果所有值都为 NULL，则返回 NULL',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LEAD','',	'LEAD 是一种分析函数，它提供了对表多行的访问，而无需进行自我连接。给定从查询返回的一些列行和光标的位置，LEAD 提供超出该位置的物理偏移量的行的访问','LEAD { (value_expr [,offset [,default]]) [RESPECT|IGNORE] NULLS
|(value_expr [RESPECT|IGNORE] NULLS [,offset [,default]]) }
OVER([query_partition_clause] order_by_clause)'	,'OVER：使用 OVER 子句定义窗口进行计算
offset：是 value_expr 的可选参数偏移量
default：如果未指定默认值，则其默认值为 null。如果在 LEAD 没有显式的设置 default 值的情况下，返回值为 NULL
{RESPECT | IGNORE} NULLS：表示是否忽略 NULL 值，默认值为 RESPECT NULLS，考虑 NULL 值
value_expr：是要做比对的字段。您不能使用 LEAD 函数或其他分析函数来嵌套 value_expr',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NTH_VALUE','',	'返回 analytic_clause 定义的窗口中第 n 行的 measure_expr 值',	'NTH_VALUE (measure_expr, n) [ FROM { FIRST | LAST } ][ { RESPECT | IGNORE } NULLS ] OVER (analytic_clause)',	'OVER：使用 OVER 子句定义窗口进行计算
measure_expr：字段名
n：n 为正数，确定要为其返回测量值的第 n 行，如果 n 是 NULL ，函数将返回错误，如果 n 大于窗口内所有的行数，函数返回 NULL
FROM { FIRST | LAST }：确定计算方向是从窗口的第一行还是最后一行开始，默认值为 FROM FIRST
{RESPECT | IGNORE} NULLS：表示是否忽略 NULL 值。默认值为 RESPECT NULLS，考虑 NULL 值',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NTILE'	,'','NTILE 函数将有序数据集划分为 expr 指示的若干桶，并为每一行分配适当的桶号',	'NTILE(expr) OVER ([query_partition_clause] order_by_clause)',	'expr：只能为正常数
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('PERCENT_RANK','',	'PERCENT_RANK 函数类似于 CUME_DIST（累积分布）函数，它的返回值范围为 0~1，任何集合中的第一行的 PERCENT_RANK 函数为 0，返回值为 NUMBER',	'PERCENT_RANK( ) OVER ([query_partition_clause] order_by_clause)',	'OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('RANK','',	'RANK 函数基于 OVER 子句中的 ORDER BY 表达式确定一组值的排名',	'RANK()  OVER ( [ PARTITION BY expr_list ] [ ORDER BY order_list ])',	'OVER：使用 OVER 子句定义窗口进行计算
PARTITION BY [col1, col2..]：指定开窗口的列
ORDER BY col1[asc | desc]：指定排名依据的值
expr_list：是数值类型或者可以转换成数值类型的类型
order_list：定义排名值参考的数据列',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('RATIO_TO_REPORT','',	'RATIO_TO_REPORT 函数计算一个值与一组值之和的比率',	'RATIO_TO_REPORT(expr) OVER ([query_partition_clause])',	'expr：只能为正常数
OVER：使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ROW_NUMBER','',	'ROW_NUMBER 函数为应用它的每一行分配一个唯一的数字（无论是分区中的每一行还是查询返回的每一行），按照order_by_clause 中指定的行的有序序列，从 1 开始，通过在检索指定范围的 ROW_NUMBER 的查询中使用子查询嵌套一个子查询，您可以从内部查询的结果中找到一个精确的行子集',	'ROW_NUMBER( ) OVER ([ query_partition_clause ] order_by_clause)',	'OVER	使用 OVER 子句定义窗口进行计算',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('ROLLUP','',	'ROLLUP 函数是聚合函数，它是 GROUP BY 语句的简单扩展，在数据统计和报表生成过程中，它可以为每个分组返回一个小计，同时为所有分组返回总计，效率比 GROUP BY 和 UNION 组合方法高',	'SELECT … GROUP BY ROLLUP(col1 [,col2...])',	'col1：进行分组操作的列名，列数指的是数据库中的行数',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('APPROX_COUNT_DISTINCT','',	'APPROX_COUNT_DISTINCT 函数是聚合函数，它对某一列去重后的行数进行计算，结果只能返回一个值，且该值是近似值，该函数可以进一步用于计算被引用的列的选择性',	'APPROX_COUNT_DISTINCT(expr)',	'expr：是数值类型（NUMBER、FLOAT、BINARY_FLOAT 和 BINARY_DOUBLE）或者可以转换成数值类型的表达式',@statistical_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);
-- 其他函数
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('COALESCE', '',	'函数返回参数列表中第一个非空表达式，必须指定最少两个参数',	'COALESCE(expr1, expr2[,…, exprn])',	'expr1, expr2[,…, exprn]为非空表达式，且最少 2 个',@other_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('LNNVL', '',	'LNNVL 函数判断条件中的一个或者两个操作数是否为 NULL',	'LNNVL(condition)',	'condition：条件',@other_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NULLIF', '',	'如果两个指定的表达式相等，则返回空值',	'NULLIF ( expression1 , expression2 )',	'参数expression1, expression2为常量、列名、函数、子查询或算术运算符、按位运算符以及字符串运算符的任意组合',@other_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NVL', '',	'函数从两个表达式返回一个非 NULL 值。如果 expr1 与 expr2 的结果皆为 NULL 值，则 NVL 函数返回 NULL',	'NVL(expr1, expr2)',	'expr1：表达式，数据类型可以是库内任意数据类型
expr2：表达式，数据类型可以是库内任意数据类型',@other_id, -1, -1, -1, -1, 1, 5, now(), now(), 0),
('NVL2', '',	'函数根据表达式是否为空，返回不同的值。如果 expr1 不为空，则返回 expr2 的值，如果 expr1 为空，则返回 expr3 的值。expr2 和 expr3 类型不同的话，expr3 会转换为 expr1 的类型。',	'NVL2(expr1, expr2, expr3)',	'expr1：表达式，数据类型可以是库内任意数据类型
expr2：表达式，数据类型可以是库内任意数据类型
expr3：表达式，数据类型可以是库内任意数据类型',@other_id, -1, -1, -1, -1, 1, 5, now(), now(), 0);

commit;
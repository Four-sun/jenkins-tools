begin;
-- 插入系统函数目录
-- 系统函数
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, '系统函数', -5, 5, 1, 6, now(), now(), -1, 0);

-- 插入系统函数的子节点 数值型函数 返回字符值的字符函数 返回数值的字符函数 字符集函数 日期时间函数 一般比较功能函数 转换功能函数 大对象函数 层次函数 数挖掘函数
-- 编码和解码函数  相关函数   统计函数
set @system_oracle_function_id=(select id from rdos_batch_catalogue where node_pid = -5 and engine_type = 6 limit 1);
INSERT INTO rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, order_val, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
VALUES
(-1, -1, 'Set Returning Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Window functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Advanced Aggregate Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'SQL String Functions and Operators', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Geometric Type Conversion Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'JSON Creation Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Aggregate Functions for Statistics', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'JSON Processing Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'General-Purpose Aggregate Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'JSON Aggregate Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Access Privilege Inquiry Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0),
(-1, -1, 'Date/Time Functions', @system_oracle_function_id, null, 2, 6, now(), now(), -1, 0);


-- 插入函数管理下的Oracle SQL目录
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
SELECT tenant_id, id as project_id, 'greenplum SQL',
       IFNULL((select id from rdos_batch_catalogue where node_name = '函数管理' and project_id = rdos_project.id), -1) as node_pid,
       1, 6, now(), now(), -1, 0
FROM rdos_project where is_deleted = 0 and status = 1;

-- 插入Oracle SQL目录下的系统函数
insert into rdos_batch_catalogue
(tenant_id, project_id, node_name, node_pid, level, engine_type, gmt_create, gmt_modified, create_user_id, is_deleted)
select tenant_id, project_id, '系统函数', id, 1, engine_type, now(), now(), create_user_id, 0
from rdos_batch_catalogue
where node_name = 'greenplum SQL';

-- 插入系统函数
set @no0=(select id from rdos_batch_catalogue where node_name='Set Returning Functions' AND engine_type = 6 AND is_deleted = 0);
set @no1=(select id from rdos_batch_catalogue where node_name='Window functions' AND engine_type = 6 AND is_deleted = 0);
set @no2=(select id from rdos_batch_catalogue where node_name='Advanced Aggregate Functions' AND engine_type = 6 AND is_deleted = 0);
set @no3=(select id from rdos_batch_catalogue where node_name='SQL String Functions and Operators' AND engine_type = 6 AND is_deleted = 0);
set @no4=(select id from rdos_batch_catalogue where node_name='Geometric Type Conversion Functions' AND engine_type = 6 AND is_deleted = 0);
set @no5=(select id from rdos_batch_catalogue where node_name='JSON Creation Functions' AND engine_type = 6 AND is_deleted = 0);
set @no6=(select id from rdos_batch_catalogue where node_name='Aggregate Functions for Statistics' AND engine_type = 6 AND is_deleted = 0);
set @no7=(select id from rdos_batch_catalogue where node_name='JSON Processing Functions' AND engine_type = 6 AND is_deleted = 0);
set @no8=(select id from rdos_batch_catalogue where node_name='General-Purpose Aggregate Functions' AND engine_type = 6 AND is_deleted = 0);
set @no9=(select id from rdos_batch_catalogue where node_name='JSON Aggregate Functions' AND engine_type = 6 AND is_deleted = 0);
set @no10=(select id from rdos_batch_catalogue where node_name='Access Privilege Inquiry Functions' AND engine_type = 6 AND is_deleted = 0);
set @no11=(select id from rdos_batch_catalogue where node_name='Date/Time Functions' AND engine_type = 6 AND is_deleted = 0);

-- Set Returning Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('generate_series(start, stop)', '', '', 'int or bigint	', 'Generate a series of values, from start to stop with a step size of one', @no0, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('generate_series(start, stop, step)	', '', '', 'int or bigint	', 'Generate a series of values, from start to stop with a step size of step', @no0, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('generate_series(start, stop, step interval)	', '', '', 'timestamp or timestamp with time zone	', 'Generate a series of values, from start to stop with a step size of step', @no0, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Window functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('cume_dist()	', '', '', 'CUME_DIST() OVER ( [PARTITION BY expr ] ORDER BY expr )', 'Calculates the cumulative distribution of a value in a group of values. Rows with equal values always evaluate to the same cumulative distribution value.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('dense_rank()', '', '', 'DENSE_RANK () OVER ( [PARTITION BY expr ] ORDER BY expr )	', 'Computes the rank of a row in an ordered group of rows without skipping rank values. Rows with equal values are given the same rank value.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('first_value(expr)	', '', '', 'FIRST_VALUE( expr ) OVER ( [PARTITION BY expr ] ORDER BY expr [ROWS|RANGE frame_expr ] )	', 'Returns the first value in an ordered set of values.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lag(expr [,offset] [,default])	', '', '', 'LAG( expr [, offset ] [, default ]) OVER ( [PARTITION BY expr ] ORDER BY expr )	', 'Provides access to more than one row of the same table without doing a self join. Given a series of rows returned from a query and a position of the cursor, LAG provides access to a row at a given physical offset prior to that position. The default offset is 1. default sets the value that is returned if the offset goes beyond the scope of the window. If default is not specified, the default value is null.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('last_value(expr)	', '', '', 'LAST_VALUE(expr) OVER ( [PARTITION BY expr] ORDER BY expr [ROWS|RANGE frame_expr] )	', 'Returns the last value in an ordered set of values.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lead(expr [,offset] [,default])	', '', '', 'LEAD(expr [,offset] [,exprdefault]) OVER ( [PARTITION BY expr] ORDER BY expr )	', 'Provides access to more than one row of the same table without doing a self join. Given a series of rows returned from a query and a position of the cursor, lead provides access to a row at a given physical offset after that position. If offset is not specified, the default offset is 1. default sets the value that is returned if the offset goes beyond the scope of the window. If default is not specified, the default value is null.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('ntile(expr)	', '', '', 'NTILE(expr) OVER ( [PARTITION BY expr] ORDER BY expr )	', 'Divides an ordered data set into a number of buckets (as defined by expr) and assigns a bucket number to each row.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('percent_rank()	', '', '', 'PERCENT_RANK () OVER ( [PARTITION BY expr] ORDER BY expr )	', 'Calculates the rank of a hypothetical row R minus 1, divided by 1 less than the number of rows being evaluated (within a window partition).', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('rank()	', '', '', 'RANK () OVER ( [PARTITION BY expr] ORDER BY expr )	', 'Calculates the rank of a row in an ordered group of values. Rows with equal values for the ranking criteria receive the same rank. The number of tied rows are added to the rank number to calculate the next rank value. Ranks may not be consecutive numbers in this case.', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('row_number()	', '', '', 'ROW_NUMBER () OVER ( [PARTITION BY expr] ORDER BY expr )	', 'Assigns a unique number to each row to which it is applied (either each row in a window partition or each row of the query).', @no1, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Advanced Aggregate Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('MEDIAN (expr)	', '', '', 'MEDIAN (expression)', 'Can take a two-dimensional array as input. Treats such arrays as matrices.', @no2, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('sum(array[])	', '', '', 'sum(array[[1,2],[3,4]])', 'Performs matrix summation. Can take as input a two-dimensional array that is treated as a matrix.', @no2, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pivot_sum (label[], label, expr)	', '', '', 'pivot_sum( array[A1,A2], attr, value)	', 'A pivot aggregation using sum to resolve duplicate entries.', @no2, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('unnest (array[])	', '', '', 'unnest( array[one, row, per, item])	', 'Transforms a one dimensional array into rows. Returns a set of anyelement, a polymorphic pseudo-type in PostgreSQL.', @no2, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- SQL String Functions and Operators--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('string || string	', '', '', 'Post || greSQL	', 'String concatenation	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('string || non-string or non-string || string	', '', '', 'Value:  || 42	', 'String concatenation with one non-string input	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('bit_length(string)	', '', '', 'bit_length(jose)	', 'Number of bits in string	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('char_length(string) or character_length(string)	', '', '', 'char_length(jose)	', 'Number of characters in string	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lower(string)	', '', '', 'lower(TOM)	', 'Convert string to lower case	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('octet_length(string)	', '', '', 'octet_length(jose)	', 'Number of bytes in string	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('overlay(string placing string from int [for int])	', '', '', 'overlay(Txxxxas placing hom from 2 for 4)	', 'Replace substring	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('position(substring in string)	', '', '', 'position(om in Thomas)	', 'Location of specified substring	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('substring(string [from int] [for int])	', '', '', 'substring(Thomas from 2 for 3)	', 'Extract substring	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('substring(string from pattern)	', '', '', 'substring(Thomas from ...$)	', 'Extract substring matching POSIX regular expression', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('substring(string from pattern for escape)	', '', '', 'substring(Thomas from %#o_a#_ for #)	', 'Extract substring matching SQL regular expression.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('trim([leading | trailing | both] [characters] from string)	', '', '', 'trim(both xyz from yxTomxx)	', 'Remove the longest string containing only characters from characters (a space by default) from the start, end, or both ends (both is the default) of string', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('trim([leading | trailing | both] [from] string [, characters] )	', '', '', 'trim(both from yxTomxx, xyz)	', 'Non-standard syntax for trim()	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('upper(string)	', '', '', 'upper(tom)	', 'Convert string to upper case	', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('ascii(string)', '', '', 'ascii(x)', 'ASCII code of the first character of the argument. For UTF8 returns the Unicode code point of the character. For other multibyte encodings, the argument must be an ASCII character.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('btrim(string text [, characters text])', '', '', 'btrim(xyxtrimyyx, xyz)', 'Remove the longest string consisting only of characters in characters (a space by default) from the start and end of string', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('chr(int)', '', '', 'chr(65)', 'Character with the given code. For UTF8 the argument is treated as a Unicode code point. For other multibyte encodings the argument must designate an ASCII character. The NULL (0) character is not allowed because text data types cannot store such bytes.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('concat(str any [, str any [, ...] ])', '', '', 'concat(abcde, 2, NULL, 22)', 'Concatenate the text representations of all the arguments. NULL arguments are ignored.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('concat_ws(sep text, str any [, str any [, ...] ])', '', '', 'concat_ws(,, abcde, 2, NULL, 22)', 'Concatenate all but the first argument with separators. The first argument is used as the separator string. NULL arguments are ignored.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('convert(string bytea, src_encoding name, dest_encoding name)', '', '', 'convert(text_in_utf8, UTF8, LATIN1)', 'Convert string to dest_encoding. The original encoding is specified by src_encoding. The string must be valid in this encoding. Conversions can be defined by CREATE CONVERSION. Also there are some predefined conversions. See Table 9-8 for available conversions.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('convert_from(string bytea, src_encoding name)', '', '', 'convert_from(text_in_utf8, UTF8)', 'Convert string to the database encoding. The original encoding is specified by src_encoding. The string must be valid in this encoding.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('convert_to(string text, dest_encoding name)', '', '', 'convert_to(some text, UTF8)', 'Convert string to dest_encoding.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('decode(string text, format text)', '', '', 'decode(MTIzAAE=, base64)', 'Decode binary data from textual representation in string. Options for format are same as in encode.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('encode(data bytea, format text)', '', '', 'encode(123\000\001, base64)', 'Encode binary data into a textual representation. Supported formats are: base64, hex, escape. escape converts zero bytes and high-bit-set bytes to octal sequences (\nnn) and doubles backslashes.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('format(formatstr text [, formatarg any [, ...] ])', '', '', 'format(Hello %s, %1$s, World)', 'Format arguments according to a format string. This function is similar to the C function sprintf. See Section 9.4.1.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('initcap(string)', '', '', 'initcap(hi THOMAS)', 'Convert the first letter of each word to upper case and the rest to lower case. Words are sequences of alphanumeric characters separated by non-alphanumeric characters.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('left(str text, n int)', '', '', 'left(abcde, 2)', 'Return first n characters in the string. When n is negative, return all but last |n| characters.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('length(string)', '', '', 'length(jose)', 'Number of characters in string', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('length(string bytea, encoding name )', '', '', 'length(jose, UTF8)', 'Number of characters in string in the given encoding. The string must be valid in this encoding.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lpad(string text, length int [, fill text])', '', '', 'lpad(hi, 5, xy)', 'Fill up the string to length length by prepending the characters fill (a space by default). If the string is already longer than length then it is truncated (on the right).', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('ltrim(string text [, characters text])', '', '', 'ltrim(zzzytest, xyz)', 'Remove the longest string containing only characters from characters (a space by default) from the start of string', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('md5(string)', '', '', 'md5(abc)', 'Calculates the MD5 hash of string, returning the result in hexadecimal', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_client_encoding()', '', '', 'pg_client_encoding()', 'Current client encoding name', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('quote_ident(string text)', '', '', 'quote_ident(Foo bar)', 'Return the given string suitably quoted to be used as an identifier in an SQL statement string. Quotes are added only if necessary (i.e., if the string contains non-identifier characters or would be case-folded). Embedded quotes are properly doubled. See also Example 40-1.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('quote_literal(string text)', '', '', 'quote_literal(EO\Reilly)', 'Return the given string suitably quoted to be used as a string literal in an SQL statement string. Embedded single-quotes and backslashes are properly doubled. Note that quote_literal returns null on null input; if the argument might be null, quote_nullable is often more suitable. See also Example 40-1.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('quote_literal(value anyelement)', '', '', 'quote_literal(42.5)', 'Coerce the given value to text and then quote it as a literal. Embedded single-quotes and backslashes are properly doubled.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('quote_nullable(string text)', '', '', 'quote_nullable(NULL)', 'Return the given string suitably quoted to be used as a string literal in an SQL statement string; or, if the argument is null, return NULL. Embedded single-quotes and backslashes are properly doubled. See also Example 40-1.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('quote_nullable(value anyelement)', '', '', 'quote_nullable(42.5)', 'Coerce the given value to text and then quote it as a literal; or, if the argument is null, return NULL. Embedded single-quotes and backslashes are properly doubled.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regexp_matches(string text, pattern text [, flags text])', '', '', 'regexp_matches(foobarbequebaz, (bar)(beque))', 'Return all captured substrings resulting from matching a POSIX regular expression against the string. See Section 9.7.3 for more information.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regexp_replace(string text, pattern text, replacement text [, flags text])', '', '', 'regexp_replace(Thomas, .[mN]a., M)', 'Replace substring(s) matching a POSIX regular expression. See Section 9.7.3 for more information.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regexp_split_to_array(string text, pattern text [, flags text ])', '', '', 'regexp_split_to_array(hello world, \s+)', 'Split string using a POSIX regular expression as the delimiter. See Section 9.7.3 for more information.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regexp_split_to_table(string text, pattern text [, flags text])', '', '', 'regexp_split_to_table(hello world, \s+)', 'Split string using a POSIX regular expression as the delimiter. See Section 9.7.3 for more information.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('repeat(string text, number int)', '', '', 'repeat(Pg, 4)', 'Repeat string the specified number of times', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('replace(string text, from text, to text)', '', '', 'replace(abcdefabcdef, cd, XX)', 'Replace all occurrences in string of substring from with substring to', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('reverse(str)', '', '', 'reverse(abcde)', 'Return reversed string.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('right(str text, n int)', '', '', 'right(abcde, 2)', 'Return last n characters in the string. When n is negative, return all but first |n| characters.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('rpad(string text, length int [, fill text])', '', '', 'rpad(hi, 5, xy)', 'Fill up the string to length length by appending the characters fill (a space by default). If the string is already longer than length then it is truncated.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('rtrim(string text [, characters text])', '', '', 'rtrim(testxxzx, xyz)', 'Remove the longest string containing only characters from characters (a space by default) from the end of string', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('split_part(string text, delimiter text, field int)', '', '', 'split_part(abc~@~def~@~ghi, ~@~, 2)', 'Split string on delimiter and return the given field (counting from one)', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('strpos(string, substring)', '', '', 'strpos(high, ig)', 'Location of specified substring (same as position(substring in string), but note the reversed argument order)', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('substr(string, from [, count])', '', '', 'substr(alphabet, 3, 2)', 'Extract substring (same as substring(string from from for count))', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('to_ascii(string text [, encoding text])', '', '', 'to_ascii(Karel)', 'Convert string to ASCII from another encoding (only supports conversion from LATIN1, LATIN2, LATIN9, and WIN1250 encodings)', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('to_hex(number int or bigint)', '', '', 'to_hex(2147483647)', 'Convert number to its equivalent hexadecimal representation', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('translate(string text, from text, to text)', '', '', 'translate(12345, 143, ax)', 'Any character in string that matches a character in the from set is replaced by the corresponding character in the to set. If from is longer than to, occurrences of the extra characters in from are removed.', @no3, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Geometric Type Conversion Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('box(circle)', '', '', 'box(circle ((0,0),2.0))', 'circle to box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('box(point, point)', '', '', 'box(point (0,0), point (1,1))', 'points to box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('box(polygon)', '', '', 'box(polygon ((0,0),(1,1),(2,0)))', 'polygon to box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('circle(box)', '', '', 'circle(box ((0,0),(1,1)))', 'box to circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('circle(point, double precision)', '', '', 'circle(point (0,0), 2.0)', 'center and radius to circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('circle(polygon)', '', '', 'circle(polygon ((0,0),(1,1),(2,0)))', 'polygon to circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('line(point, point)', '', '', 'line(point (-1,0), point (1,0))', 'points to line', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lseg(box)', '', '', 'lseg(box ((-1,0),(1,0)))', 'box diagonal to line segment', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('lseg(point, point)', '', '', 'lseg(point (-1,0), point (1,0))', 'points to line segment', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('path(polygon)', '', '', 'path(polygon ((0,0),(1,1),(2,0)))', 'polygon to path', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('point(double precision, double precision)', '', '', 'point(23.4, -44.5)', 'construct point', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('point(box)', '', '', 'point(box ((-1,0),(1,0)))', 'center of box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('point(circle)', '', '', 'point(circle ((0,0),2.0))', 'center of circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('point(lseg)', '', '', 'point(lseg ((-1,0),(1,0)))', 'center of line segment', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('point(polygon)', '', '', 'point(polygon ((0,0),(1,1),(2,0)))', 'center of polygon', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('polygon(box)', '', '', 'polygon(box ((0,0),(1,1)))', 'box to 4-point polygon', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('polygon(circle)', '', '', 'polygon(circle ((0,0),2.0))', 'circle to 12-point polygon', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('polygon(npts, circle)', '', '', 'polygon(12, circle ((0,0),2.0))', 'circle to npts-point polygon', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('polygon(path)', '', '', 'polygon(path ((0,0),(1,1),(2,0)))', 'path to polygon', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('area(object)', '', '', 'area(box ((0,0),(1,1)))', 'area', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('center(object)', '', '', 'center(box ((0,0),(1,2)))', 'center', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('diameter(circle)', '', '', 'diameter(circle ((0,0),2.0))', 'diameter of circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('height(box)', '', '', 'height(box ((0,0),(1,1)))', 'vertical size of box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('isclosed(path)', '', '', 'isclosed(path ((0,0),(1,1),(2,0)))', 'a closed path?', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('isopen(path)', '', '', 'isopen(path [(0,0),(1,1),(2,0)])', 'an open path?', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('length(object)', '', '', 'length(path ((-1,0),(1,0)))', 'length', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('npoints(path)', '', '', 'npoints(path [(0,0),(1,1),(2,0)])', 'number of points', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('npoints(polygon)', '', '', 'npoints(polygon ((1,1),(0,0)))', 'number of points', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pclose(path)', '', '', 'pclose(path [(0,0),(1,1),(2,0)])', 'convert path to closed', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('popen(path)', '', '', 'popen(path ((0,0),(1,1),(2,0)))', 'convert path to open', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('radius(circle)', '', '', 'radius(circle ((0,0),2.0))', 'radius of circle', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('width(box)', '', '', 'width(box ((0,0),(1,1)))', 'horizontal size of box', @no4, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- JSON Creation Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('to_json(anyelement)	', '', '', 'to_json(Fred said Hi.::text)	', 'Returns the value as a JSON object. Arrays and composites are processed recursively and are converted to arrays and objects. If the input contains a cast from the type to json, the cast function is used to perform the conversion; otherwise, a JSON scalar value is produced. For any scalar type other than a number, a Boolean, or a null value, the text representation will be used, properly quoted and escaped so that it is a valid JSON string.	', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('array_to_json(anyarray [, pretty_bool])	', '', '', 'array_to_json({{1,5},{99,100}}::int[])', 'Returns the array as a JSON array. A multidimensional array becomes a JSON array of arrays.
Line feeds will be added between dimension-1 elements if pretty_bool is true.', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('row_to_json(record [, pretty_bool])	', '', '', 'row_to_json(row(1,foo))	', 'Returns the row as a JSON object.
Line feeds will be added between level-1 elements if pretty_bool is true.', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_build_array(VARIADIC any)	', '', '', 'json_build_array(1,2,3,4,5)	', 'Builds a possibly-heterogeneously-typed JSON array out of a VARIADIC argument list.	', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_build_object(VARIADIC any)	', '', '', 'json_build_object(foo,1,bar,2)	', 'Builds a JSON object out of a VARIADIC argument list. The argument list is taken in order and converted to a set of key/value pairs.	', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_object(text[])	', '', '', 'json_object({a, 1, b, def, c, 3.5})

json_object({{a, 1},{b, def},{c, 3.5}})', 'Builds a JSON object out of a text array. The array must be either a one or a two dimensional array.
The one dimensional array must have an even number of elements. The elements are taken as key/value pairs.

For a two dimensional array, each inner array must have exactly two elements, which are taken as a key/value pair.', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_object(keys text[], values text[])	', '', '', 'json_object({a, b}, {1,2})	', 'Builds a JSON object out of a text array. This form of json_object takes keys and values pairwise from two separate arrays. In all other respects it is identical to the one-argument form.	', @no5, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Aggregate Functions for Statistics--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('corr(Y, X)', '', '', 'double precision', 'correlation coefficient', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('covar_pop(Y, X)', '', '', 'double precision', 'population covariance', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('covar_samp(Y, X)', '', '', 'double precision', 'sample covariance', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_avgx(Y, X)', '', '', 'double precision', 'average of the independent variable (sum(X)/N)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_avgy(Y, X)', '', '', 'double precision', 'average of the dependent variable (sum(Y)/N)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_count(Y, X)', '', '', 'bigint', 'number of input rows in which both expressions are nonnull', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_intercept(Y, X)', '', '', 'double precision', 'y-intercept of the least-squares-fit linear equation determined by the (X, Y) pairs', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_r2(Y, X)', '', '', 'double precision', 'square of the correlation coefficient', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_slope(Y, X)', '', '', 'double precision', 'slope of the least-squares-fit linear equation determined by the (X, Y) pairs', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_sxx(Y, X)', '', '', 'double precision', 'sum(X^2) - sum(X)^2/N (sum of squares of the independent variable)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_sxy(Y, X)', '', '', 'double precision', 'sum(X*Y) - sum(X) * sum(Y)/N (sum of products of independent times dependent variable)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('regr_syy(Y, X)', '', '', 'double precision', 'sum(Y^2) - sum(Y)^2/N (sum of squares of the dependent variable)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('stddev(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'historical alias for stddev_samp', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('stddev_pop(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'population standard deviation of the input values', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('stddev_samp(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'sample standard deviation of the input values', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('variance(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'historical alias for var_samp', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('var_pop(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'population variance of the input values (square of the population standard deviation)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('var_samp(expression)', '', '', 'double precision for floating-point arguments, otherwise numeric', 'sample variance of the input values (square of the sample standard deviation)', @no6, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- JSON Processing Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('json_array_length(json)', '', '', 'json_array_length([1,2,3,{f1:1,f2:[5,6]},4])	', 'Returns the number of elements in the outermost JSON array.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_each(json)', '', '', 'select * from json_each({a:foo, b:bar})	', 'Expands the outermost JSON object into a set of key/value pairs.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_each_text(json)', '', '', 'select * from json_each_text({a:foo, b:bar})	', 'Expands the outermost JSON object into a set of key/value pairs. The returned values will be of type text.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_extract_path(from_json json, VARIADIC path_elems text[])', '', '', 'Returns the JSON value pointed to by path_elems (equivalent to #> operator).	', 'json_extract_path({f2:{f3:1},f4:{f5:99,f6:foo}},f4)	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_extract_path_text(from_json json, VARIADIC path_elems text[])', '', '', 'json_extract_path_text({f2:{f3:1},f4:{f5:99,f6:foo}},f4, f6)	', 'Returns the JSON value pointed to by path_elems as text. Equivalent to #>> operator.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_object_keys(json)', '', '', 'json_object_keys({f1:abc,f2:{f3:a, f4:b}})	', 'Returns set of keys in the outermost JSON object.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_populate_record(base anyelement, from_json json)', '', '', 'select * from json_populate_record(null::myrowtype, {a:1,b:2})	', 'Expands the object in from_json to a row whose columns match the record type defined by base. See Note 1.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_populate_recordset(base anyelement, from_json json)', '', '', 'select * from json_populate_recordset(null::myrowtype, [{a:1,b:2},{a:3,b:4}])		', 'Expands the outermost array of objects in from_json to a set of rows whose columns match the record type defined by base. See Note 1.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_array_elements(json)', '', '', 'select * from json_array_elements([1,true, [2,false]])	', 'Expands a JSON array to a set of JSON values.', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_array_elements_text(json)', '', '', 'select * from json_array_elements_text([foo, bar])	', 'Expands a JSON array to a set of text values.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_typeof(json)', '', '', 'json_typeof(-123.4)	', 'Returns the type of the outermost JSON value as a text string. Possible types are object, array, string, number, boolean, and null. See Note 2.	', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_to_record(json)', '', '', 'select * from json_to_record({a:1,b:[1,2,3],c:bar}) as x(a int, b text, d text)', 'Builds an arbitrary record from a JSON object. See Note 1.
As with all functions returning record, the caller must explicitly define the structure of the record with an AS clause.', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_to_recordset(json)', '', '', 'select * from json_to_recordset([{a:1,b:foo},{a:2,c:bar}]) as x(a int, b text);', 'Builds an arbitrary set of records from a JSON array of objects See Note 1.
As with all functions returning record, the caller must explicitly define the structure of the record with an AS clause.', @no7, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- General-Purpose Aggregate Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('array_agg(expression)', '', '', 'array of the argument type', 'input values, including nulls, concatenated into an array', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('avg(expression)', '', '', 'numeric for any integer-type argument, double precision for a floating-point argument, otherwise the same as the argument data type', 'the average (arithmetic mean) of all non-null input values', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('bit_and(expression)', '', '', 'same as argument data type', 'the bitwise AND of all non-null input values, or null if none', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('bit_or(expression)', '', '', 'same as argument data type', 'the bitwise OR of all non-null input values, or null if none', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('bool_and(expression)', '', '', 'bool', 'true if all input values are true, otherwise false', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('bool_or(expression)', '', '', 'bool', 'true if at least one input value is true, otherwise false', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('count(*)', '', '', 'bigint', 'number of input rows', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('count(expression)', '', '', 'bigint', 'number of input rows for which the value of expression is not null', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('every(expression)', '', '', 'bool', 'equivalent to bool_and', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_agg(expression)', '', '', 'json', 'aggregates values, including nulls, as a JSON array', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_object_agg(name, value)', '', '', 'json', 'aggregates name/value pairs as a JSON object; values can be null, but not names', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('max(expression)', '', '', 'same as argument type', 'maximum value of expression across all non-null input values', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('min(expression)', '', '', 'same as argument type', 'minimum value of expression across all non-null input values', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('string_agg(expression, delimiter)', '', '', 'same as argument types', 'non-null input values concatenated into a string, separated by delimiter', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('sum(expression)', '', '', 'bigint for smallint or int arguments, numeric for bigint arguments, otherwise the same as the argument data type', 'sum of expression across all non-null input values', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('xmlagg(expression)', '', '', 'xml', 'concatenation of non-null XML values (see also Section 9.14.1.7)', @no8, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- JSON Aggregate Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('json_agg(record)	', '', '', 'record', 'Aggregates records as a JSON array of objects.', @no9, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('json_object_agg(name, value)	', '', '', '(any, any)	', 'Aggregates name/value pairs as a JSON object.', @no9, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Access Privilege Inquiry Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('has_any_column_privilege(user, table, privilege)', '', '', 'does user have privilege for any column of table', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_any_column_privilege(table, privilege)', '', '', 'does current user have privilege for any column of table', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_column_privilege(user, table, column, privilege)', '', '', 'does user have privilege for column', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_column_privilege(table, column, privilege)', '', '', 'does current user have privilege for column', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_database_privilege(user, database, privilege)', '', '', 'does user have privilege for database', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_database_privilege(database, privilege)', '', '', 'does current user have privilege for database', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_foreign_data_wrapper_privilege(user, fdw, privilege)', '', '', 'does user have privilege for foreign-data wrapper', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_foreign_data_wrapper_privilege(fdw, privilege)', '', '', 'does current user have privilege for foreign-data wrapper', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_function_privilege(user, function, privilege)', '', '', 'does user have privilege for function', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_function_privilege(function, privilege)', '', '', 'does current user have privilege for function', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_language_privilege(user, language, privilege)', '', '', 'does user have privilege for language', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_language_privilege(language, privilege)', '', '', 'does current user have privilege for language', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_schema_privilege(user, schema, privilege)', '', '', 'does user have privilege for schema', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_schema_privilege(schema, privilege)', '', '', 'does current user have privilege for schema', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_sequence_privilege(user, sequence, privilege)', '', '', 'does user have privilege for sequence', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_sequence_privilege(sequence, privilege)', '', '', 'does current user have privilege for sequence', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_server_privilege(user, server, privilege)', '', '', 'does user have privilege for foreign server', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_server_privilege(server, privilege)', '', '', 'does current user have privilege for foreign server', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_table_privilege(user, table, privilege)', '', '', 'does user have privilege for table', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_table_privilege(table, privilege)', '', '', 'does current user have privilege for table', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_tablespace_privilege(user, tablespace, privilege)', '', '', 'does user have privilege for tablespace', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_tablespace_privilege(tablespace, privilege)', '', '', 'does current user have privilege for tablespace', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_type_privilege(user, type, privilege)', '', '', 'does user have privilege for type', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('has_type_privilege(type, privilege)', '', '', 'does current user have privilege for type', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_has_role(user, role, privilege)', '', '', 'does user have privilege for role', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_has_role(role, privilege)', '', '', 'does current user have privilege for role', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_catalog', '', '', 'name of current database (called catalog in the SQL standard)', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_database()', '', '', 'name of current database', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_query()', '', '', 'text of the currently executing query, as submitted by the client (might contain more than one statement)', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_role', '', '', 'equivalent to current_user', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_schema[()]', '', '', 'name of current schema', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_schemas(boolean)', '', '', 'names of schemas in search path, optionally including implicit schemas', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_user', '', '', 'user name of current execution context', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('inet_client_addr()', '', '', 'address of the remote connection', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('inet_client_port()', '', '', 'port of the remote connection', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('inet_server_addr()', '', '', 'address of the local connection', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('inet_server_port()', '', '', 'port of the local connection', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_backend_pid()', '', '', 'Process ID of the server process attached to the current session', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_conf_load_time()', '', '', 'configuration load time', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_is_other_temp_schema(oid)', '', '', 'is schema another sessions temporary schema?', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_listening_channels()', '', '', 'channel names that the session is currently listening on', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_my_temp_schema()', '', '', 'OID of sessions temporary schema, or 0 if none', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_postmaster_start_time()', '', '', 'server start time', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('pg_trigger_depth()', '', '', 'current nesting level of PostgreSQL triggers (0 if not called, directly or indirectly, from inside a trigger)', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('session_user', '', '', 'session user name', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('user', '', '', 'equivalent to current_user', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('version()', '', '', 'PostgreSQL version information', '', @no10, -1, -1, -1, -1, 1, 6, now(), now(), 0);

-- Date/Time Functions--------------------------
INSERT INTO rdos_batch_function
(name, class_name, purpose, command_formate, param_desc, node_pid, tenant_id, project_id, create_user_id, modify_user_id, type, engine_type, gmt_create, gmt_modified, is_deleted)
VALUES
('age(timestamp, timestamp)', '', '', 'age(timestamp 2001-04-10, timestamp 1957-06-13)', 'Subtract arguments, producing a symbolic result that uses years and months, rather than just days', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('age(timestamp)', '', '', 'age(timestamp 1957-06-13)', 'Subtract from current_date (at midnight)', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('clock_timestamp()', '', '', '/', 'Current date and time (changes during statement execution); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_date', '', '', '/', 'Current date; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_time', '', '', '/', 'Current time of day; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('current_timestamp', '', '', '/', 'Current date and time (start of current transaction); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('date_part(text, timestamp)', '', '', 'date_part(hour, timestamp 2001-02-16 20:38:40)', 'Get subfield (equivalent to extract); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('date_part(text, interval)', '', '', 'date_part(month, interval 2 years 3 months)', 'Get subfield (equivalent to extract); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('date_trunc(text, timestamp)', '', '', 'date_trunc(hour, timestamp 2001-02-16 20:38:40)', 'Truncate to specified precision; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('date_trunc(text, interval)', '', '', 'date_trunc(hour, interval 2 days 3 hours 40 minutes)', 'Truncate to specified precision; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('extract(field from timestamp)', '', '', 'extract(hour from timestamp 2001-02-16 20:38:40)', 'Get subfield; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('extract(field from interval)', '', '', 'extract(month from interval 2 years 3 months)', 'Get subfield; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('isfinite(date)', '', '', 'isfinite(date 2001-02-16)', 'Test for finite date (not +/-infinity)', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('isfinite(timestamp)', '', '', 'isfinite(timestamp 2001-02-16 21:28:30)', 'Test for finite time stamp (not +/-infinity)', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('isfinite(interval)', '', '', 'isfinite(interval 4 hours)', 'Test for finite interval', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('justify_days(interval)', '', '', 'justify_days(interval 35 days)', 'Adjust interval so 30-day time periods are represented as months', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('justify_hours(interval)', '', '', 'justify_hours(interval 27 hours)', 'Adjust interval so 24-hour time periods are represented as days', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('justify_interval(interval)', '', '', 'justify_interval(interval 1 mon -1 hour)', 'Adjust interval using justify_days and justify_hours, with additional sign adjustments', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('localtime', '', '', '/', 'Current time of day; ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('localtimestamp', '', '', '/', 'Current date and time (start of current transaction); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('make_date(year int, month int, day int)', '', '', 'make_date(2013, 7, 15)', 'Create date from year, month and day fields', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('make_interval(years int DEFAULT 0, months int DEFAULT 0, weeks int DEFAULT 0, days int DEFAULT 0, hours int DEFAULT 0, mins int DEFAULT 0, secs double precision DEFAULT 0.0)', '', '', 'make_interval(days := 10)', 'Create interval from years, months, weeks, days, hours, minutes and seconds fields', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('make_time(hour int, min int, sec double precision)', '', '', 'make_time(8, 15, 23.5)', 'Create time from hour, minute and seconds fields', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('make_timestamp(year int, month int, day int, hour int, min int, sec double precision)', '', '', 'make_timestamp(2013, 7, 15, 8, 15, 23.5)', 'Create timestamp from year, month, day, hour, minute and seconds fields', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('make_timestamptz(year int, month int, day int, hour int, min int, sec double precision, [ timezone text ])', '', '', 'make_timestamptz(2013, 7, 15, 8, 15, 23.5)', 'Create timestamp with time zone from year, month, day, hour, minute and seconds fields. When timezone is not specified, then current time zone is used.', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('now()', '', '', '/', 'Current date and time (start of current transaction); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('statement_timestamp()', '', '', '/', 'Current date and time (start of current statement); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('timeofday()', '', '', '/', 'Current date and time (like clock_timestamp, but as a text string); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0),
('transaction_timestamp()', '', '', '/', 'Current date and time (start of current transaction); ', @no11, -1, -1, -1, -1, 1, 6, now(), now(), 0);
commit;
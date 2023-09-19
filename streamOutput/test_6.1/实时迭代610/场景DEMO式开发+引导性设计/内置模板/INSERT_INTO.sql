


-- name INSERT_INTO
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-06-01 16:15:24
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 INSERT INTO
--********************************************************************--
-- 定义数据源表
CREATE TABLE server_logs (
    client_ip STRING,
    client_identity STRING,
    userid STRING,
    user_agent STRING,
    log_time TIMESTAMP(3),
    request_line STRING,
    status_code STRING,
    size INT
) WITH (
    'connector' = 'faker',   
    'fields.client_ip.expression' = '#{Internet.publicIpV4Address}',
    'fields.client_identity.expression' =  '-',
    'fields.userid.expression' =  '-',
    'fields.user_agent.expression' = '#{Internet.userAgentAny}',
    'fields.log_time.expression' =  '#{date.past ''15'',''5'',''SECONDS''}',
    'fields.request_line.expression' = '#{regexify ''(GET|POST|PUT|PATCH){1}''} #{regexify ''(/search\.html|/login\.html|/prod\.html|cart\.html|/order\.html){1}''} #{regexify ''(HTTP/1\.1|HTTP/2|/HTTP/1\.0){1}''}',
    'fields.status_code.expression' = '#{regexify ''(200|201|204|400|401|403|301){1}''}',
    'fields.size.expression' = '#{number.numberBetween ''100'',''10000000''}'
);
-- 定义结果表，实际应用中会选择 Kafka、JDBC 等作为结果表
CREATE TABLE client_errors (
       log_time TIMESTAMP(3),
       request_line STRING,
       status_code STRING,
       size INT
) WITH (
       'connector' = 'stream-x'
);
    
-- 写入数据到结果表
INSERT INTO client_errors
     SELECT
       log_time,
       request_line,
       status_code,
       size
FROM server_logs
WHERE status_code SIMILAR TO '4[0-9][0-9]';


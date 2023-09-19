


-- name STATEMENT_SET_BAK1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-06-01 16:01:18
-- desc 
--********************************************************************--

-- Flink SQL 快速入门示例 Statement Set

--********************************************************************--

-- 定义数据源表

CREATE TABLE server_logs (
    client_ip       STRING,
    client_identity STRING,
    userid          STRING,
    user_agent      STRING,
    log_time        TIMESTAMP(3),
    request_line    STRING,
    status_code     STRING,
    size            INT,
    WATERMARK FOR log_time AS log_time - INTERVAL '30' SECONDS
) WITH (
       'connector' = 'faker',    -- Faker 连接器仅在 VVR-4.0.12 及以上支持
    'fields.client_ip.expression' = '#{Internet.publicIpV4Address}',
    'fields.client_identity.expression' =  '-',
    'fields.userid.expression' =  '-',
    'fields.user_agent.expression' = '#{Internet.userAgentAny}',
    'fields.log_time.expression' =  '#{date.past ''15'',''5'',''SECONDS''}',
    'fields.request_line.expression' = '#{regexify ''(GET|POST|PUT|PATCH){1}''} #{regexify ''(/search\.html|/login\.html|/prod\.html|cart\.html|/order\.html){1}''} #{regexify ''(HTTP/1\.1|HTTP/2|/HTTP/1\.0){1}''}',
    'fields.status_code.expression' = '#{regexify ''(200|201|204|400|401|403|301){1}''}',
    'fields.size.expression' = '#{number.numberBetween ''100'',''10000000''}'
);

-- 定义结果表1

CREATE TABLE aggregations1 (
    `browser`     STRING,
    `status_code` STRING,
    `end_time`    TIMESTAMP(3),
    `requests`    BIGINT NOT NULL
) WITH (
       'connector' = 'blackhole'
);


-- 定义结果表2

CREATE TABLE aggregations2 (
    `browser`     STRING,
    `status_code` STRING,
    `requests`    BIGINT NOT NULL
) WITH (
       'connector' = 'stream-x'
);



-- This is a shared view that will be used by both insert into statements

CREATE VIEW browsers AS 
    SELECT
    REGEXP_EXTRACT(user_agent,'[^\/]+') AS browser,
    status_code,
    log_time
FROM server_logs;



-- 封装多个INSERT INTO语句到一个STATEMENT SET语句中

BEGIN STATEMENT SET;

-- 5min窗口粒度聚合

INSERT INTO aggregations1

    SELECT
        browser,
        status_code,
        TUMBLE_ROWTIME(log_time, INTERVAL '5' MINUTE) AS end_time,
        COUNT(*) requests
FROM browsers
GROUP BY
    browser,
    status_code,
    TUMBLE(log_time, INTERVAL '5' MINUTE);

-- 1h窗口粒度聚合

INSERT INTO aggregations2

    SELECT
        browser,
        status_code,
        COUNT(*) requests
    FROM browsers
    GROUP BY
        browser,
        status_code,
        TUMBLE(log_time, INTERVAL '1' HOUR);
END;


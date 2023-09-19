


-- name Cascading_Window_Aggregation
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:57:55
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 级联窗口聚合
--********************************************************************--
CREATE TEMPORARY TABLE server_logs (
    log_time TIMESTAMP(3),
    client_ip STRING,
    client_identity STRING,
    userid STRING,
    request_line STRING,
    status_code STRING,
    size INT,
    WATERMARK FOR log_time AS log_time - INTERVAL '15' SECONDS -- 定义watermark
) WITH (
    'connector' = 'faker',   
    'fields.log_time.expression' =  '#{date.past ''15'',''5'',''SECONDS''}',
    'fields.client_ip.expression' = '#{Internet.publicIpV4Address}',
    'fields.client_identity.expression' =  '-',
    'fields.userid.expression' =  '-',
    'fields.request_line.expression' = '#{regexify ''(GET|POST|PUT|PATCH){1}''} #{regexify ''(/search\.html|/login\.html|/prod\.html|cart\.html|/order\.html){1}''} #{regexify ''(HTTP/1\.1|HTTP/2|/HTTP/1\.0){1}''}',
    'fields.status_code.expression' = '#{regexify ''(200|201|204|400|401|403|301){1}''}',
    'fields.size.expression' = '#{number.numberBetween ''100'',''10000000''}'
);
-- 1min聚合结果表
CREATE TEMPORARY TABLE avg_request_size_1m (
    window_start TIMESTAMP(3),
    window_end TIMESTAMP(3),
    avg_size BIGINT
) WITH (
    'connector' = 'blackhole'
);
-- 5min聚合结果表
CREATE TEMPORARY TABLE avg_request_size_5m (
    window_start TIMESTAMP(3),
    window_end TIMESTAMP(3),
    avg_size BIGINT
) WITH (
    'connector' = 'blackhole'
);
-- 1min窗口查询结果
CREATE VIEW server_logs_window_1m AS
SELECT 
    TUMBLE_START(log_time, INTERVAL '1' MINUTE) AS window_start,
    TUMBLE_ROWTIME(log_time, INTERVAL '1' MINUTE) AS window_end,
    SUM(size) AS total_size,
    COUNT(*) AS num_requests
FROM server_logs
    GROUP BY
    TUMBLE(log_time, INTERVAL '1' MINUTE);
-- 基于1min窗口查询结果，进行5min粒度窗口聚合
CREATE VIEW server_logs_window_5m AS
SELECT
    TUMBLE_START(window_end, INTERVAL '5' MINUTE) AS window_start,
    TUMBLE_ROWTIME(window_end, INTERVAL '5' MINUTE) AS window_end,
    SUM(total_size) AS total_size,
    SUM(num_requests) AS num_requests
FROM server_logs_window_1m
    GROUP BY
    TUMBLE(window_end, INTERVAL '5' MINUTE);
BEGIN STATEMENT SET;
-- 写入结果到1min窗口粒度结果表
INSERT INTO avg_request_size_1m SELECT
    window_start,
    window_end,
    total_size/num_requests AS avg_size
FROM server_logs_window_1m;
-- 写入结果到5min窗口粒度结果表
INSERT INTO avg_request_size_5m SELECT
    window_start,
    window_end,
    total_size/num_requests AS avg_size
FROM server_logs_window_5m;
END;


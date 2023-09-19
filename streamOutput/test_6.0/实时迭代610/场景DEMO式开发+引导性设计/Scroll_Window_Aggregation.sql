


-- name Scroll_Window_Aggregation
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:52:46
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 滚动窗口聚合
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.server_logs (
    client_ip STRING,
    client_identity STRING,
    userid STRING,
    request_line STRING,
    status_code STRING,
    log_time AS PROCTIME() -- 使用当前系统处理时间作为表的时间字段
) WITH (
    'connector' = 'faker',  
    'fields.client_ip.expression' = '#{Internet.publicIpV4Address}',
    'fields.client_identity.expression' =  '-',
    'fields.userid.expression' =  '-',
    'fields.log_time.expression' =  '#{date.past ''15'',''5'',''SECONDS''}',
    'fields.request_line.expression' = '#{regexify ''(GET|POST|PUT|PATCH){1}''} #{regexify ''(/search\.html|/login\.html|/prod\.html|cart\.html|/order\.html){1}''} #{regexify ''(HTTP/1\.1|HTTP/2|/HTTP/1\.0){1}''}',
    'fields.status_code.expression' = '#{regexify ''(200|201|204|400|401|403|301){1}''}'
);
-- 按 window_start, window_end 维度计算每分钟窗口上不同的 ip 数量
SELECT window_start, window_end, COUNT(DISTINCT client_ip) AS ip_addresses
    FROM TABLE(
        -- 定义1min滑动窗口
        TUMBLE(TABLE dt_catalog.dt_db.server_logs, DESCRIPTOR(log_time), INTERVAL '1' MINUTE))
    GROUP BY window_start, window_end;





-- name Sliding_Window_Aggregation
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:53:29
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 滑动窗口聚合
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.bids (
    bid_id STRING,
    currency_code STRING,
    bid_price DOUBLE,
    transaction_time TIMESTAMP(3),
    WATERMARK FOR transaction_time AS transaction_time - INTERVAL '5' SECONDS  -- 定义事件时间，允许的最大窗口延迟为5s
) WITH (
    'connector' = 'faker',   
    'fields.bid_id.expression' = '#{Internet.UUID}',
    'fields.currency_code.expression' = '#{regexify ''(EUR|USD|CNY)''}',
    'fields.bid_price.expression' = '#{Number.randomDouble ''2'',''1'',''150''}',
    'fields.transaction_time.expression' = '#{date.past ''30'',''SECONDS''}',
    'rows-per-second' = '100'
);
-- 定义1min 的滑动窗口，每隔 30s 滚动一次
SELECT window_start, window_end, currency_code, ROUND(AVG(bid_price),2) AS MovingAverageBidPrice
    FROM TABLE(
        HOP(TABLE dt_catalog.dt_db.bids, DESCRIPTOR(transaction_time), INTERVAL '30' SECONDS, INTERVAL '1' MINUTE))
    GROUP BY window_start, window_end, currency_code;


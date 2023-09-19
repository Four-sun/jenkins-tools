


-- name Accumulative_window_aggregation
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:54:01
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 累计窗口聚合
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
-- 商品销售订单表
CREATE TABLE dt_catalog.dt_db.orders (
     order_id    BIGINT, -- 订单I
     goods_id    BIGINT, -- 商品ID
     goods_sales DOUBLE, -- 商品销售额
     order_time  TIMESTAMP(3), -- 下单时间
       WATERMARK FOR order_time AS order_time - INTERVAL '5' SECONDS  -- 定义事件时间，允许的最大窗口延迟为5s
) WITH (
    'connector' = 'faker',   
    'fields.order_id.expression' = '#{number.numberBetween ''0'',''1000000000''}',
    'fields.goods_id.expression' = '#{number.numberBetween ''0'',''1000000000''}',
    'fields.goods_sales.expression' = '#{Number.randomDouble ''2'',''1'',''150''}',
    'fields.order_time.expression' = '#{date.past ''30'',''SECONDS''}',
    'rows-per-second' = '100'
);
-- 每分钟更新一次从零点开始截止到当前时刻的累计销售额
SELECT
    window_start,
    window_end, 
    SUM(goods_sales) as cumulate_gmv -- 当天累计销售额
FROM TABLE(
    -- 定义窗口最大长度为一天的累计窗口，窗口滚动步长为1分钟
    CUMULATE(
        TABLE dt_catalog.dt_db.orders,
        DESCRIPTOR(order_time),
        INTERVAL '1' MINUTES,
        INTERVAL '1' DAY))
GROUP BY window_start, window_end;


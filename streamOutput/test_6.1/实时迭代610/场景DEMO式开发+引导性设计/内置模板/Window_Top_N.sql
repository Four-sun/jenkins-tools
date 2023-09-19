


-- name Window_Top_N
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-06-01 17:07:04
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 窗口Top-N
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.orders (
    bidtime TIMESTAMP(3),
    price DOUBLE,
    item STRING,
    supplier STRING,
    WATERMARK FOR bidtime AS bidtime - INTERVAL '5' SECONDS  -- 定义watermark
) WITH (
  'connector' = 'faker',  
  'fields.bidtime.expression' = '#{date.past ''30'',''SECONDS''}',
  'fields.price.expression' = '#{Number.randomDouble ''2'',''1'',''150''}',
  'fields.item.expression' = '#{Commerce.productName}',
  'fields.supplier.expression' = '#{regexify ''(Alice|Bob|Carol|Alex|Joe|James|Jane|Jack)''}',
  'rows-per-second' = '100'
);
-- 取出销售排名前三的供应商
SELECT *
    FROM (
        -- 按窗口时间分区，按价格降序排序
        SELECT *, ROW_NUMBER() OVER (PARTITION BY window_start, window_end ORDER BY price DESC) as rownum
        FROM (
            -- 计算每个窗口内各个供应商的销售额
            SELECT window_start, window_end, supplier, SUM(price) as price, COUNT(*) as cnt
            FROM TABLE(
                TUMBLE(TABLE dt_catalog.dt_db.orders, DESCRIPTOR(bidtime), INTERVAL '10' MINUTES))
            GROUP BY window_start, window_end, supplier
        )
    ) WHERE rownum <= 3;


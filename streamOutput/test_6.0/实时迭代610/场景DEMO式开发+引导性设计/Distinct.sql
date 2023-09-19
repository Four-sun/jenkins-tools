


-- name distinct
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:59:38
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 去重
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.orders (
  id INT,
  order_time AS CURRENT_TIMESTAMP,
  WATERMARK FOR order_time AS order_time - INTERVAL '5' SECONDS
)
WITH (
  'connector' = 'datagen',
  'rows-per-second'='10',
  'fields.id.kind'='random',
  'fields.id.min'='1',
  'fields.id.max'='100'
);
-- 对于每个order_id，按事件时间去重，只保留最新时间的记录即可实现去重
SELECT
  order_id,
  order_time
FROM (
  SELECT id AS order_id,
         order_time,
                  -- 按事件时间升序排序
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY order_time) AS rownum
  FROM dt_catalog.dt_db.orders)
WHERE rownum = 1; -- 只取排名第一的记录，去重是Top-N的一种特例


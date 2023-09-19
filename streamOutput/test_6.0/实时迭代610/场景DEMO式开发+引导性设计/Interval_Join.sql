


-- name Interval_Join
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:02:45
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 Interval Join
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.orders (
  id INT,
  order_time AS TIMESTAMPADD(DAY, CAST(FLOOR(RAND()*(1-5+1)+5)*(-1) AS INT), CURRENT_TIMESTAMP)
) WITH (
  'connector' = 'datagen',
  'rows-per-second'='10',
  'fields.id.kind'='sequence',
  'fields.id.start'='1',
  'fields.id.end'='1000'
);
CREATE TABLE dt_catalog.dt_db.shipments (
  id INT,
  order_id INT,
  shipment_time AS TIMESTAMPADD(DAY, CAST(FLOOR(RAND()*(1-5+1)) AS INT), CURRENT_TIMESTAMP)
) WITH (
  'connector' = 'datagen',
  'rows-per-second'='5',
  'fields.id.kind'='random',
  'fields.id.min'='0',
  'fields.order_id.kind'='sequence',
  'fields.order_id.start'='1',
  'fields.order_id.end'='1000'
);
-- order表的每条数据会与shipments表过去三天至当前时刻时间范围内的数据进行join
SELECT
    o.id AS order_id,
    o.order_time,
    s.shipment_time,
    TIMESTAMPDIFF(DAY,o.order_time,s.shipment_time) AS day_diff
FROM dt_catalog.dt_db.orders o
         JOIN dt_catalog.dt_db.shipments s ON o.id = s.order_id
WHERE
    -- 时间 join 条件：shipments.shipment_time - INTERVAL '3' DAY <= orders.order_time < shipments.shipment_time
    o.order_time BETWEEN s.shipment_time - INTERVAL '3' DAY AND s.shipment_time;


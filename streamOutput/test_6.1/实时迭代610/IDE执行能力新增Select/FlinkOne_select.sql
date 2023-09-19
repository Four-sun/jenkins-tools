


-- name FlinkOne
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-06-01 15:50:16
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 创建表
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
-- 执行创建表 DDL
CREATE TABLE dt_catalog.dt_db.orders (
    order_uid  BIGINT,
    product_id BIGINT,
    price      DECIMAL(32, 2),
    order_time TIMESTAMP(3)
) WITH (
    'connector' = 'datagen'
);
-- 试试单独执行 SELECT 语句测试表是否正确创建：
SELECT * FROM dt_catalog.dt_db.orders;

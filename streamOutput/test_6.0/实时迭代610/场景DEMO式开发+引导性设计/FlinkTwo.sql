


-- name FlinkTwo
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:46:52
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 创建表
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
-- 执行创建临时表 DDL，不需要指定catalog.database
CREATE TABLE orders (
    order_uid  BIGINT,
    product_id BIGINT,
    price      DECIMAL(32, 2),
    order_time TIMESTAMP(3)
) WITH (
    'connector' = 'datagen'
);





-- name Time_Join
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:03:36
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 时态表Join
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
-- 使用主键约束和watermark来定义一张版本表，这张表可以是一个cdc表、upsert类型的kafka topic等
CREATE TABLE dt_catalog.dt_db.currency_rates (
    `currency_code` STRING,
    `eur_rate` DECIMAL(6,4),
    `rate_time` TIMESTAMP(3),
    WATERMARK FOR `rate_time` AS rate_time - INTERVAL '15' SECONDS, -- 定义事件时间
    PRIMARY KEY (currency_code) NOT ENFORCED -- 定义主键
) WITH (
    'connector' = 'faker',   
    'fields.currency_code.expression' = '#{Currency.code}',
    'fields.eur_rate.expression' = '#{Number.randomDouble ''4'',''0'',''10''}',
    'fields.rate_time.expression' = '#{date.past ''15'',''SECONDS''}',
    'rows-per-second' = '100'
);
     
-- 这是一个append-only类型的动态表，需要定义watermk
CREATE TABLE dt_catalog.dt_db.transactions (
    `id` STRING,
    `currency_code` STRING,
    `total` DECIMAL(10,2),
    `transaction_time` TIMESTAMP(3),
     WATERMARK FOR `transaction_time` AS transaction_time - INTERVAL '30' SECONDS --定义watermark
) WITH (
    'connector' = 'faker',   
    'fields.id.expression' = '#{Internet.UUID}',
    'fields.currency_code.expression' = '#{Currency.code}',
    'fields.total.expression' = '#{Number.randomDouble ''2'',''10'',''1000''}',
    'fields.transaction_time.expression' = '#{date.past ''30'',''SECONDS''}',
    'rows-per-second' = '100'
);
-- 当左右两张表的watermark对齐时，才会触发join动作，左右两张表都需要定义watermark
SELECT
    t.id,
    t.total * c.eur_rate AS total_eur,
    t.total,
    c.currency_code,
    t.transaction_time
FROM dt_catalog.dt_db.transactions t
    -- transactions表每条记录都与currency_rates表transaction_time时刻的汇率进行join
    JOIN dt_catalog.dt_db.currency_rates FOR SYSTEM_TIME AS OF t.transaction_time AS c
    -- 指定join key
    ON t.currency_code = c.currency_code;


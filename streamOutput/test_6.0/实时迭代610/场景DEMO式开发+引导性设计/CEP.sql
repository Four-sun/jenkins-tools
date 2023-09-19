


-- name CEP
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:02:01
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 模式检测CEP
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.subscriptions (
    id STRING,
    user_id INT,
    type STRING,
    start_date TIMESTAMP(3),
    end_date TIMESTAMP(3),
    payment_expiration TIMESTAMP(3),
    proc_time AS PROCTIME()
) WITH (
  'connector' = 'faker',   
  'fields.id.expression' = '#{Internet.uuid}',
  'fields.user_id.expression' = '#{number.numberBetween ''1'',''50''}',
  'fields.type.expression'= '#{regexify ''(basic|premium|platinum){1}''}',
  'fields.start_date.expression' = '#{date.past ''30'',''DAYS''}',
  'fields.end_date.expression' = '#{date.future ''15'',''DAYS''}',
  'fields.payment_expiration.expression' = '#{date.future ''365'',''DAYS''}'
);
SELECT *
FROM dt_catalog.dt_db.subscriptions
    MATCH_RECOGNIZE ( -- 按user_id分区，按处理时间proc_time升序排序
        PARTITION BY user_id
        ORDER BY proc_time
        MEASURES
            LAST(PREMIUM.type) AS premium_type,
            AVG(TIMESTAMPDIFF(DAY,PREMIUM.start_date,PREMIUM.end_date)) AS premium_avg_duration,
            BASIC.start_date AS downgrade_date
        AFTER MATCH SKIP PAST LAST ROW
        --模式: 一个或多个‘premium‘或’platinum‘订阅事件
        --对于相同的'user_id'，后面跟着一个'basic'订阅事件
        PATTERN (PREMIUM+ BASIC)
        DEFINE PREMIUM AS PREMIUM.type IN ('premium','platinum'),
            BASIC AS BASIC.type = 'basic');


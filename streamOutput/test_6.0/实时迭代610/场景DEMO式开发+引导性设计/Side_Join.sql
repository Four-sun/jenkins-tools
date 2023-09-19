


-- name Side_Join
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:04:28
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 维表Join
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.subscriptions (
    id STRING,
    user_id INT,
    type STRING,
    start_date TIMESTAMP(3),
    end_date TIMESTAMP(3),
    payment_expiration TIMESTAMP(3),
    proc_time AS PROCTIME() -- 这里需要定义处理时间属性
) WITH (
    'connector' = 'faker',   
    'fields.id.expression' = '#{Internet.uuid}',
    'fields.user_id.expression' = '#{number.numberBetween ''1'',''50''}',
    'fields.type.expression'= '#{regexify ''(basic|premium|platinum){1}''}',
    'fields.start_date.expression' = '#{date.past ''30'',''DAYS''}',
    'fields.end_date.expression' = '#{date.future ''365'',''DAYS''}',
    'fields.payment_expiration.expression' = '#{date.future ''365'',''DAYS''}'
);
-- 定义维表，为了示例能直接运行，这里使用faker 作为维表，实际应用中一般会使用JDBC、Redis、Hbase等作为维表
CREATE TABLE dt_catalog.dt_db.users (
    user_id INT PRIMARY KEY, -- 定义主键
    user_name VARCHAR(255) NOT NULL,
    age INT NOT NULL
) WITH (
    'connector' = 'faker',   
    'fields.user_id.expression' = '#{number.numberBetween ''1'',''10''}',
    'fields.user_name.expression' = '#{regexify ''(ron|jark|danny){1}''}',
    'fields.age.expression' = '#{number.numberBetween ''1'',''30''}'
);
SELECT
    id AS subscription_id,
    type AS subscription_type,
    age AS user_age,
    CASE
        WHEN age < 18 THEN 1
        ELSE 0
    END AS is_minor
FROM dt_catalog.dt_db.subscriptions usub
    -- subscriptions每条记录都使用当前系统时间与维表users中的最新数据进行join
    JOIN dt_catalog.dt_db.users FOR SYSTEM_TIME AS OF usub.proc_time AS u
    -- 指定join key
    ON usub.user_id = u.user_id;


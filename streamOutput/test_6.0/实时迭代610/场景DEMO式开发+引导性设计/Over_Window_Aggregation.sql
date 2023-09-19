


-- name Over_Window_Aggregation
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:57:17
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 OVER窗口聚合
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.temperature_measurements (
    measurement_time TIMESTAMP(3),
    city STRING,
    temperature FLOAT,
    WATERMARK FOR measurement_time AS measurement_time - INTERVAL '15' SECONDS -- 定义时间属性字段，OVER窗口排序时使用
) WITH (
    'connector' = 'faker',    -- Faker 连接器仅在 VVR-4.0.12 及以上支持
    'fields.measurement_time.expression' = '#{date.past ''15'',''SECONDS''}',
    'fields.temperature.expression' = '#{number.numberBetween ''0'',''50''}',
    'fields.city.expression' = '#{regexify ''(Chicago|Munich|Berlin|Portland|Hangzhou|Seatle|Beijing|New York){1}''}'
);
SELECT
    measurement_time,
    city,
    temperature,
    AVG(CAST(temperature AS FLOAT)) OVER last_minute AS avg_temperature_minute, -- 计算平均值
    MAX(temperature) OVER last_minute AS min_temperature_minute, -- 计算最大值
    MIN(temperature) OVER last_minute AS max_temperature_minute, -- 计算最小值
    STDDEV(CAST(temperature AS FLOAT)) OVER last_minute AS stdev_temperature_minute -- 计算标准差
FROM dt_catalog.dt_db.temperature_measurements
    WINDOW last_minute AS ( -- 定义1min时间间隔的OVER窗口，按城市粒度分区，温度测量值排序，每个元素都会触发一次计算
        PARTITION BY city
        ORDER BY measurement_time
        RANGE BETWEEN INTERVAL '1' MINUTE PRECEDING AND CURRENT ROW
    );





-- name Watermark
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 19:52:06
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 Watermark
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.doctor_sightings (
    doctor        STRING,
    sighting_time TIMESTAMP(3),
    -- 通过watermark把sighting_time标识为事件时间，定义最大的乱序时间：期望所有的记录在目击发生后的15秒内都到达。
    WATERMARK FOR sighting_time AS sighting_time - INTERVAL '15' SECONDS
) WITH (
    'connector' = 'faker',   
    'fields.doctor.expression' = '#{dr_who.the_doctors}',
    'fields.sighting_time.expression' = '#{date.past ''15'',''SECONDS''}'
);
SELECT
    doctor,
    -- 在滚动窗口中使用sighting_time字段
    TUMBLE_ROWTIME(sighting_time, INTERVAL '1' MINUTE) AS sighting_time,
    COUNT(*) AS sightings
FROM dt_catalog.dt_db.doctor_sightings
GROUP BY
    TUMBLE(sighting_time, INTERVAL '1' MINUTE),
    doctor;


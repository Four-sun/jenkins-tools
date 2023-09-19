


-- name Regular_Join
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:02:25
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 Regular Join
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.NOC (
    agent_id STRING,
    codename STRING
) WITH (
    'connector' = 'faker',   
    'fields.agent_id.expression' = '#{regexify ''(1|2|3|4|5){1}''}',
    'fields.codename.expression' = '#{superhero.name}',
    'number-of-rows' = '10'
);
CREATE TABLE dt_catalog.dt_db.RealNames (
    agent_id STRING,
    name STRING
) WITH (
    'connector' = 'faker',   
    'fields.agent_id.expression' = '#{regexify ''(1|2|3|4|5){1}''}',
    'fields.name.expression' = '#{Name.full_name}',
    'number-of-rows' = '10'
);
-- 使用agent_id作为两张表关联的条件，左右两边任何一张表来了新数据都会触发join动作
SELECT
    name,
    codename
FROM dt_catalog.dt_db.NOC t1
INNER JOIN dt_catalog.dt_db.RealNames t2 ON t1.agent_id = t2.agent_id;


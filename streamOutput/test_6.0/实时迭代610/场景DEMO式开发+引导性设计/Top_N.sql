


-- name Top_N
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 20:01:14
-- desc 
--********************************************************************--
-- Flink SQL 快速入门示例 Top-N
-- 该模版仅支持使用"执行"功能。如需"提交"运行，需要您增加 INSERT 相关逻辑
--********************************************************************--
CREATE TABLE dt_catalog.dt_db.spells_cast (
    wizard STRING,
    spell  STRING
) WITH (
  'connector' = 'faker',   
  'fields.wizard.expression' = '#{harry_potter.characters}',
  'fields.spell.expression' = '#{harry_potter.spells}'
);
-- 找出每个巫师最喜欢的两个法术
SELECT wizard, spell, times_cast
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY wizard ORDER BY times_cast DESC) AS row_num -- 按法术次数降序排序
    FROM (SELECT wizard, spell, COUNT(*) AS times_cast FROM dt_catalog.dt_db.spells_cast GROUP BY wizard, spell) -- 计算每个巫师施展的各种法术的次数
)
WHERE row_num <= 2;


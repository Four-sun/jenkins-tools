-- 删除原来的血缘存储表
drop table assets_column_lineage;
drop table assets_table_lineage;
drop table assets_lineage_column;
drop table assets_lineage_table;

-- 删除engine源关联表
drop table assets_external_data_source;

-- 对接中心源删除数据源表
drop table assets_data_source;
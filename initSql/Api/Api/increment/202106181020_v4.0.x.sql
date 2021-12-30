-- 增大表的字段长度
alter table da_api MODIFY column output_params longtext comment'输出参数配置';
alter table da_api_test MODIFY column output_params longtext comment'输出参数配置';
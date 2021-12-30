
-- fix 32746
-- 兼容旧版本的脏数据（query_time_out为null）

update da_api set query_time_out = 3 where id > 0 and  query_time_out is null;
update da_api_test set query_time_out = 3 where id > 0 and  query_time_out is null;
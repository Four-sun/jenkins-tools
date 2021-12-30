-- 修改老数据中es数据源的类型从11改为46
update da_api set data_src_type = 46 where data_src_type = 11;
update da_api_test set data_src_type = 46 where data_src_type = 11;
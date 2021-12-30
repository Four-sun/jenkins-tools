UPDATE da_dict SET is_deleted = 1 WHERE dict_value = 16;
UPDATE da_dict SET dict_value = 19 WHERE dict_value = 17;
UPDATE da_dict SET dict_value = 23 WHERE dict_value = 30;

UPDATE da_data_source SET type = 1 WHERE type = 16;
UPDATE da_data_source SET type = 19 WHERE type = 17;
UPDATE da_data_source SET type = 23 WHERE type = 30;

UPDATE da_api SET data_src_type = 1 WHERE data_src_type = 16;
UPDATE da_api SET data_src_type = 19 WHERE data_src_type = 17;
UPDATE da_api SET data_src_type = 23 WHERE data_src_type = 30;

UPDATE da_api_test SET data_src_type = 1 WHERE data_src_type = 16;
UPDATE da_api_test SET data_src_type = 19 WHERE data_src_type = 17;
UPDATE da_api_test SET data_src_type = 23 WHERE data_src_type = 30;

UPDATE da_row_permission_user_rel SET data_type = 1 WHERE data_type = 16;
UPDATE da_row_permission_user_rel SET data_type = 19 WHERE data_type = 17;
UPDATE da_row_permission_user_rel SET data_type = 23 WHERE data_type = 30;
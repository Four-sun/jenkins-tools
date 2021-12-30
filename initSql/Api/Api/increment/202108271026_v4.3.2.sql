begin;
-- 将原有已提交的api测试状态置为测试已通过
UPDATE da_api_test set page_test_status = 1 where `status` = 1;

insert into dt_gateway.da_api select id,cat_id,tenant_id,data_src_id,name,tableName,req_limit,resp_limit,api_type,status,api_desc,input_params,output_params,create_user_id,modify_user_id,gmt_create,gmt_modified,is_deleted,req_type,api_path,resp_page_size,param_cfg_type,allow_paging,config_sql,resp_json,data_src_type,original_host,original_path,original_port,original_method,error_code_list_json,error_resp_json,body_desc_json,api_version_code,wsdl_xml,save_wsdl_xml,protocol,contain_header,contain_page,project_id,query_time_out,test_status,is_secondary_release,cn_name,is_cache,cache_expiry_period,cache_expiry_date_cron,is_ignore_syntax_check,orchestration_flow,app_type,transfer_encrypt_type,content_type,contain_original_status,dtuic_tenant_id,data_center_id from da_api;
insert into dt_gateway.da_api_test select id,cat_id,tenant_id,data_src_id,name,tableName,req_limit,resp_limit,api_type,status,api_desc,input_params,output_params,create_user_id,modify_user_id,gmt_create,gmt_modified,is_deleted,req_type,api_path,resp_page_size,param_cfg_type,allow_paging,config_sql,resp_json,data_src_type,original_host,original_path,original_port,original_method,error_code_list_json,error_resp_json,body_desc_json,api_version_code,wsdl_xml,save_wsdl_xml,protocol,contain_header,contain_page,project_id,query_time_out,cn_name,is_cache,cache_expiry_period,cache_expiry_date_cron,is_ignore_syntax_check,orchestration_flow,page_test_status,app_type,transfer_encrypt_type,content_type,contain_original_status,dtuic_tenant_id,data_center_id from da_api_test;
insert into dt_gateway.da_api_apply select id,tenant_id,api_id,user_id,apply_content,reply_content,reply_time,status,gmt_create,gmt_modified,is_deleted,call_limit,begin_time,end_time,project_id,token,output_params from da_api_apply;
insert into dt_gateway.da_api_group_relation select id,tenant_id,project_id,group_id,relation_id,rate,gmt_create,gmt_modified,is_deleted from da_api_group_relation;
insert into dt_gateway.da_api_group_relation_test select id,tenant_id,project_id,group_id,relation_id,rate,gmt_create,gmt_modified,is_deleted from da_api_group_relation_test;
insert into dt_gateway.da_auth select id,tenant_id,source_id,source_type,app_key,app_secret,gmt_create,gmt_modified,is_deleted from da_auth;
insert into dt_gateway.da_function select id,tenant_id,project_id,catalogue_id,function_name,function_desc,content,input_param,version,status,test_status,is_secondary_release,gmt_create,gmt_modified,create_user_id,modify_user_id,is_deleted from da_function;
insert into dt_gateway.da_function_test select id,tenant_id,project_id,catalogue_id,function_name,function_desc,content,input_param,version,status,gmt_create,gmt_modified,create_user_id,modify_user_id,is_deleted,page_test_status from da_function_test;
insert into dt_gateway.da_invoke_log select id,user_id,api_id,biz_type,invoke_time,content,gmt_create,gmt_modified,app_sign,is_deleted,project_id from da_invoke_log;
insert into dt_gateway.da_invoke_count select id,user_id,invoke_time,api_id,count,execute_time,gmt_create,gmt_modified,is_deleted,app_sign,project_id from da_invoke_count;
insert into dt_gateway.da_row_permission select id,tenant_id,project_id,row_permission_name,modify_user_id,gmt_create,gmt_modified,is_deleted from da_row_permission;
insert into dt_gateway.da_row_permission_api_rel select id,tenant_id,project_id,api_id,row_permission_id,modify_user_id,gmt_create,gmt_modified,is_deleted from da_row_permission_api_rel;
insert into dt_gateway.da_row_permission_user_rel select id,tenant_id,project_id,user_id,row_permission_id,row_permission_val,data_type,data_source_id,table_name,table_column,modify_user_id,gmt_create,gmt_modified,is_deleted from da_row_permission_user_rel;
insert into dt_gateway.da_secret_key_info select id,tenant_id,user_id,public_key,private_key,gmt_create,gmt_modified,is_deleted from da_secret_key_info;
insert into dt_gateway.da_security_group select id,name,ip,simple_ip_text,type,tenant_id,modify_user_id,gmt_create,gmt_modified,is_deleted,project_id from da_security_group;
insert into dt_gateway.da_security_group_ref select id,group_id,api_id,tenant_id,gmt_create,gmt_modified,is_deleted from da_security_group_ref;
insert into dt_gateway.da_security_group_ref_test select id,group_id,api_id,tenant_id,gmt_create,gmt_modified,is_deleted from da_security_group_ref_test;
insert into dt_gateway.da_user_test_token select id,tenant_id,project_id,api_id,user_id,token,gmt_create,gmt_modified,is_deleted from da_user_test_token;
insert into dt_gateway.da_invoke_count_day select id,user_id,invoke_time,api_id,count,execute_time,gmt_create,gmt_modified,is_deleted,app_sign,project_id from da_invoke_count_day;
insert into dt_gateway.da_snapshot_api select id,api_id,invoke_total,sub_total,fail_total,gmt_create,gmt_modified,tenant_id,is_deleted,project_id from da_snapshot_api;
insert into dt_gateway.da_snapshot_err select id,api_id,user_id,biz_type,total_fail,fail_1d,fail_7d,fail_30d,gmt_create,gmt_modified,project_id from da_snapshot_err;
insert into dt_gateway.da_snapshot_invoke select id,user_id,api_id,invoke_total,fail_total,total_1d,fail_1d,total_7d,fail_7d,total_30d,fail_30d,gmt_create,gmt_modified,is_deleted,project_id from da_snapshot_invoke;
insert into dt_gateway.da_statistics_trigger select id,last_count_id,last_log_id,gmt_create,gmt_modified,is_deleted from da_statistics_trigger;
insert into dt_gateway.da_apply_invoke select id,user_id,api_id,invoke_total,gmt_create,gmt_modified,is_deleted,project_id from da_apply_invoke;
insert into dt_gateway.gw_api select id,serviceName,ip,port,is_group,token,app_type,gmt_create,gmt_modified,is_deleted from gw_api;
insert into dt_gateway.gw_api_group select id,api_id,serviceName,ip,port,rate,url,gmt_create,gmt_modified,is_deleted from gw_api_group;
insert into dt_gateway.gw_invoke_count select id,api_id,group_id,count,invoke_time,execute_time,app_sign,app_type,gmt_create,gmt_modified,is_deleted from gw_invoke_count;
insert into dt_gateway.gw_invoke_log select id,api_id,group_id,biz_type,invoke_time,content,app_sign,app_type,gmt_create,gmt_modified,is_deleted from gw_invoke_log;
insert into dt_gateway.gw_statistics_trigger select id,last_count_id,last_log_id,gmt_create,gmt_modified,is_deleted from gw_statistics_trigger;
insert into dt_gateway.gw_snapshot_api select id,api_id,app_type,group_id,invoke_total,sub_total,fail_total,gmt_create,gmt_modified,tenant_id,is_deleted from gw_snapshot_api;
insert into dt_gateway.gw_snapshot_invoke select id,api_id,app_type,group_id,invoke_total,fail_total,total_1d,fail_1d,total_7d,fail_7d,total_30d,fail_30d,gmt_create,gmt_modified,is_deleted from gw_snapshot_invoke;
insert into dt_gateway.gw_invoke_count_day select id,app_type,invoke_time,api_id,count,execute_time,gmt_create,gmt_modified,is_deleted,app_sign from gw_invoke_count_day;
insert into dt_gateway.gw_snapshot_err select id,api_id,app_type,biz_type,group_id,total_fail,fail_1d,fail_7d,fail_30d,gmt_create,gmt_modified,project_id from gw_snapshot_err;

drop table gw_api;
drop table gw_api_group;
drop table gw_invoke_count;
drop table gw_invoke_log;
drop table gw_statistics_trigger;
drop table gw_snapshot_api;
drop table gw_snapshot_invoke;
drop table gw_invoke_count_day;
drop table gw_snapshot_err;



drop table da_api;
drop table da_api_test;
drop table da_api_apply;
drop table da_api_group_relation;
drop table da_api_group_relation_test;
drop table da_auth;
drop table da_function;
drop table da_function_test;
drop table da_invoke_log;
drop table da_invoke_count;
drop table da_row_permission;
drop table da_row_permission_api_rel;
drop table da_row_permission_user_rel;
drop table da_secret_key_info;
drop table da_security_group;
drop table da_security_group_ref;
drop table da_security_group_ref_test;
drop table da_user_test_token;
drop table da_invoke_count_day;
drop table da_snapshot_api;
drop table da_snapshot_err;
drop table da_snapshot_invoke;
drop table da_statistics_trigger;
drop table da_apply_invoke;


-- 迁移定时任务到gateway
delete from dt_center_cron_schedule where job_detail_name in ('apiInvokeCalculateJob', 'apiInvokeCountDayJob');
commit;

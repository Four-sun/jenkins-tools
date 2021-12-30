-- dsc_info表ADB_PostgreSQL dataType改名为AnalyticDB PostgreSQL
update dsc_info set data_type = 'AnalyticDB PostgreSQL' where data_type_code = 54;


-- dsc_info表AnalyticDB dataType改名为AnalyticDB MySQL
update dsc_info set data_type = 'AnalyticDB MySQL' where data_type_code = 15;

-- dsc_type表AnalyticDB dataType改名为AnalyticDB MySQL
update dsc_type set data_type = 'AnalyticDB PostgreSQL' where data_type = 'ADB_PostgreSQL';
update dsc_type set data_type = 'AnalyticDB MySQL'  where data_type = 'AnalyticDB';

-- dsc_app_mapping表AnalyticDB dataType改名为AnalyticDB MySQL
update dsc_app_mapping set data_type = 'AnalyticDB PostgreSQL' where data_type = 'ADB_PostgreSQL';
update dsc_app_mapping set data_type = 'AnalyticDB MySQL' where data_type = 'AnalyticDB';



-- dsc_form_field表修改AnalyticDB dataType的type_version和ADB_PostgreSQL的type_version
update dsc_form_field set type_version = 'AnalyticDB PostgreSQL' where type_version = 'ADB_PostgreSQL';

update dsc_form_field set type_version = 'AnalyticDB MySQL' where type_version = 'AnalyticDB';


-- 4.2版本隐藏Doris、Kylin URL数据源
delete  from dsc_type where data_type = "Doris";
delete  from dsc_type where data_type = "Kylin URL";
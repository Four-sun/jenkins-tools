-- 删除实时模块权限点
update rdos_permission set is_deleted = 1 where code in
("datadevelop_stream",
"datadevelop_stream_resourcemanager",
"datadevelop_stream_functionmanager",
"datadevelop_stream_taskmanager",
"datadevelop_stream_taskmanager_query",
"datadevelop_stream_taskmanager_edit",
"datadevelop_stream_taskmanager_publish",
"maintenance_pandect_stream",
"maintenance_stream",
"maintenance_stream_query",
"maintenance_alarm_custom_stream",
"maintenance_alarm_custom_stream_edit",
"maintenance_alarm_custom_stream_query",
"maintenance_alarm_record_stream"
);


update rdos_role_permission set is_deleted = 1 where permission_id in (select id from rdos_permission where code in
("datadevelop_stream",
"datadevelop_stream_resourcemanager",
"datadevelop_stream_functionmanager",
"datadevelop_stream_taskmanager",
"datadevelop_stream_taskmanager_query",
"datadevelop_stream_taskmanager_edit",
"datadevelop_stream_taskmanager_publish",
"maintenance_pandect_stream",
"maintenance_stream",
"maintenance_stream_query",
"maintenance_alarm_custom_stream",
"maintenance_alarm_custom_stream_edit",
"maintenance_alarm_custom_stream_query",
"maintenance_alarm_record_stream"
));


delete from dt_pub_service.auth_project where app_type = 4;

-- 迁移project数据
insert into
	dt_pub_service.auth_project
	(project_id, dtuic_tenant_id, app_type, project_name, project_alias, project_identifier, project_desc,
	status, create_user_id, gmt_create, gmt_modified, is_deleted)
select
	dp.id, dp.tenant_id, 4, dp.project_name, dp.project_alias, dp.project_identifier, dp.project_desc,
	1, du.dtuic_user_id, dp.create_at, dp.update_at, 0
from tagapp.dl_project dp
left join tagapp.dl_user du on dp.create_by = du.id
where dp.is_deleted = 0;
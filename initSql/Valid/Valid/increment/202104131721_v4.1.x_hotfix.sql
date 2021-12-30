-- 处理权限code问题
delete from dq_permission where id in (40,41);
delete from dq_permission where code in ('project','project_edit','project_edit_edit','project_edit_query');
insert into dq_permission VALUES
('40','project','项目管理','项目管理','1','1',now(),now(),'0'),
('41','project_edit','项目管理_配置','项目管理_配置','40','1',now(),now(),'0');

delete from dq_role_permission
where permission_id in (
    select id from dq_permission
    where code in ('project','project_edit','project_edit_edit','project_edit_query')
);
-- 添加租户所有者项目管理权限
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p
WHERE r.role_value in (1,2,5) and p.code in ('project','project_edit');
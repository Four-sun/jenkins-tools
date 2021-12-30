begin;
set @a = (select id from dq_permission WHERE code = 'system_member');
INSERT INTO dq_permission (code,name,display,parent_id,type) VALUES
('system_member_query','系统管理_成员管理_查看','查看',@a,1);
COMMIT;

insert into dq_role_permission (role_id,permission_id) VALUES
((select id from dq_role where role_value = 1),
(select id from dq_permission WHERE code = 'system_member_query'));
insert into dq_role_permission (role_id,permission_id) VALUES
((select id from dq_role where role_value = 2),
(select id from dq_permission WHERE code = 'system_member_query'));
insert into dq_role_permission (role_id,permission_id) VALUES
((select id from dq_role where role_value = 3),
(select id from dq_permission WHERE code = 'system_member_query'));
insert into dq_role_permission (role_id,permission_id) VALUES
((select id from dq_role where role_value = 4),
(select id from dq_permission WHERE code = 'system_member_query'));
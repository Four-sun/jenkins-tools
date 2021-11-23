
-- 使用超级管理员当作租户创建者，需要确认超级管理员用户id
-- 需要
-- 存在租户所有者被修改的情况。
UPDATE  dq_tenant dt
 join (select max(dru.user_id) as user_id,dru.tenant_id,dr.id,dr.role_value from dq_role_user dru join dq_role dr on dru.role_id = dr.id where dr.role_value = 1 group by dru.tenant_id) tmp
 on dt.id = tmp.tenant_id
 set create_user_id = tmp.user_id;

-- 项目表
--
-- Table structure for table `dq_project`
--

-- DROP TABLE IF EXISTS dq_project;
CREATE TABLE dq_project (
  id int NOT NULL AUTO_INCREMENT COMMENT 'id',
  tenant_id int NOT NULL COMMENT '租户id',
  project_name varchar(128) NOT NULL COMMENT '项目名',
  project_alias varchar(512) NOT NULL COMMENT '表中文名',
  project_Identifier varchar(256) DEFAULT NULL COMMENT '项目标识',
  project_desc varchar(2048) DEFAULT NULL COMMENT '项目描述',
	status tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  create_user_id int(11) NOT NULL COMMENT '新建项目的用户id',
  gmt_create datetime NOT NULL  COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  COMMENT '最后修改时间',
  is_deleted tinyint NOT NULL DEFAULT '0' COMMENT '是否删除，0未删除 1删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目表';

-- 项目置顶表
--
-- Table structure for table dq_project_stick
--
-- DROP TABLE IF EXISTS dq_project_stick;
CREATE TABLE dq_project_stick (
  id int NOT NULL AUTO_INCREMENT COMMENT ' 自增id ',
  tenant_id int NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int NOT NULL DEFAULT '1' COMMENT '项目id',
  user_id int NOT NULL COMMENT '用户id',
  stick datetime DEFAULT NULL COMMENT '置顶字段',
  gmt_create datetime NOT NULL  COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint NOT NULL DEFAULT '0' COMMENT '是否删除，0未删除 1删除',
  PRIMARY KEY (id),
  UNIQUE KEY `idx_project_user_role` (`tenant_id`,`project_id`,`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';

-- 3.修改表-记录表（dq_table）
ALTER TABLE dq_table ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  data_source_id;

-- 4.修改表-角色用户关联表（dq_role_user）
ALTER TABLE dq_role_user ADD project_id int NOT NULL DEFAULT '-1' COMMENT '项目ID' AFTER user_id;

-- 5.修改表-角色表（dq_role）
ALTER TABLE dq_role ADD project_id int NOT NULL DEFAULT '0' COMMENT '项目ID' AFTER tenant_id;

-- 6.修改表-数据源表（dq_data_source）
ALTER TABLE dq_data_source ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 7.修改表-数据源关联表（dq_data_source_ref）
ALTER TABLE dq_data_source_ref ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 8.修改表-监控对象表（dq_monitor）
ALTER TABLE dq_monitor ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER table_id;

-- 9.修改表-监控数据表（dq_monitor_data）
ALTER TABLE dq_monitor_data ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  monitor_id;

-- 10.修改表-监控记录表（dq_monitor_record）
ALTER TABLE dq_monitor_record ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  monitor_id;

-- 11.修改表-记录规则表（dq_monitor_record_rules）
ALTER TABLE dq_monitor_record_rules ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  rule_id;

-- 12.修改表-监控表（dq_monitor_rule）
ALTER TABLE dq_monitor_rule ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  monitor_id;

-- 13.修改表-通知表（dq_notify）
ALTER TABLE dq_notify ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  tenant_id;

-- 14.修改表-消息记录表（dq_notify_record）
ALTER TABLE dq_notify_record ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER  notify_id;

-- 15.修改表-通知记录表（dq_notify_send_record）
ALTER TABLE dq_notify_send_record ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 16.修改表-通知与接受人关系表（dq_notify_user）
ALTER TABLE dq_notify_user ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 17.修改表-校验表（dq_verify）
ALTER TABLE dq_verify ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 18.修改表-校验记录表（dq_verify_record）
ALTER TABLE dq_verify_record ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 19.修改表-校验报告表（dq_verify_report）
ALTER TABLE dq_verify_report ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER tenant_id;

-- 20.修改表-订阅表（dq_subscribe）
ALTER TABLE dq_subscribe ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER table_id;

-- 21.修改表-监控对象的远程触发信息表（dq_remote_trigger）
ALTER TABLE dq_remote_trigger ADD project_id int NOT NULL DEFAULT '1' COMMENT '项目ID' AFTER monitor_id;

UPDATE dq_role SET role_name='项目管理员', role_desc='项目空间管理者，可使用项目空间全部功能。项目管理员不能对项目所有者操作。' WHERE role_name='产品管理员';
 INSERT INTO dq_role(`tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `modify_user_id`, `gmt_create`, `gmt_modified`, `is_deleted`)
 VALUES (-1, 1, '项目所有者', 1, 5, '项目空间所有者，拥有项目空间内的最高权限，可对项目空间中的全部资源和用户进行管理。', 0, NOW(), NOW(), 0);


update dq_permission set name='项目管理',display='项目管理' where code='system';
insert into dq_permission(code,name,display,parent_id)
select 'project' as code,'项目配置' as name,'项目配置' as display,id from dq_permission where code='system';
insert into dq_permission(code,name,display,parent_id)
select 'project_edit_query' as code,'查看' as name,'查看' as display,id from dq_permission where code='project';
insert into dq_permission(code,name,display,parent_id)
select 'project_edit_edit' as code,'编辑' as name,'编辑' as display,id from dq_permission where code='project';

update dq_permission set name='编辑',display='编辑' where code='project_edit_edit';

INSERT INTO dq_role_permission(role_id,permission_id)
select
 id as role_id,
 '40' as permission_id
 from dq_role where tenant_id=-1 and project_id=-1 and role_value=5;

INSERT INTO
    dq_project(
        tenant_id,
        project_name,
        project_alias,
        project_Identifier,
        project_desc,
        `status`,
        create_user_id,
        gmt_create,
        gmt_modified,
        is_deleted
    )
 select
    DISTINCT dt.id as tenant_id,
    'Default_Product' as project_name,
    '默认项目' as project_alias,
    'Default_Product' as project_Identifier,
    '' as project_desc,
    1 as `status`,
    ru.user_id as create_user_id,
    dt.gmt_create as gmt_create,
    dt.gmt_modified as gmt_modified,
    dt.is_deleted as is_deleted
from
    dq_tenant dt left join dq_role_user ru on ru.tenant_id = dt.id left join dq_role dr on dr.id = ru.role_id
		where dr.role_value = 1
		GROUP BY dt.id;

-- 1.数据源
UPDATE
    dq_data_source a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 2.数据源关联
UPDATE
    dq_data_source_ref a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 3.监控对象
UPDATE
    dq_monitor a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 4.监控数据
UPDATE
    dq_monitor_data a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 5.监控记录
UPDATE
    dq_monitor_record a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 6.监控记录规则
UPDATE
    dq_monitor_record_rules a
    join  dq_monitor_record b on a.record_id = b.id
set
   a.project_id = b.project_id;
-- 7.监控规则
UPDATE
    dq_monitor_rule a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 8.通知表
UPDATE
    dq_notify a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 9.消息记录
UPDATE
    dq_notify_record a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 10.通知记录
UPDATE
    dq_notify_send_record a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 11.通知人与接受人关系
UPDATE
    dq_notify_user a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 12.远程触发
UPDATE
    dq_remote_trigger a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 13.角色表
UPDATE
    dq_role a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 14.角色用户关联
UPDATE
    dq_role_user a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 15.订阅表
UPDATE
    dq_subscribe a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 16.存储的表
UPDATE
    dq_table a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 17.校验表
UPDATE
    dq_verify a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 18.校验记录
UPDATE
    dq_verify_record a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;
-- 19.校验报告
UPDATE
    dq_verify_report a
    join dq_project b on a.tenant_id = b.tenant_id
set
   a.project_id = b.id;

-- 默认项目默认置顶
insert into dq_project_stick(
  `tenant_id`,
  `project_id`,
  `user_id`,
  `stick`,
  `gmt_create`,
  `gmt_modified`,
  `is_deleted`

  ) select
  tenant_id,
  id as project_id,
  create_user_id as user_id,
  now(),
  now(),
  now(),
  0
  from dq_project where project_identifier = 'Default_Product';

-- 默认项目添加角色
INSERT INTO dq_role(tenant_id, project_id, role_name, role_type, role_value, role_desc, modify_user_id)
SELECT p.tenant_id,p.id,r.role_name,r.role_type,r.role_value,r.role_desc,p.create_user_id from dq_project p,dq_role r
WHERE p.project_name='Default_Product' AND r.tenant_id='-1' AND p.id <> 1;

-- 给租户所有者添加项目管理员
-- 给租户所有者添加项目管理员
INSERT INTO dq_role_user ( tenant_id, role_id, user_id, project_id )
SELECT
if(dss.tenant_id=-1,41,dss.tenant_id) as tenant_id,
dss.role_id,
IFNULL(da.create_user_id,11) AS user_id,
dss.project_id
FROM
	(
	SELECT
		dr.id AS role_id,
		dr.tenant_id AS tenant_id,
		dr.role_name AS role_name,
		dr.project_id AS project_id
	FROM
		dq_role AS dr
	WHERE
		dr.role_value = 5
	) AS dss
	LEFT JOIN dq_tenant da ON da.id = dss.tenant_id;

-- 添加项目所有者角色权限信息
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id,p.id FROM dq_role r, dq_permission p WHERE r.role_value = 5 and p.code in( 'datasource','datasource_query','datasource_edit','message','message_edit','message_query',
'verify','verify_edit','verify_query','rule','rule_query','system','system_role','system_role_query','system_role_edit','system_member','system_member_edit','rule_edit','system_member_query','project','project_edit_query','project_edit_edit');
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,5 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,7 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,9 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,11 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,13 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,15 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,17 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,19 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,21 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,23 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,25 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,27 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,29 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,31 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,33 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,35 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,37 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,39 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,40 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,41 FROM dq_role WHERE role_value = 5;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,42 FROM dq_role WHERE role_value = 5;

-- 添加租户所有者项目管理权限
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 1 and r.project_id <>1 and p.code in( 'datasource','datasource_query','datasource_edit','message','message_edit','message_query',
'verify','verify_edit','verify_query','rule','rule_query','system','system_role','system_role_query','system_role_edit','system_member','system_member_edit','rule_edit','system_member_query');
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 1 and p.code in
('project','project_edit_query','project_edit_edit');
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,3 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,5 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,7 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,9 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,11 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,13 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,15 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,17 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,19 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,21 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,23 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,25 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,27 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,29 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,31 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,33 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,35 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,37 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,39 FROM dq_role WHERE role_value = 1 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,40 FROM dq_role WHERE role_value = 1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,41 FROM dq_role WHERE role_value = 1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,42 FROM dq_role WHERE role_value = 1;

-- 添加项目管理者项目管理权限
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 2 and r.project_id <>1 and p.code in( 'datasource','datasource_query','datasource_edit','message','message_edit','message_query',
'verify','verify_edit','verify_query','rule','rule_query','system','system_role','system_role_query','system_role_edit','system_member','system_member_edit','rule_edit','system_member_query');
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 2 and p.code in
('project','project_edit_query','project_edit_edit');
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,3 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,5 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,7 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,9 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,11 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,13 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,15 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,17 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,19 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,21 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,23 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,25 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,27 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,29 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,31 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,33 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,35 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,37 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,39 FROM dq_role WHERE role_value = 2 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,40 FROM dq_role WHERE role_value = 2;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,41 FROM dq_role WHERE role_value = 2;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,42 FROM dq_role WHERE role_value = 2;

-- 添加数据开发项目管理权限
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 4 and r.project_id <>1 and p.code in( 'datasource_query','message','message_edit','message_query',
'verify','verify_edit','verify_query','rule','rule_query','system','system_role','system_role_query','system_role_edit','system_member','rule_edit','system_member_query');
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 4 and p.code in
('project','project_edit_query');
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,5 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,11 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,13 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,17 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,19 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,23 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,29 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,31 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,37 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,39 FROM dq_role WHERE role_value = 4 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,40 FROM dq_role WHERE role_value = 4;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,41 FROM dq_role WHERE role_value = 4;

-- 添加访客权限
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 3 and r.project_id <>1 and p.code in( 'datasource_query','message','message_query',
'verify','verify_query','rule','rule_query','system','system_role','system_role_query','system_member','system_member_query');
INSERT INTO dq_role_permission (role_id, permission_id)
SELECT r.id roleId,p.id as permissionId FROM dq_role r, dq_permission p WHERE r.role_value = 3 and p.code in
('project','project_edit_query');
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,5 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,13 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,19 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,23 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,29 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,39 FROM dq_role WHERE role_value = 3 and project_id <>1;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,40 FROM dq_role WHERE role_value = 3;
-- INSERT INTO dq_role_permission (role_id, permission_id)
-- SELECT id,41 FROM dq_role WHERE role_value = 3;

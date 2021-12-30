-- /usr/local/Cellar/mysql@5.6/5.6.43/bin/mysqldump api -h 172.16.8.109 -u dtstack -pabc123 --add-drop-table | /usr/local/Cellar/mysql@5.6/5.6.43/bin/mysql -h 172.16.8.109 api_dahai -u dtstack -pabc123
-- 数据API项目隔离表表设计
-- ********************************************************本段代码富力地产不执行!!! BEGIN********************************************************
-- 修复tenant表create_user_id   role_id=1为tenant_owner权限

-- UPDATE da_tenant dt
-- join (SELECT tenant_id, user_id as create_user_id FROM da_role_user where role_id =1) tmp
-- on dt.id = tmp.tenant_id
-- set dt.create_user_id = tmp.create_user_id;
-- 使用超级管理员当作租户创建者，需要确认超级管理员用户id
-- 需要
-- 存在租户所有者被修改的情况。
UPDATE  da_tenant dt
 join (select max(dru.user_id) as user_id,dru.tenant_id,dr.id,dr.role_value from da_role_user dru join da_role dr on dru.role_id = dr.id where dr.role_value = 1 group by dru.tenant_id) tmp
 on dt.id = tmp.tenant_id
 set create_user_id = tmp.user_id;

-- 新增项目表
CREATE TABLE `da_project`
(
    `id`                 int(11)      NOT NULL AUTO_INCREMENT,
    `tenant_id`          int(11)      NOT NULL COMMENT '租户id',
    `project_name`       varchar(256) NOT NULL COMMENT '项目名称',
    `project_identifier` varchar(255)          DEFAULT NULL COMMENT '项目标识名',
    `project_alias`      varchar(256) NOT NULL COMMENT '项目显示名',
    `project_desc`       varchar(4000)         DEFAULT NULL COMMENT '项目描述',
    `status`             tinyint(1)   NOT NULL DEFAULT '0' COMMENT '''项目状态0：初始化，1：正常,2:禁用,3:失败''',
    `create_user_id`     int(11)               DEFAULT NULL COMMENT '创建项目的用户id',
    `gmt_create`         datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`       datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`         tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 149
  DEFAULT CHARSET = utf8 COMMENT ='api项目表';
-- 对项目表进行默认项目初始（富力地产不可执行！！！！）

INSERT INTO da_project(tenant_id,
                       project_name,
                       project_identifier,
                       project_alias,
                       project_desc,
                       `status`,
                       create_user_id,
                       gmt_create,
                       gmt_modified,
                       is_deleted)
SELECT da.tenant_id      as tenant_id,
'DEFAULT_PROJECT'        as project_name,
       'DEFAULT'         as project_identifier,
       '默认项目'          as project_alias,
       ''                as project_desc,
       1                 as `status`,
dt.create_user_id        as create_user_id,
        now()            as gmt_create,
       now()             as gmt_modified,
       0                as is_deleted
from da_api da join da_tenant dt on da.tenant_id = dt.id group by dt.id;


-- 项目的置顶记录表
CREATE TABLE `da_project_stick`
(
    `id`           int(11)    NOT NULL AUTO_INCREMENT,
    `tenant_id`    int(11)    NOT NULL DEFAULT '0' COMMENT '租户id',
    `project_id`   int(11)    NOT NULL DEFAULT '0' COMMENT '项目id',
    `user_id`      int(11)             DEFAULT NULL COMMENT '用户id',
    `stick`        datetime            DEFAULT NULL COMMENT '置顶字段',
    `gmt_create`   datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`   tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='项目的置顶记录表';

-- 默认项目默认置顶
insert into da_project_stick(
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
  from da_project where  project_identifier = 'DEFAULT';

-- API表增加项目字段
ALTER TABLE da_api
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
-- 使用默认项目进行迁移(富力地产不可执行!!!!)
UPDATE
    da_api da
        join da_project dp on da.tenant_id = dp.tenant_id
set da.project_id = dp.id;

-- API目录迁移
ALTER TABLE da_api_catalogue
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
update
    da_api_catalogue dac
        join da_project dp on dac.tenant_id = dp.tenant_id
set
    dac.project_id = dp.id;

ALTER TABLE da_security_group
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_security_group dsg
    JOIN da_project dp ON dsg.tenant_id = dp.tenant_id
SET dsg.project_id = dp.id;

ALTER TABLE da_data_source
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_data_source dds
    JOIN da_project dp ON dds.tenant_id = dp.tenant_id
SET dds.project_id = dp.id;
-- ********************************************************本段代码富力地产不执行!!! END********************************************************

-- API申请表
ALTER TABLE da_api_apply
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
update
    da_api_apply daa
        join da_api da on daa.api_id = da.id
set daa.project_id = da.project_id;

ALTER TABLE da_api_auth
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
update
    da_api_auth daa
        join da_api da on daa.api_id = da.id
set daa.project_id = da.project_id;

ALTER TABLE da_apply_invoke
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
update
    da_apply_invoke dai
        join da_api da on dai.api_id = da.id
set
    dai.project_id = da.project_id;

ALTER TABLE da_invoke_count
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_invoke_count dic
    JOIN da_api da ON dic.api_id = da.id
SET dic.project_id = da.project_id;

ALTER TABLE da_invoke_log
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_invoke_log dil
    JOIN da_api da ON dil.api_id = da.id
SET dil.project_id = da.project_id;

ALTER TABLE da_snapshot_api
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_snapshot_api dsa
    JOIN da_api da ON dsa.api_id = da.id
SET dsa.project_id = da.project_id;

ALTER TABLE da_snapshot_err
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_snapshot_err dse
    JOIN da_api da ON dse.api_id = da.id
SET dse.project_id = da.project_id;

ALTER TABLE da_snapshot_invoke
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_snapshot_invoke dsi
    JOIN da_api da ON dsi.api_id = da.id
SET dsi.project_id = da.project_id;

ALTER TABLE da_role
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_role dr
    JOIN da_project dp ON dr.tenant_id = dp.tenant_id
SET dr.project_id = dp.id;

ALTER TABLE da_role_user
    ADD project_id int(11) DEFAULT NULL COMMENT '项目id';
UPDATE da_role_user dru
    JOIN da_project dp ON dru.tenant_id = dp.tenant_id
SET dru.project_id = dp.id;



-- 添加数据开发角色
INSERT INTO da_role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id,project_id)
VALUES (5,-1, '数据开发', 1, 5, '可进行API生成、发布、申请，但不具备API管理、授权审批、用户管理权限', 0,-1);


-- 新增角色SQL
INSERT INTO da_role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id,project_id)
VALUES (6,-1, '项目所有者', 1, 6, '项目空间创建者，拥有项目空间内的最高权限，可对项目空间中的全部资源和项目成员进行管理', 0,-1);

INSERT INTO da_role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id,project_id)
VALUES (7,-1, '项目管理员', 1, 7, '项目空间管理者，可对项目空间中所有数据源、API、项目成员进行管理。项目管理员不能对项目所有者操作', 0,-1);

-- 更新角色名称
UPDATE da_role
SET role_name = 'API管理员'
WHERE id = 2;
    -- 新增权限SQL
-- 项目管理
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('da_project','项目管理','项目管理',1,1);

-- 项目管理-查看
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('da_project_query','项目管理_查看','查看',93,1);

-- 项目管理-编辑
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('da_project_edit','项目管理_编辑','编辑',93,1);

-- 项目管理成员管理
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_member','项目管理_成员管理','成员管理',93,1);
-- 项目管理-成员管理-查看
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_member_query','项目管理_成员管理_查看','查看',96,1);
-- 项目管理-成员管理-编辑
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_member_edit','项目管理_成员管理_编辑','编辑',96,1);

-- 项目管理角色管理
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_role','项目管理_角色管理','角色管理',93,1);
-- 项目管理-角色管理-查看
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_member_query','项目管理_角色管理_查看','查看',99,1);
-- 项目管理-角色管理-编辑
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_member_edit','项目管理_角色管理_编辑','编辑',99,1);

-- 项目管理项目配置
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_config','项目管理_项目配置','项目配置',93,1);
-- 项目管理项目配置-查看
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_config_query','项目管理_项目配置_查看','查看',102,1);
-- 项目管理项目配置-编辑
-- INSERT INTO da_permission (code,name,display,parent_id,type) VALUES ('project_config_edit','项目管理_项目配置_编辑','编辑',102,1);


-- 之前系统管理修改为项目管理
UPDATE da_permission
SET code   = 'project',
    name='项目管理',
    display='项目管理'
WHERE id = 8;
UPDATE da_permission
SET code   = 'project_member',
    name='项目管理_成员管理',
    display='成员管理'
WHERE id = 20;
UPDATE da_permission
SET code   = 'project_member_query',
    name='项目管理_成员管理_查看',
    display='查看'
WHERE id = 22;
UPDATE da_permission
SET code   = 'project_member_edit',
    name='项目管理_成员管理_编辑',
    display='编辑'
WHERE id = 24;
UPDATE da_permission
SET code   = 'project_role',
    name='项目管理_角色管理',
    display='角色管理'
WHERE id = 26;
UPDATE da_permission
SET code   = 'project_role_query',
    name='项目管理_角色管理_查询',
    display='查询'
WHERE id = 28;
UPDATE da_permission
SET code   = 'project_role_edit',
    name='项目管理_成员管理_编辑',
    display='编辑'
WHERE id = 30;

-- 项目管理添加项目管理--编辑选项  项目管理-项目配置   项目管理-项目配置-查看  项目管理-项目配置-编辑
-- 项目管理编辑
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (93,'project_edit', '项目管理_编辑', '编辑', 8, 1);
-- 项目管理菜单
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (94,'project_manager_menu', '项目管理_菜单', '菜单', 8, 1);
-- 项目管理-项目配置
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (95,'project_config', '项目管理_项目配置', '项目配置', 8, 1);
-- 项目管理-项目配置-查看
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (96,'project_config_query', '项目管理_项目配置_查看', '查看', 95, 1);
-- 项目管理-项目配置-编辑
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (97,'project_config_edit', '项目管理_项目配置_编辑', '编辑', 95, 1);


-- 添加数据开发的角色权限
INSERT INTO da_role_permission (role_id, permission_id) VALUES
((SELECT id FROM da_role WHERE role_value = 5), 2),
((SELECT id FROM da_role WHERE role_value = 5), 4),
((SELECT id FROM da_role WHERE role_value = 5), 32),
((SELECT id FROM da_role WHERE role_value = 5), 76),
((SELECT id FROM da_role WHERE role_value = 5), 77),
((SELECT id FROM da_role WHERE role_value = 5), 78),
((SELECT id FROM da_role WHERE role_value = 5), 80),
((SELECT id FROM da_role WHERE role_value = 5), 81),
((SELECT id FROM da_role WHERE role_value = 5), 82),
((SELECT id FROM da_role WHERE role_value = 5), 40),
((SELECT id FROM da_role WHERE role_value = 5), 42),
((SELECT id FROM da_role WHERE role_value = 5), 44),
((SELECT id FROM da_role WHERE role_value = 5), 84),
((SELECT id FROM da_role WHERE role_value = 5), 46),
((SELECT id FROM da_role WHERE role_value = 5), 48),
((SELECT id FROM da_role WHERE role_value = 5), 50),
((SELECT id FROM da_role WHERE role_value = 5), 86),
((SELECT id FROM da_role WHERE role_value = 5), 52),
((SELECT id FROM da_role WHERE role_value = 5), 54),
((SELECT id FROM da_role WHERE role_value = 5), 56),
((SELECT id FROM da_role WHERE role_value = 5), 88),
((SELECT id FROM da_role WHERE role_value = 5), 58),
((SELECT id FROM da_role WHERE role_value = 5), 60),
((SELECT id FROM da_role WHERE role_value = 5), 62),
((SELECT id FROM da_role WHERE role_value = 5), 70),
((SELECT id FROM da_role WHERE role_value = 5), 72),
((SELECT id FROM da_role WHERE role_value = 5), 74),
((SELECT id FROM da_role WHERE role_value = 5), 92);



-- 添加角色权限表中的 项目所有者 和项目管理员角色权限SQL
-- 添加项目所有者的角色权限信息
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value = 6), 4),
       ((SELECT id FROM da_role WHERE role_value = 6), 6),
       ((SELECT id FROM da_role WHERE role_value = 6), 22),
       ((SELECT id FROM da_role WHERE role_value = 6), 24),
       ((SELECT id FROM da_role WHERE role_value = 6), 28),
       ((SELECT id FROM da_role WHERE role_value = 6), 30),
       ((SELECT id FROM da_role WHERE role_value = 6), 42),
       ((SELECT id FROM da_role WHERE role_value = 6), 44),
       ((SELECT id FROM da_role WHERE role_value = 6), 48),
       ((SELECT id FROM da_role WHERE role_value = 6), 50),
       ((SELECT id FROM da_role WHERE role_value = 6), 54),
       ((SELECT id FROM da_role WHERE role_value = 6), 56),
       ((SELECT id FROM da_role WHERE role_value = 6), 60),
       ((SELECT id FROM da_role WHERE role_value = 6), 62),
       ((SELECT id FROM da_role WHERE role_value = 6), 66),
       ((SELECT id FROM da_role WHERE role_value = 6), 68),
       ((SELECT id FROM da_role WHERE role_value = 6), 72),
       ((SELECT id FROM da_role WHERE role_value = 6), 74),
       ((SELECT id FROM da_role WHERE role_value = 6), 77),
       ((SELECT id FROM da_role WHERE role_value = 6), 78),
       ((SELECT id FROM da_role WHERE role_value = 6), 81),
       ((SELECT id FROM da_role WHERE role_value = 6), 82),
       ((SELECT id FROM da_role WHERE role_value = 6), 84),
       ((SELECT id FROM da_role WHERE role_value = 6), 86),
       ((SELECT id FROM da_role WHERE role_value = 6), 88),
       ((SELECT id FROM da_role WHERE role_value = 6), 90),
       ((SELECT id FROM da_role WHERE role_value = 6), 92),
       ((SELECT id FROM da_role WHERE role_value = 6), 93),
       ((SELECT id FROM da_role WHERE role_value = 6), 94),
       ((SELECT id FROM da_role WHERE role_value = 6), 96),
        ((SELECT id FROM da_role WHERE role_value = 6), 97);

-- 添加项目管理员的角色权限信息
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value = 7), 4),
       ((SELECT id FROM da_role WHERE role_value = 7), 6),
       ((SELECT id FROM da_role WHERE role_value = 7), 22),
       ((SELECT id FROM da_role WHERE role_value = 7), 24),
       ((SELECT id FROM da_role WHERE role_value = 7), 28),
       ((SELECT id FROM da_role WHERE role_value = 7), 30),
       ((SELECT id FROM da_role WHERE role_value = 7), 42),
       ((SELECT id FROM da_role WHERE role_value = 7), 44),
       ((SELECT id FROM da_role WHERE role_value = 7), 48),
       ((SELECT id FROM da_role WHERE role_value = 7), 50),
       ((SELECT id FROM da_role WHERE role_value = 7), 54),
       ((SELECT id FROM da_role WHERE role_value = 7), 56),
       ((SELECT id FROM da_role WHERE role_value = 7), 60),
       ((SELECT id FROM da_role WHERE role_value = 7), 62),
       ((SELECT id FROM da_role WHERE role_value = 7), 66),
       ((SELECT id FROM da_role WHERE role_value = 7), 68),
       ((SELECT id FROM da_role WHERE role_value = 7), 72),
       ((SELECT id FROM da_role WHERE role_value = 7), 74),
       ((SELECT id FROM da_role WHERE role_value = 7), 77),
       ((SELECT id FROM da_role WHERE role_value = 7), 78),
       ((SELECT id FROM da_role WHERE role_value = 7), 81),
       ((SELECT id FROM da_role WHERE role_value = 7), 82),
       ((SELECT id FROM da_role WHERE role_value = 7), 84),
       ((SELECT id FROM da_role WHERE role_value = 7), 86),
       ((SELECT id FROM da_role WHERE role_value = 7), 88),
       ((SELECT id FROM da_role WHERE role_value = 7), 90),
       ((SELECT id FROM da_role WHERE role_value = 7), 92),
        ((SELECT id FROM da_role WHERE role_value = 7), 93),
       ((SELECT id FROM da_role WHERE role_value = 7), 94),
       ((SELECT id FROM da_role WHERE role_value = 7), 96),
       ((SELECT id FROM da_role WHERE role_value = 7), 97);

-- 访客添加

-- 由于添加项目管理中项目配置的概念，所以要把项目配置的功能添加进去


-- 为租户添加 项目管理菜单 项目管理-项目配置-查看/编辑
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value = 1), 94),
       ((SELECT id FROM da_role WHERE role_value = 1), 96),
       ((SELECT id FROM da_role WHERE role_value = 1), 97);
-- 为api管理员添加项目配置查看的权限
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value =2), 94),
       ((SELECT id FROM da_role WHERE role_value = 2), 96);
-- 为应用开发添加项目管理的查看权限
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value =4), 94),
       ((SELECT id FROM da_role WHERE role_value = 4), 96);
-- 为访客添加项目管理的查看权限
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value =3), 94),
       ((SELECT id FROM da_role WHERE role_value = 3), 96);
-- 为数据开发添加 项目管理菜单 项目管理-项目配置-查看
INSERT INTO da_role_permission (role_id, permission_id)
VALUES ((SELECT id FROM da_role WHERE role_value =5), 22),
       ((SELECT id FROM da_role WHERE role_value = 5),28),
       ((SELECT id FROM da_role WHERE role_value =5), 94),
       ((SELECT id FROM da_role WHERE role_value = 5), 96);


-- 更新角色表中的tenantId 为-1 的projectId 为-1 设置为默认角色
update da_role
set project_id= -1
where tenant_id = -1;


-- 整个项目sql脚本的注意点是需要进行严格把控新增的id要和关联关系对应上，指定id也存在风险


-- 更改角色的描述文案
update da_role set role_desc = '本项目内的全部权限，具有本租户内的最高权限' WHERE id = 1;
update da_role set role_desc = 'API管理者，可进行API创建、发布、管理、授权审批、用户管理，但不具备项目配置权限' WHERE id = 2;
update da_role set role_desc = '可进行API生成、发布、申请，但不具备API管理、授权审批、用户管理等权限' WHERE id = 5;


-- 更新默认角色
update da_role set project_id = -1 where tenant_id = -1 and project_id is NULL ;

-- 添加默认项目的默认角色
insert into da_role(
tenant_id,
role_name,
role_type,
role_value,
role_desc,
modify_user_id,
project_id) select
b.tenant_id,
a.role_name,
a.role_type,
a.role_value,
a.role_desc,
b.create_user_id as modify_user_id,
b.id as project_id
from da_role a join da_project b on 1= 1
where a.tenant_id = -1 and a.project_id = -1 and a.is_deleted =0 and b.project_identifier = 'DEFAULT';

 -- 将da_role_permission中的数据作为元数据备份
create table da_role_permission_tmp as select * from da_role_permission;

INSERT INTO da_role_permission(role_id,permission_id)
select dr1.id as role_id ,
tmp.permission_id
from da_role dr1 join
  (select drpt.role_id,drpt.permission_id ,dr.role_value from da_role_permission_tmp drpt
  join da_role dr on dr.id = drpt.role_id) tmp
on tmp.role_value = dr1.role_value  where dr1.project_id >0;

update da_role_user drut1
    join (select dr1.id as role_id_ ,tmp.* from da_role dr1 join (select drut.*,dr.role_value from da_role dr join da_role_user drut on dr.id = drut.role_id) tmp on tmp.role_value = dr1.role_value where dr1.tenant_id = tmp.tenant_id and dr1.project_id = tmp.project_id) tmp1
    on drut1.id = tmp1.id
    set drut1.role_id = tmp1.role_id_;


    -- 更改role_user user_id 是null
ALTER TABLE da_role_user MODIFY user_id int(11) DEFAULT NULL;
-- 给租户所有者添加项目所有者
INSERT INTO da_role_user ( tenant_id, role_id, user_id, project_id )
SELECT
dss.tenant_id,
dss.role_id,
da.create_user_id AS user_id,
dss.project_id
FROM
	(
	SELECT
		dr.id AS role_id,
		dr.tenant_id AS tenant_id,
		dr.role_name AS role_name,
		dr.project_id AS project_id
	FROM
		da_role AS dr
	WHERE
		dr.role_value = 6
		AND dr.id != 6
	) AS dss
	LEFT JOIN da_tenant da ON da.id = dss.tenant_id;

-- 给租户所有者添加项目管理员
INSERT INTO da_role_user ( tenant_id, role_id, user_id, project_id )
SELECT
dss.tenant_id,
dss.role_id,
da.create_user_id AS user_id,
dss.project_id
FROM
	(
	SELECT
		dr.id AS role_id,
		dr.tenant_id AS tenant_id,
		dr.role_name AS role_name,
		dr.project_id AS project_id
	FROM
		da_role AS dr
	WHERE
		dr.role_value = 7
		AND dr.id != 7
	) AS dss
	LEFT JOIN da_tenant da ON da.id = dss.tenant_id;



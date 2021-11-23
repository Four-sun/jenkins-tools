CREATE TABLE dl_user_group (
	id              int(11)         NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id       int(11)         NOT NULL COMMENT '租户id',
    project_id      int(11)         NOT NULL COMMENT '项目id',
    user_group_name varchar(255)    NOT NULL COMMENT '用户分组名称',
    user_group_desc varchar(255)    COMMENT '用户分组描述',
    create_at       datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)         NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)         NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)      NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户分组表';

CREATE TABLE dl_use_tag_rel (
    id int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id int(11) NOT NULL COMMENT '租户id',
    project_id int(11) NOT NULL COMMENT '项目id',
    tag_id          int(11)     NOT NULL COMMENT '标签id',
    use_tag_Id      int(11)     NOT NULL COMMENT '使用标签id',
    create_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	update_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  	create_by       int(11)     NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)     NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)  NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户分组-用户id关联表';


CREATE TABLE dl_tag_publish (
    id                  int(11)     NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id           int(11)     NOT NULL COMMENT '租户id',
    project_id          int(11)     NOT NULL COMMENT '项目id',
    entity_id           int(11)     NOT NULL COMMENT '实体id',
    tag_id              int(11)     NOT NULL COMMENT '标签id',
    publish_status      int(2)      NOT NULL DEFAULT '0'COMMENT '发布状态: 0未发布，1已下线，2已发布，3过期下线',
    publish_start_time  datetime    DEFAULT NULL COMMENT '发布有效期开始时间',
    publish_end_time    datetime    DEFAULT NULL COMMENT '发布有效期结束时间',
    is_time_limit       tinyint(1)  NOT NULL DEFAULT '1' COMMENT 'false 无限制  true 使用生命周期',
    is_visible_limit    tinyint(1)  NOT NULL DEFAULT '1' COMMENT 'false 所有人可见 true 限制可见用户组',
    offline_time        datetime    DEFAULT NULL COMMENT '实际下线时间',
    security_level      int(2)      NOT NULL COMMENT '安全等级-,0：初始化 ,1公有标签，2普通标签',
    create_at           datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at           datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by           int(11)     NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by           int(11)     NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted          tinyint(1)  NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='标签发布表/标签市场';

CREATE TABLE dl_user_group_tag_rel (
    id              int(11)     NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id       int(11)     NOT NULL COMMENT '租户id',
    project_id      int(11)     NOT NULL COMMENT '项目id',
  	tag_id          int(11)     NOT NULL COMMENT '标签id',
    user_group_id   int(11)     NOT NULL COMMENT '用户组id',
    create_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by       int(11)     NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)     NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)  NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='标签-用户组关联表';


CREATE TABLE dl_tag_apply (
    id                      int(11)         NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id               int(11)         NOT NULL COMMENT '租户id',
    project_id              int(11)         NOT NULL COMMENT '项目id',
    tag_id                  int(11)         NOT NULL COMMENT '标签id',
    apply_user_id           int(11)         COMMENT '申请人id',
    apply_start_time        datetime        DEFAULT NULL COMMENT '申请开始时间',
    apply_end_time          datetime        DEFAULT NULL COMMENT '申请结束时间',
    is_limit                tinyint(1)      NOT NULL DEFAULT '1' COMMENT 'false 无限制 true 使用生命周期',
    apply_explain           varchar(255)    COLLATE utf8_bin DEFAULT NULL COMMENT '申请说明',
    approve_user_id         int(11)         COMMENT '审批人id',
    approve_explain         varchar(255)    COLLATE utf8_bin DEFAULT NULL COMMENT '审批说明',
    approve_status          int(11)         NOT NULL COMMENT ' 审批状态 0:初始化 1:审批中 2:已审批 3:拒绝审批 4:取消授权 5.已过期（通过计算得出）',
  	apply_time              datetime        DEFAULT NULL COMMENT '申请时间',
    approve_time            datetime        DEFAULT NULL COMMENT '审批时间',
    approve_start_up_status tinyint(1)      NOT NULL DEFAULT '0' COMMENT '审批启动状态  false 启动 true 停用',
    create_at               datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at               datetime        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by               int(11)         NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by               int(11)         NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted              tinyint(1)      NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='标签市场申请表';

CREATE TABLE dl_user_group_rel (
	id              int(11)     NOT NULL AUTO_INCREMENT COMMENT '自增id',
    tenant_id       int(11)         NOT NULL COMMENT '租户id',
    project_id      int(11)         NOT NULL COMMENT '项目id',
    user_group_id   int(11)     NOT NULL COMMENT '分组id',
    user_id         int(11)     NOT NULL COMMENT '用户id',
    create_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	update_at       datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  	create_by       int(11)     NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by       int(11)     NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted      tinyint(1)  NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户分组-用户id关联表';

ALTER TABLE dl_tag_cate MODIFY COLUMN order_val int(11) DEFAULT 0 NOT NULL COMMENT '排序值（从小到大）';
UPDATE dl_tag_cate SET order_val = 2147483647 WHERE cate_name = "未分类";


update dl_role set role_desc = '拥有市场，群组服务相关权限，但不能具有标签管理，管理项目及项目成员权限' where role_value  = 4 ;

INSERT INTO dl_role (tenant_id,project_id,role_name,role_type,role_value,role_desc,create_at,update_at,create_by,update_by,is_deleted) VALUES
(-1,-1,'数据开发',1,6,'拥有标签体系建设中需要的一切操作权限，但不能管理项目及项目成员',NOW(),NOW(),0,0,0);

-- 数据开发添加权限
INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select
(select id from dl_role where role_value = 6  order by create_at asc limit 0,1) as role_id
, permission_id, NOW(), NOW(), 0, 0, 0 from  dl_role_permission  where role_id = 1 and permission_id not in (6,12);

INSERT INTO dl_role( project_id , tenant_id , role_name , role_type , role_value , role_desc ,create_at,update_at,create_by,update_by,is_deleted)
select id,tenant_id,'数据开发',1,6,'拥有标签体系建设中需要的一切操作权限，但不能管理项目及项目成员',now(),now(),0,0,0 from dl_project dp where dp.id not in(
select project_id from dl_role where role_value = 6
) and is_deleted = 0;

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (57,'tag_market','标签市场','标签市场',1);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (58,'tag_market_tag_market','标签市场_标签市场','标签市场',57);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (59,'tag_market_tag_market_query','标签市场_标签市场_查看','查看',58);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (60,'tag_market_tag_market_edit','标签市场_标签市场_操作','操作',58);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (61,'tag_market_my_tag','标签市场_我的标签','我的标签',57);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (62,'tag_market_my_tag_query','标签市场_我的标签_查看','查看',61);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (63,'tag_market_my_tag_edit','标签市场_我的标签_操作','操作',62);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (64,'tag_market_approve','标签市场_审批管理','审批管理',57);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (65,'tag_market_approve_query','标签市场_审批管理_查看','查看',64);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (66,'tag_market_approve_edit','标签市场_审批管理_操作','操作',64);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (67,'tag_center_tag_publish','标签中心_标签发布','审批管理',57);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (68,'tag_center_tag_publish_query','标签中心_标签发布_查看','查看',67);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (69,'tag_center_tag_publish_edit','标签中心_标签发布_操作','操作',67);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (70,'project_manage_use_group','项目管理_用户分组','用户分组',57);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (71,'project_manage_use_group_query','项目管理_用户分组_查看','查看',70);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (72,'project_manage_use_group_edit','项目管理_用户分组_编辑','编辑',70);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (73,'project_manage_use_group_delete','项目管理_用户分组_删除','删除',70);


-- 运营人员权限修改
update dl_role_permission set is_deleted =1,update_at = now() where id in
(
  select a.drpId from
    (
		select
			drp.id as drpId
		from
			dl_role_permission drp
		left join dl_role dr on
			drp.role_id = dr.id
		where
			dr.role_value = 4
			and drp.permission_id in (5, 9, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40)
	) a
);

-- 访客权限修改
update dl_role_permission set is_deleted =1,update_at = now() where id in
(
  select a.drpId from
    (
		select
			drp.id as drpId
		from
			dl_role_permission drp
		left join dl_role dr on
			drp.role_id = dr.id
		where
			dr.role_value = 5
			and drp.permission_id in (5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,63,66,69,70,71,72,73)
	) a
);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 57, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 57) and role_value in (1,2,3,4,5,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 58, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 58) and role_value in (1,2,3,4,5,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 59, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 59) and role_value in (1,2,3,4,5,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 60, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 60) and role_value in (1,2,3,4,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 61, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 61) and role_value in (1,2,3,4,5,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 62, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 62) and role_value in (1,2,3,4,5,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 63, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 63) and role_value in (1,2,3,4,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 64, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 64) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 65, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 65) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 66, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 66) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 67, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 67) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 68, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 68) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 69, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 69) and role_value in (1,2,3,6);


INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 70, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 70) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 71, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 71) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 72, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 72) and role_value in (1,2,3,6);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 73, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 73) and role_value in (1,2,3,6);
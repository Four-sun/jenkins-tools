CREATE TABLE dl_api
(
    id         int(11)      NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)      NOT NULL DEFAULT '0' COMMENT '租户id',
    project_id int(11)      NOT NULL DEFAULT '0' COMMENT '项目id',
    api_name   varchar(255) NOT NULL COMMENT 'API名称',
    api_desc   varchar(512) COMMENT 'API描述',
    entity_id  int(11)      NOT NULL COMMENT '实体id',
    group_id   int(11)      NOT NULL COMMENT '群组id',
    status     tinyint(1)   NOT NULL DEFAULT '0' COMMENT '0：正常，1：已发布，2：禁用',
    create_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)      NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)      NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1)   NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='API表';

CREATE TABLE dl_api_tag_rel
(
    id         int(11)    NOT NULL AUTO_INCREMENT,
    tenant_id  int(11)    NOT NULL COMMENT '租户id',
    project_id int(11)    NOT NULL COMMENT '项目id',
    api_id     int(11)    NOT NULL COMMENT 'apiId',
    api_tag_id int(11)    NOT NUll COMMENT 'api中的标签id(既维度id)',
    create_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_at  datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_by  int(11)    NOT NULL DEFAULT '0' COMMENT '创建的用户',
    update_by  int(11)    NOT NULL DEFAULT '0' COMMENT '修改的用户',
    is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT 'API维度表';

CREATE TABLE  dl_api_invoke_log (
   id int(11) NOT NULL AUTO_INCREMENT,
   api_id  varchar(255) NOT NULL COMMENT '被调用的api的id',
   create_at  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   update_at  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
   create_by  int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
   update_by  int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
   is_deleted  tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API调用日志表';


INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (47,'data_service_menu','数据服务','数据服务',1);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (48,'data_service_manage_menu','数据服务_API管理','API管理',47);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (49,'data_service_manage_query','数据服务_API管理_查看','查看',48);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (50,'data_service_manage_edit','数据服务_API管理_新建/编辑','新建/编辑',48);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (51,'data_service_manage_api','数据服务_API管理_发布/禁用','发布/禁用',48);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (52,'data_service_manage_delete','数据服务_API管理_删除','删除',48);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  1, id, '2019-11-20 17:25:56', '2019-11-20 17:25:56', 0, 0, 0
from dl_permission where id in(47,48,49,50,51,52)
and is_deleted = 0;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  2, id, '2019-11-20 17:25:56', '2019-11-20 17:25:56', 0, 0, 0
from dl_permission where id in(47,48,49,50,51,52)
and is_deleted = 0;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  3, id, '2019-11-20 17:25:56', '2019-11-20 17:25:56', 0, 0, 0
from dl_permission where id in(47,48,49,50,51,52)
and is_deleted = 0;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  4, id, '2019-11-20 17:25:56', '2019-11-20 17:25:56', 0, 0, 0
from dl_permission where id in(47,48,49,50,51,52)
and is_deleted = 0;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  5, id, '2019-11-20 17:25:56', '2019-11-20 17:25:56', 0, 0, 0
from dl_permission where id in(47,48,49)
and is_deleted = 0;
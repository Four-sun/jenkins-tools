
-- 业务中心(dt_pub_service) 权限、角色、角色权限 三表 增量sql （下列sql需要在dt_pub_service服务的数据库下一起执行）

START TRANSACTION;
-- 权限点
use dt_pub_service ;

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 0, 10, 'root', 'root', 'root', 0, 1 );
SELECT
    @rootId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 1, 10, 'INDEX_POOL', '指标市场', '指标市场', @rootId, 1 );
SELECT
    @indexPoolId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 2, 10, 'INDEX_POOL_DETAIL', '指标市场_指标详情', '指标详情', @indexPoolId, 1 );
SELECT
    @indexPoolDetailId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 3, 10, 'INDEX_POOL_DETAIL_LOOK_OVER', '指标市场_指标详情_查看', '查看', @indexPoolDetailId, 1 );
SELECT
    @INDEX_POOL_DETAIL_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 4, 10, 'INDEX_POOL_DETAIL_QUERY', '指标市场_指标详情_结果查询', '结果查询', @indexPoolDetailId, 1 );
SELECT
    @INDEX_POOL_DETAIL_QUERY := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 5, 10, 'INDEX_CENTER', '指标中心', '指标中心', @rootId, 1 );
SELECT
    @indexCenterId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 6, 10, 'INDEX_CENTER_DEFINITION', '指标中心_指标定义', '指标定义', @indexCenterId, 1 );
SELECT
    @indexDefinition := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 7, 10, 'INDEX_CENTER_DEFINITION_LOOK_OVER', '指标中心_指标定义_查看', '查看', @indexDefinition, 1 );
SELECT
    @INDEX_CENTER_DEFINITION_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 8, 10, 'INDEX_CENTER_DEFINITION_ADD_OR_UPDATE', '指标中心_指标定义_新增/编辑', '新增/编辑', @indexDefinition, 1 );
SELECT
    @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 9, 10, 'INDEX_CENTER_DEFINITION_DEL', '指标中心_指标定义_删除', '删除', @indexDefinition, 1 );
SELECT
    @INDEX_CENTER_DEFINITION_DEL := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 10, 10, 'INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE', '指标中心_指标定义_发布/下线', '发布/下线', @indexDefinition, 1 );
SELECT
    @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 11, 10, 'INDEX_CENTER_PERIOD', '指标中心_统计周期', '统计周期', @indexCenterId, 1 );
SELECT
    @preiodId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 12, 10, 'INDEX_CENTER_PERIOD_LOOK_OVER', '指标中心_统计周期_查看', '查看', @preiodId, 1 );
SELECT
    @INDEX_CENTER_PERIOD_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 13, 10, 'INDEX_CENTER_PERIOD_ADD_OR_UPDATE', '指标中心_统计周期_新增/编辑', '新增/编辑', @preiodId, 1 );
SELECT
    @INDEX_CENTER_PERIOD_ADD_OR_UPDATE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 14, 10, 'INDEX_CENTER_PERIOD_DEL', '指标中心_统计周期_删除', '删除', @preiodId, 1 );
SELECT
    @INDEX_CENTER_PERIOD_DEL := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 15, 10, 'PROJECT_MANAGE', '项目管理', '项目管理', @rootId, 1 );
SELECT
    @projectManageId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 16, 10, 'PROJECT_MANAGE_CONFIG', '项目管理_项目配置', '项目配置', @projectManageId, 1 );
SELECT
    @projectConfig := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 17, 10, 'PROJECT_MANAGE_CONFIG_LOOK_OVER', '项目管理_项目配置_查看', '查看', @projectConfig, 1 );
SELECT
    @PROJECT_MANAGE_CONFIG_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 18, 10, 'PROJECT_MANAGE_CONFIG_ADD', '项目管理_项目配置_新增', '新增', @projectConfig, 1 );
SELECT
    @PROJECT_MANAGE_CONFIG_ADD := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 19, 10, 'PROJECT_MANAGE_CONFIG_UPDATE', '项目管理_项目配置_编辑', '编辑', @projectConfig, 1 );
SELECT
    @PROJECT_MANAGE_CONFIG_UPDATE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 20, 10, 'PROJECT_MANAGE_USER', '项目管理_用户管理', '用户管理', @projectManageId, 1 );
SELECT
    @userManageId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 21, 10, 'PROJECT_MANAGE_USER_LOOK_OVER', '项目管理_用户管理_查看', '查看', @userManageId, 1 );
SELECT
    @PROJECT_MANAGE_USER_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 22, 10, 'PROJECT_MANAGE_USER_ADD_OR_UPDATE', '项目管理_用户管理_新增/编辑', '新增/编辑', @userManageId, 1 );
SELECT
    @PROJECT_MANAGE_USER_ADD_OR_UPDATE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 23, 10, 'PROJECT_MANAGE_ROLE', '项目管理_角色管理', '角色管理', @projectManageId, 1 );
SELECT
    @roleManageId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 24, 10, 'PROJECT_MANAGE_ROLE_LOOK_OVER', '项目管理_角色管理_查看', '查看', @roleManageId, 1 );
SELECT
    @PROJECT_MANAGE_ROLE_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 25, 10, 'PROJECT_MANAGE_ROLE_ADD_OR_UPDATE', '项目管理_角色管理_新增/编辑', '新增/编辑', @roleManageId, 1 );
SELECT
    @PROJECT_MANAGE_ROLE_ADD_OR_UPDATE := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 26, 10, 'OPERATION_CENTER', '运维中心', '运维中心', @rootId, 1 );
SELECT
    @OPERATION_CENTER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 27, 10, 'OPERATION_CENTER_OPERATION_TASK', '运维中心_任务运维', '任务运维', @OPERATION_CENTER, 1 );
SELECT
    @operationtaskId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 28, 10, 'OPERATION_CENTER_OPERATION_TASK_LOOK_OVER', '运维中心_任务运维_查看', '查看', @operationtaskId, 1 );
SELECT
    @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 29, 10, 'OPERATION_CENTER_OPERATION_TASK_CONTROL', '运维中心_任务运维_任务控制', '任务控制', @operationtaskId, 1 );
SELECT
    @OPERATION_CENTER_OPERATION_TASK_CONTROL := LAST_INSERT_ID();


INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 30, 10, 'OPERATION_CENTER_MANAGE_TASK', '运维中心_任务管理', '任务管理', @OPERATION_CENTER, 1 );
SELECT
    @operationtaskmanageId := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 31, 10, 'OPERATION_CENTER_MANAGE_TASK_LOOK_OVER', '运维中心_任务管理_查看', '查看', @operationtaskmanageId, 1 );
SELECT
    @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 32, 10, 'OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA', '运维中心_任务管理_补数据', '补数据', @operationtaskmanageId, 1 );
SELECT
    @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA := LAST_INSERT_ID();

INSERT INTO `auth_permission` ( `old_permission_id`, `app_type`, `code`, `name`, `display`, `parent_id`, `type` )
VALUES
( 33, 10, 'INDEX_CENTER_DATA_MODEL', '指标中心_数据模型', '数据模型', @indexCenterId, 1 );
SELECT
    @INDEX_CENTER_DATA_MODEL := LAST_INSERT_ID();


--  角色

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '租户所有者', 1, 1, '本项目内的全部权限，具有本租户内的最高权限',1);
SELECT	@TEANTOWNERID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '租户管理员', 1, 7, '本项目内的全部权限，所有租户的管理权限，但不能对租户所有者操作',3);
SELECT	@TEANTADMINNIID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '项目所有者', 1, 2, '项目空间创建者，拥有项目空间内的最高权限，可以对项目空间的全部资源和项目成员进行管理',2);
SELECT	@PROJECTOWNERID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '项目管理员', 1, 3, '项目空间管理者，不能对项目所有者操作',4);
SELECT	@PROJECTADMINID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '数据开发', 1, 4, '拥有指标建设中需要的一些操作权限，但是不能对项目进行管理',5);
SELECT	@MEMBERID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '运营人员', 1, 5, '拥有指标市场相关操作权限，但是不具备指标建设的操作权限以及项目的管理权限',6);
SELECT	@OPERATIONID := LAST_INSERT_ID();

INSERT INTO `auth_role` (`app_type`, `dtuic_tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`,`old_role_id`)
VALUES (10, -1, -1, '访客', 1, 6, '只具备指标市场的查看权限，可查看指标市场、开放的指标详情信息，不具备其他操作权限',7);
SELECT	@DATADEVELOPDID := LAST_INSERT_ID();


-- 角色&权限关联表

-- 访客	@DATADEVELOPDID		10个权限点
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @projectManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @DATADEVELOPDID, @indexPoolId );

-- 运营人员  18个

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @OPERATIONID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

-- 数据开发 	29个

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @indexCenterId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @indexDefinition );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_DEFINITION_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_DEFINITION_DEL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @preiodId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_PERIOD_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_PERIOD_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_PERIOD_DEL );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @MEMBERID, @INDEX_CENTER_DATA_MODEL );

-- 项目管理员	32条

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_ROLE_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_USER_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_CONFIG_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @indexCenterId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @indexDefinition );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_DEFINITION_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_DEFINITION_DEL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @preiodId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_PERIOD_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_PERIOD_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_PERIOD_DEL );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTADMINID, @INDEX_CENTER_DATA_MODEL );
-- 项目所有者 33条
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_ROLE_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_CONFIG_ADD );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_USER_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_CONFIG_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @indexCenterId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @indexDefinition );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_DEFINITION_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_DEFINITION_DEL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @preiodId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_PERIOD_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_PERIOD_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_PERIOD_DEL );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @PROJECTOWNERID, @INDEX_CENTER_DATA_MODEL );
-- 租户管理员 33条

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_ROLE_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_CONFIG_ADD );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_USER_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_CONFIG_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @indexCenterId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @indexDefinition );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_DEFINITION_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_DEFINITION_DEL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @preiodId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_PERIOD_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_PERIOD_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_PERIOD_DEL );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTADMINNIID, @INDEX_CENTER_DATA_MODEL );

-- 租户所有者	33条

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_ROLE_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_ROLE_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @roleManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_CONFIG_ADD );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_USER_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_USER_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @userManageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_CONFIG_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @PROJECT_MANAGE_CONFIG_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @projectConfig );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @projectManageId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_POOL_DETAIL_QUERY );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_POOL_DETAIL_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @indexPoolDetailId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @indexPoolId );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @OPERATION_CENTER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @operationtaskId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @OPERATION_CENTER_OPERATION_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @OPERATION_CENTER_OPERATION_TASK_CONTROL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @operationtaskmanageId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @OPERATION_CENTER_MANAGE_TASK_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @OPERATION_CENTER_MANAGE_TASK_SUPPLY_DATA );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @indexCenterId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @indexDefinition );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_DEFINITION_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_DEFINITION_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_DEFINITION_DEL );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_DEFINITION_RELEASE_OR_OFFLINE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @preiodId );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_PERIOD_LOOK_OVER );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_PERIOD_ADD_OR_UPDATE );
INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_PERIOD_DEL );

INSERT INTO `auth_role_permission` ( `app_type`, `role_id`, `permission_id` )VALUES( 10, @TEANTOWNERID, @INDEX_CENTER_DATA_MODEL );


COMMIT;




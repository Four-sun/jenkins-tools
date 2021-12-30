-- *******************************************
-- 增加权限信息，并为角色分配权限
-- *******************************************
INSERT INTO `da_permission` VALUES ('1', 'root', 'root', 'root', '0', '1', '2018-03-10 12:56:07', '2018-03-10 12:56:07', '0');
INSERT INTO `da_permission` VALUES ('2', 'message', '消息中心', '消息中心', '1', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('4', 'message_query', '消息中心_查看', '查看', '2', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('6', 'message_edit', '消息中心_编辑', '编辑', '2', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('8', 'project', '项目管理', '项目管理', '1', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('20', 'project_member', '项目管理_成员管理', '成员管理', '8', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('22', 'project_member_query', '项目管理_成员管理_查看', '查看', '20', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('24', 'project_member_edit', '项目管理_成员管理_编辑', '编辑', '20', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('26', 'project_role', '项目管理_角色管理', '角色管理', '8', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('28', 'project_role_query', '项目管理_角色管理_查看', '查看', '26', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('30', 'project_role_edit', '项目管理_角色管理_编辑', '编辑', '26', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('32', 'overview', '概览', '概览', '1', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `da_permission` VALUES ('40', 'api_market', 'API市场', 'API市场', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('42', 'api_market_query', 'API市场_查看', '查看', '40', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('44', 'api_market_apply', 'API市场_订购', '订购', '40', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('46', 'api_myapi', '我的API', '我的API', '102', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('48', 'api_myapi_query', '我的API_查看', '查看', '46', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('50', 'api_myapi_edit', '我的API_编辑', '编辑', '46', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('52', 'api_manager', 'API管理', 'API管理', '102', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('54', 'api_manager_api_query', '查看', '查看', '103', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('56', 'api_manager_api_edit', '编辑', '编辑', '103', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('58', 'api_catalogue', '目录', '目录', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('60', 'api_catalogue_query', '目录_查看', '查看', '58', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('62', 'api_catalogue_edit', '目录_编辑', '编辑', '58', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('64', 'api_authorized', '授权审批', '审批授权', '102', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('66', 'api_authorized_query', '授权审批_查看', '查看', '64', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('68', 'api_authorized_edit', '授权审批_编辑', '编辑', '64', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('70', 'api_datasource', '数据源', '数据源', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('72', 'api_datasource_query', '数据源_查看', '查看', '70', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('74', 'api_datasource_edit', '数据源_编辑', '编辑', '70', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('76', 'overview_market', '概览_市场概览', '市场概览', '32', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('77', 'overview_market_query', '概览_市场概览_查看', '查看 ', '76', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('78', 'overview_market_menu', '概览_市场概览 _菜单', '菜单', '76', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('80', 'overview_myapi', '我的API', '我的API', '32', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('81', 'overview_myapi_query', '我的API_查看', '查看', '80', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('82', 'overview_myapi_menu', '概览_我的API_菜单', '菜单', '80', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('84', 'api_market_menu', 'API市场_菜单', '菜单', '40', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('86', 'api_myapi_menu', '我的API_菜单', '菜单', '46', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('88', 'api_manager_api_menu', '菜单', '菜单', '103', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('90', 'api_authorized_menu', '授权审批_菜单', '菜单', '64', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('92', 'api_datasource_menu', '数据源_菜单', '菜单', '70', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
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
-- 告警管理
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (98,'api_alarm', 'API管理_API告警', 'API告警', 102, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (99,'api_alarm_query', 'API管理_API告警_查看', '查看', 98, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (100,'api_alarm_edit', 'API管理_API告警_编辑', '编辑', 98, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (101,'api_alarm_menu', 'API管理_API告警_菜单', '菜单', 98, 1);
INSERT INTO da_permission (id,code, name, display, parent_id, type)
VALUES (102,'api_manager_sub', 'API管理父节点', 'API管理', 1, 1);

-- api、函数管理
INSERT INTO `da_permission` VALUES ('103', 'api_manager_api', 'API管理_API', 'API', '52', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('105', 'api_manager_function', 'API管理_函数', '函数', '52', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('106', 'api_manager_function_query', 'API管理_函数_查看', '查看', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('107', 'api_manager_function_edit', 'API管理_函数_编辑', '编辑', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `da_permission` VALUES ('108', 'api_manager_function_menu', 'API管理_函数_菜单', '菜单', '105', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');




-- *******************************************
-- 先为所有角色添加所有权限，然后再删除不需要的权限
-- *******************************************
DROP PROCEDURE IF EXISTS pr_auth_admin;

delimiter //

create procedure pr_auth_admin()
BEGIN
DECLARE authId INT;
DECLARE authCode VARCHAR(128);
DECLARE authPId INT;
DECLARE stop INT DEFAULT 0;
DECLARE cur CURSOR FOR (select id ,code ,parent_id from da_permission where is_deleted=0 and type = 1);
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO authId,authCode,authPId;
    WHILE ( stop is not null) DO
    SET @p_count = (select count(1) p_count from da_permission where parent_id = authId and is_deleted=0);
    IF @p_count=0 THEN
    -- 租户所有者
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('1', authId);
    -- API管理员
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('2', authId);
    -- 应用开发
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('3', authId);
    -- 访客
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('4', authId);
    -- 数据开发
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('5', authId);
    -- 项目所有者
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('6', authId);
    -- 项目管理员
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('7', authId);
    -- 租户管理员
    INSERT INTO da_role_permission(role_id,permission_id) VALUES ('8', authId);
    END IF;
    FETCH cur INTO authId,authCode,authPId;
    END WHILE;

CLOSE cur;



-- API管理员
delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 2) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
    'project_config_edit'
  )
);


-- 访客
delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 3) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
    'message_edit',
    'api_myapi_edit',
    'api_datasource_edit',
    'system_member_edit',
    'system_role_edit',
		'api_manager',
		'api_manager_api',
		'api_manager_api_query',
		'api_manager_api_edit',
		'api_manager_api_menu',
		'api_manager_function',
		'api_manager_function_query',
		'api_manager_function_edit',
		'api_manager_function_menu',
		'api_catalogue_edit',
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu',
		'api_market_apply',
		'api_alarm',
		'api_alarm_menu',
		'api_alarm_query',
		'api_alarm_edit',
		'project_config_edit',
		'project_member_edit',
		'project_role_edit'
  )
);

-- 应用开发，概览（仅看到自己的API）、API市场、我的API
delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 4) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
    'system_member_edit',
		'system_role_edit',
		'overview_market_query',
		'overview_market_menu',
		'api_manager',
		'api_manager_api',
		'api_manager_api_query',
		'api_manager_api_edit',
		'api_manager_api_menu',
		'api_manager_function',
		'api_manager_function_query',
		'api_manager_function_edit',
		'api_manager_function_menu',
		'api_catalogue_edit',
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu',
		'api_datasource_edit',
		'project_config_edit'
      )
);


-- 数据开发
delete from da_role_permission where role_id = (SELECT id FROM da_role WHERE role_value = 5) and permission_id IN (
  SELECT id from da_permission where type = 1 and code in (
		'api_authorized',
		'api_authorized_query',
		'api_authorized_edit',
		'api_authorized_menu',
		'project_config_edit'
      )
);


END;//

delimiter ;

CALL pr_auth_admin();

--  刷新权限表
-- 删除permission 表中的数据
truncate table rdos_permission;
-- 重新插入新的权限点信息
BEGIN;
INSERT INTO `rdos_permission` VALUES (1,'root','root','root',0,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (2,'project','项目管理','项目管理',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (3,'project_edit','项目管理_创建/删除','创建/删除',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (4,'project_configure','项目管理_项目配置','项目配置',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (5,'project_configure_query','项目管理_项目配置_查看','查看',4,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (6,'project_configure_edit','项目管理_项目配置_新增/编辑','新增/编辑',4,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (7,'project_configure_delete','项目管理_项目配置_删除','删除',4,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (8,'project_member','项目管理_项目成员管理','项目成员管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (9,'project_member_query','项目管理_项目成员管理_查看','查看',8,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (10,'project_member_edit','项目管理_项目成员管理_添加成员/编辑角色','添加成员/编辑角色',8,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (11,'project_member_remove','项目管理_项目成员管理_移出项目','移出项目',8,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (12,'project_strategy','项目管理_启停策略管理','启停策略管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (13,'project_strategy_query','项目管理_启停策略管理_查看','查看',12,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (14,'project_strategy_edit','项目管理_启停策略管理_新增/编辑','新增/编辑',12,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (15,'project_strategy_delete','项目管理_启停策略管理_删除','删除',12,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (16,'project_role','项目管理_角色管理','角色管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (17,'project_role_query','项目管理_角色管理_查看','查看',16,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (18,'project_role_edit','项目管理_角色管理_编辑','编辑',16,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (19,'datasource','数据源','数据源',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (20,'datasource_manager','数据源_数据源管理','数据源管理',19,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (21,'datasource_manager_query','数据源_数据源管理_查看','查看',20,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (22,'datasource_manager_edit','数据源_数据源管理_新增/编辑','新增/编辑',20,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (23,'datasource_manager_delete','数据源_数据源管理_删除','删除',20,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (24,'datadevelop','数据开发','数据开发',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (25,'datadevelop_resourcemanager','数据开发_资源管理','资源管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (26,'datadevelop_resourcemanager_query','数据开发_资源管理_查看','查看',25,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (27,'datadevelop_resourcemanager_edit','数据开发_资源管理_上传资源/编辑','上传资源/编辑',25,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (28,'datadevelop_resourcemanager_delete','数据开发_资源管理_删除','删除',25,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (29,'datadevelop_functionmanager','数据开发_函数管理','函数管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (30,'datadevelop_functionmanager_query','数据开发_函数管理_查看','查看',29,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (31,'datadevelop_functionmanager_edit','数据开发_函数管理_新增/编辑','新增/编辑',29,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (32,'datadevelop_functionmanager_delete','数据开发_函数管理_删除','删除',29,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (33,'datadevelop_taskmanager','数据开发_任务管理','任务管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (34,'datadevelop_taskmanager_query','数据开发_任务管理_查看','查看',33,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (35,'datadevelop_taskmanager_edit','数据开发_任务管理_编辑','编辑',33,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (36,'datadevelop_taskmanager_run','数据开发_任务管理_提交/停止','提交/停止',33,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (37,'datadevelop_taskpublish','数据开发_任务发布','任务发布',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (38,'datadevelop_taskpublish_create','数据开发_任务发布_创建包','创建包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (39,'datadevelop_taskpublish_query','数据开发_任务发布_查看包','查看包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (40,'datadevelop_taskpublish_download','数据开发_任务发布_下载/删除包','下载/删除包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (41,'datadevelop_taskpublish_publish','数据开发_任务发布_发布','发布包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (42,'maintenance','任务运维','任务运维',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (43,'maintenance_message','任务运维_运维信息','运维信息',42,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (44,'maintenance_message_pandect','任务运维_运维信息_总览','总览',43,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (45,'maintenance_message_query','任务运维_运维信息_查看','查看',43,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (46,'maintenance_alarm','任务运维_监控告警','监控告警',42,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (47,'maintenance_alarm_custom','任务运维_监控告警_告警配置','告警配置',46,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (48,'maintenance_alarm_custom_query','任务运维_监控告警_告警配置_查看','查看',47,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (49,'maintenance_alarm_custom_edit','任务运维_监控告警_告警配置_新增/编辑','新增/编辑',47,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (50,'maintenance_alarm_custom_delete','任务运维_监控告警_告警配置_删除','删除',47,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (51,'maintenance_alarm_record','任务运维_监控告警_告警记录','告警记录',46,1,now(),now(),0);
commit;
-- end

-- 刷新角色权限表
truncate table rdos_role_permission;
-- 删除role_permission 表中的数据
-- 定义存储过程用来插入所有权限点
-- 刷新角色权限表
-- 删除单个角色权限点的存储过程
DROP PROCEDURE IF EXISTS pr_auth_refresh_single_role_permission;
-- 定义刷新单个角色权限点的存储过程
DELIMITER //
create procedure pr_auth_refresh_single_role_permission(IN roleId INT)
BEGIN
    DECLARE permissionId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id from rdos_permission where is_deleted = 0 and type = 1);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;
    FETCH cur INTO permissionId;
    WHILE ( stop is not null) DO
            SET @p_count = (select count(1) p_count from rdos_permission where parent_id = permissionId and is_deleted=0);
            IF @p_count=0 THEN
                INSERT INTO rdos_role_permission (role_id, permission_id, gmt_create, gmt_modified, is_deleted) VALUES (roleId, permissionId, NOW(), NOW(),0);
            END IF;
            FETCH cur INTO permissionId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

-- 删除查找所有角色的存储过程
DROP PROCEDURE IF EXISTS pr_auth_refresh_role_permission;
-- 定义查找所有角色的存储过程
DELIMITER //
create procedure pr_auth_refresh_role_permission()
BEGIN
    DECLARE roleId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id from rdos_role where is_deleted=0);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;
    FETCH cur INTO roleId;
    WHILE ( stop is not null) DO
            CALL pr_auth_refresh_single_role_permission(roleId);
            FETCH cur INTO roleId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

CALL pr_auth_refresh_role_permission();

-- 删除role_permission 表中的数据
DROP PROCEDURE IF EXISTS pr_auth_refresh_single_role_permission;
-- 删除查找所有角色的存储过程
DROP PROCEDURE IF EXISTS pr_auth_refresh_role_permission;

-- 处理存储过程多刷进去的权限点
-- 项目管理员
UPDATE rdos_role_permission SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 3) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit'
  )
);

-- 访客
UPDATE rdos_role_permission SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 4) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit',
    'project_configure_edit',
    'project_configure_delete',
    'project_member_edit',
    'project_member_remove',
    'project_strategy_edit',
    'project_strategy_delete',
    'project_role_edit',
    'datasource_manager_edit',
    'datasource_manager_delete',
    'datadevelop_resourcemanager_query',
    'datadevelop_resourcemanager_edit',
    'datadevelop_resourcemanager_delete',
    'datadevelop_functionmanager_query',
    'datadevelop_functionmanager_edit',
    'datadevelop_functionmanager_delete',
    'datadevelop_taskmanager_edit',
    'datadevelop_taskmanager_run',
    'datadevelop_taskpublish_create',
    'datadevelop_taskpublish_query',
    'datadevelop_taskpublish_download',
    'datadevelop_taskpublish_publish',
    'maintenance_alarm_custom_edit',
    'maintenance_alarm_custom_delete'
  )
);

-- 数据开发
UPDATE rdos_role_permission SET is_deleted=1 where role_id in (select id from rdos_role WHERE role_value = 5) and permission_id IN (
  SELECT id from rdos_permission where type = 1 and code in (
    'project_edit',
    'project_configure_delete',
    'project_member_edit',
    'project_member_remove',
    'project_strategy_edit',
    'project_strategy_delete',
    'project_role_edit',
    'datasource_manager_edit',
    'datasource_manager_delete',
    'datadevelop_taskpublish_create',
    'datadevelop_taskpublish_query',
    'datadevelop_taskpublish_download',
    'datadevelop_taskpublish_publish'
  )
);
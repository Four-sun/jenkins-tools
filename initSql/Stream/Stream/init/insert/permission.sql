BEGIN;

INSERT INTO `rdos_user` VALUES ('-1', '-1', 'system@dtstack.com', 'system@dtstack.com', '0', '2017-06-05 20:35:16', '2017-06-05 20:35:16', '0', null, '111111');

INSERT INTO `rdos_role`
VALUES
  ('1', '-1', '-1', '租户所有者', '1', '1', '本项目内的全部权限，具有本租户内的最高权限', '0', '0', now(), now(), '0'),
  ('2', '-1', '-1', '项目所有者', '1', '2', '项目空间的创建者，拥有项目空间内的最高权限，可对该项目空间的基本属性、数据源、当前项目空间的全部资源和项目成员等进行管理，并为项目成员赋予项目管理员、开发、运维、访客角色。', '0', '0', now(), now(), '0'),
  ('3', '-1', '-1', '项目管理员', '1', '3', '项目空间的管理者，可对该项目空间的基本属性、数据源、当前项目空间的全部资源和项目成员等进行管理，并为项目成员赋予项目管理员、开发、运维、访客角色。项目管理员不能对项目所有者操作。', '0', '0', now(), now(), '0'),
  ('5', '-1', '-1', '访客', '1', '4', '只具备查看权限，没有权限进行编辑任务、运维等操作。', '0', '0', now(), now(), '0'),
  ('4', '-1', '-1', '数据开发', '1', '5', '能够创建任务、脚本、资源等，新建/删除表，但不能执行发布操作。', '0', '0', now(), now(), '0'),
  ('6', '-1', '-1', '租户管理员', '1', '6', '本项目内的全部权限，具有本租户内的最高权限，但不能对租户所有者操作', '0', '0', now(), now(), '0');

-- root
INSERT INTO `rdos_permission` VALUES (1,'root','root','root',0,1,now(),now(),0);

-- 项目管理
INSERT INTO `rdos_permission` VALUES (2,'project','项目管理','项目管理',1,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (3,'project_edit','项目管理_创建/删除','创建/删除',2,1,now(),now(),0);

-- 项目管理 项目配置
INSERT INTO `rdos_permission` VALUES (4,'project_configure','项目管理_项目配置','项目配置',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (5,'project_configure_query','项目管理_项目配置_查看','查看',4,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (6,'project_configure_edit','项目管理_项目配置_新增/编辑','新增/编辑',4,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (7,'project_configure_delete','项目管理_项目配置_删除','删除',4,1,now(),now(),0);

-- 项目管理 成员管理
INSERT INTO `rdos_permission` VALUES (8,'project_member','项目管理_项目成员管理','项目成员管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (9,'project_member_query','项目管理_项目成员管理_查看','查看',8,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (10,'project_member_edit','项目管理_项目成员管理_添加成员/编辑角色','添加成员/编辑角色',8,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (11,'project_member_remove','项目管理_项目成员管理_移出项目','移出项目',8,1,now(),now(),0);


-- 项目管理 启停策略管理
INSERT INTO `rdos_permission` VALUES (12,'project_strategy','项目管理_启停策略管理','启停策略管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (13,'project_strategy_query','项目管理_启停策略管理_查看','查看',12,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (14,'project_strategy_edit','项目管理_启停策略管理_新增/编辑','新增/编辑',12,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (15,'project_strategy_delete','项目管理_启停策略管理_删除','删除',12,1,now(),now(),0);

-- 项目管理 角色管理
INSERT INTO `rdos_permission` VALUES (16,'project_role','项目管理_角色管理','角色管理',2,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (17,'project_role_query','项目管理_角色管理_查看','查看',16,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (18,'project_role_edit','项目管理_角色管理_编辑','编辑',16,1,now(),now(),0);
-- end

-- 数据源
INSERT INTO `rdos_permission` VALUES (19,'datasource','数据源','数据源',1,1,now(),now(),0);
-- 数据源 新增数据源
INSERT INTO `rdos_permission` VALUES (20,'datasource_manager','数据源_数据源管理','数据源管理',19,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (21,'datasource_manager_query','数据源_数据源管理_查看','查看',20,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (22,'datasource_manager_edit','数据源_数据源管理_引入数据源','引入数据源',20,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (23,'datasource_manager_delete','数据源_数据源管理_取消数据源','取消数据源',20,1,now(),now(),0);
-- end

-- 数据开发
INSERT INTO `rdos_permission` VALUES (24,'datadevelop','数据开发','数据开发',1,1,now(),now(),0);
-- 数据开发 资源管理
INSERT INTO `rdos_permission` VALUES (25,'datadevelop_resourcemanager','数据开发_资源管理','资源管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (26,'datadevelop_resourcemanager_query','数据开发_资源管理_查看','查看',25,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (27,'datadevelop_resourcemanager_edit','数据开发_资源管理_上传资源/编辑','上传资源/编辑',25,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (28,'datadevelop_resourcemanager_delete','数据开发_资源管理_删除','删除',25,1,now(),now(),0);

-- 数据开发 函数管理
INSERT INTO `rdos_permission` VALUES (29,'datadevelop_functionmanager','数据开发_函数管理','函数管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (30,'datadevelop_functionmanager_query','数据开发_函数管理_查看','查看',29,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (31,'datadevelop_functionmanager_edit','数据开发_函数管理_新增/编辑','新增/编辑',29,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (32,'datadevelop_functionmanager_delete','数据开发_函数管理_删除','删除',29,1,now(),now(),0);

-- 数据开发 任务管理
INSERT INTO `rdos_permission` VALUES (33,'datadevelop_taskmanager','数据开发_任务管理','任务管理',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (34,'datadevelop_taskmanager_query','数据开发_任务管理_查看','查看',33,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (35,'datadevelop_taskmanager_edit','数据开发_任务管理_编辑','编辑',33,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (36,'datadevelop_taskmanager_run','数据开发_任务管理_提交/停止','提交/停止',33,1,now(),now(),0);

-- 数据开发 任务发布
INSERT INTO `rdos_permission` VALUES (37,'datadevelop_taskpublish','数据开发_任务发布','任务发布',24,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (38,'datadevelop_taskpublish_create','数据开发_任务发布_创建包','创建包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (39,'datadevelop_taskpublish_query','数据开发_任务发布_查看包','查看包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (40,'datadevelop_taskpublish_download','数据开发_任务发布_下载/删除包','下载/删除包',37,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (41,'datadevelop_taskpublish_publish','数据开发_任务发布_发布','发布包',37,1,now(),now(),0);
-- end

-- 任务运维
INSERT INTO `rdos_permission` VALUES (42,'maintenance','任务运维','任务运维',1,1,now(),now(),0);

-- 任务运维  运维信息
INSERT INTO `rdos_permission` VALUES (43,'maintenance_message','任务运维_运维信息','运维信息',42,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (44,'maintenance_message_pandect','任务运维_运维信息_总览','总览',43,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (45,'maintenance_message_query','任务运维_运维信息_查看','查看',43,1,now(),now(),0);

-- 任务运维  监控告警
INSERT INTO `rdos_permission` VALUES (46,'maintenance_alarm','任务运维_监控告警','监控告警',42,1,now(),now(),0);

INSERT INTO `rdos_permission` VALUES (47,'maintenance_alarm_custom','任务运维_监控告警_告警配置','告警配置',46,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (48,'maintenance_alarm_custom_query','任务运维_监控告警_告警配置_查看','查看',47,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (49,'maintenance_alarm_custom_edit','任务运维_监控告警_告警配置_新增/编辑','新增/编辑',47,1,now(),now(),0);
INSERT INTO `rdos_permission` VALUES (50,'maintenance_alarm_custom_delete','任务运维_监控告警_告警配置_删除','删除',47,1,now(),now(),0);

INSERT INTO `rdos_permission` VALUES (51,'maintenance_alarm_record','任务运维_监控告警_告警记录','告警记录',46,1,now(),now(),0);
-- end
commit;
delete from dl_permission;
-- 权限
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (1, 'root', 'root', 'root',0);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (2,'project_manage_menu','项目管理','项目管理',1);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (3,'project_manage_config_menu','项目管理_项目配置','项目配置',2);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (4,'project_manage_config_query','项目管理_项目配置_查看','查看',3);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (5,'project_manage_config_edit','项目管理_项目配置_编辑','编辑',3);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (6,'project_manage_config_delete','项目管理_项目配置_删除','删除',3);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (7,'project_manage_config_hive_address','项目管理_项目配置_项目地址','项目地址',3);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (8,'project_manage_user_menu','项目管理_用户管理','用户管理',2);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (9,'project_manage_user_query','项目管理_用户管理_查看','查看',8);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (10,'project_manage_user_edit','项目管理_用户管理_编辑','新建/编辑',8);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (11,'project_manage_role_menu','项目管理_角色管理','角色管理',2);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (12,'project_manage_role_query','项目管理_角色管理_查看','查看',11);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (13,'project_manage_role_edit','项目管理_角色管理_编辑','新建/编辑',11);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (14,'project_manage_use_group','项目管理_用户分组','用户分组',2);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (15,'project_manage_use_group_query','项目管理_用户分组_查看','查看',14);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (16,'project_manage_use_group_edit','项目管理_用户分组_编辑','编辑',14);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (17,'project_manage_use_group_delete','项目管理_用户分组_删除','删除',14);




INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (18,'entity_manage_menu','实体管理','实体管理',1);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (19,'entity_manage_entity_menu','实体管理_实体管理','实体管理',18);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (20,'entity_manage_entity_query','实体管理_实体管理_查看','查看',19);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (21,'entity_manage_entity_edit','实体管理_实体管理_新建/编辑','新建/编辑',19);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (22,'entity_manage_entity_delete','实体管理_实体管理_删除','删除',19);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (23,'entity_manage_relation_menu','实体管理_关系管理','关系管理',18);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (24,'entity_manage_relation_query','实体管理_关系管理_查看','查看',23);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (25,'entity_manage_relation_edit','实体管理_关系管理_新建/编辑','新建/编辑',23);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (26,'entity_manage_relation_delete','实体管理_关系管理_删除','删除',23);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (27,'entity_manage_dict_menu','实体管理_字典','字典',18);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (28,'entity_manage_dict_query','实体管理_字典_查看','查看',27);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (29,'entity_manage_dict_edit','实体管理_字典_新建/编辑','新建/编辑',27);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (30,'entity_manage_dict_delete','实体管理_字典_删除','删除',27);






INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (31,'tag_center_menu','标签中心','标签中心',1);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (32,'tag_center_tag_market','标签中心_标签市场','标签中心_标签市场',31);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (33,'tag_center_tag_market_query','标签中心_标签市场_查看','标签中心_标签市场_查看',32);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (34,'tag_center_tag_market_apply','标签中心_标签市场_申请','标签中心_标签市场_申请',32);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (35,'tag_center_tag_config','标签中心_标签管理','标签中心_标签管理',31);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (36,'tag_center_tag_config_tag_catalog','标签中心_标签管理_标签目录','标签目录',35);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (37,'tag_center_tag_config_tag_catalog_add','标签中心_标签管理_标签目录_新增','新增',36);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (38,'tag_center_tag_config_tag_catalog_rename','标签中心_标签管理_标签目录_重命名','重命名',36);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (39,'tag_center_tag_config_tag_catalog_move','标签中心_标签管理_标签目录_目录整理','目录整理',36);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (40,'tag_center_tag_config_tag_catalog_delete','标签中心_标签管理_标签目录_删除','删除',36);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (41,'tag_center_tag_config_tag_configure','标签中心_标签管理_标签配置','标签配置',35);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (42,'tag_center_tag_config_tag_configure_query','标签中心_标签管理_标签配置_查看','查看',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (43,'tag_center_tag_config_tag_configure_edit','标签中心_标签管理_标签配置_新建/编辑','新建/编辑',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (44,'tag_center_tag_config_tag_configure_sort','标签中心_标签管理_标签配置_标签整理','标签整理',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (45,'tag_center_tag_config_tag_configure_delete','标签中心_标签管理_标签配置_删除','删除',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (46,'tag_center_tag_config_tag_configure_publish','标签中心_标签管理_标签配置_发布/下线','发布/下线',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (47,'tag_center_tag_config_tag_configure_update','标签中心_标签管理_标签配置_标签更新','标签更新',41);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (48,'tag_center_my_tag','标签中心_我的标签','我的标签',31);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (49,'tag_center_my_tag_query','标签中心_我的标签_查看','查看',48);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (50,'tag_center_my_tag_edit','标签中心_我的标签_操作','操作',48);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (51,'tag_center_approve','标签中心_标签审批','标签审批',31);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (52,'tag_center_task_center','标签中心_任务中心','任务中心',31);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (53,'tag_center_task_center_manager','标签中心_任务中心_任务管理','任务管理',52);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (54,'tag_center_task_center_manager_query','标签中心_任务中心_任务管理_查看','查看',53);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (55,'tag_center_task_center_manager_frozen','标签中心_任务中心_任务管理_冻结/解冻','冻结/解冻',53);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (56,'tag_center_task_center_instance','标签中心_任务中心_标签实例','标签实例',52);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (57,'tag_center_task_center_instance_query','标签中心_任务中心_标签实例_查看','查看',56);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (58,'tag_center_task_center_instance_kill','标签中心_任务中心_标签实例_杀任务/重跑任务','杀任务/重跑任务',56);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (59,'tag_center_task_center_instance_log','标签中心_任务中心_标签实例_查看日志','查看日志',56);


INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (60,'tag_center_task_center_group_instance','标签中心_任务中心_群组实例','标签实例',31);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (61,'tag_center_task_center_group_instance_query','标签中心_任务中心_群组实例_查看','查看',60);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (62,'tag_center_task_center_group_instance_kill','标签中心_任务中心_群组实例_杀任务/重跑任务','杀任务/重跑任务',61);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (63,'tag_center_task_center_group_instance_log','标签中心_任务中心_群组实例_查看日志','查看日志',61);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (64,'group_analysis_menu','群组分析','群组分析',1);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (65,'group_analysis_manage_menu','群组分析_群组管理','群组管理',64);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (66,'group_analysis_manage_query','群组分析_群组管理_查看','查看',65);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (67,'group_analysis_manage_edit','群组分析_群组管理_新建/编辑','新建/编辑',65);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (68,'group_analysis_manage_delete','群组分析_群组管理_删除','删除',65);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (69,'group_analysis_manage_upload','群组分析_上传本地群组/标签圈群','上传本地群组/标签圈群',64);


INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (70,'group_analysis_group_analysis','群组分析_群组分析','群组分析',64);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (71,'group_analysis_compare_analysis','群组分析_群组分析_对比分析','对比分析',70);


INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (72,'group_analysis_group_api','群组分析_群组API','群组API',64);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (73,'group_analysis_group_api_query','群组分析_群组API_查看','查看',72);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (74,'group_analysis_group_api_edit','群组分析_群组API_新建/编辑','新建/编辑',72);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (75,'group_analysis_group_api_publish','群组分析_群组API_发布/禁用','发布/禁用',72);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (76,'group_analysis_group_api_delete','群组分析_群组API_删除','删除',72);

INSERT INTO `dl_role`(`tenant_id`, `project_id`, `role_name`, `role_type`, `role_value`, `role_desc`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
VALUES ( -1, -1, '租户管理员', 1, 7, '本项目内的全部权限，具有本项目内的最高权限', '2019-11-29 10:46:17', '2019-11-29 10:46:17', 0, 0, 0);

INSERT INTO dl_role( project_id , tenant_id , role_name , role_type , role_value , role_desc ,create_at,update_at,create_by,update_by,is_deleted)
select id,tenant_id,'租户管理员',1,7,'本项目内的全部权限，具有本项目内的最高权限',now(),now(),dp.create_by,dp.update_by,0 from dl_project dp where dp.id not in(
select project_id from dl_role where role_value = 7 and is_deleted = 0
) and is_deleted = 0;

delete from dl_role_permission;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 1) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 7) a ,(select id  from dl_permission where id!=1 and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from 
(select id from  dl_role where role_value = 2) a ,
(select id  from dl_permission where id not in (1,5) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from 
(select id  from dl_role where role_value = 3) a ,
(select id  from dl_permission where id not in (1,5) and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 4) a ,
(select  id from dl_permission where id not in(1,5,6,7,10,17,18,19,20,21,22,23,24,25,26,27,28,29,30,35,36,37,38,39,40,41,42,43,44,45,46,47,51,52,53,54,55,56,57,58,59,60,61,62,63)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 5) a ,
(select id from dl_permission where id not in(1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,34,36,37,38,39,40,43,44,45,46,47,50,51,55,58,59,62,63,67,68,70,71,74,75,76)
and is_deleted = 0) b;

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select a.id,b.id,now(), now(), 0, 0, 0  from (select id  from dl_role where role_value = 6) a ,
(select  id from dl_permission where id not in (1,5,6,7,10,17)  and is_deleted = 0) b;
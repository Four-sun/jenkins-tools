

INSERT INTO `role` VALUES ('1', '-1', '租户所有者', '1', '1', '本集群内的全部权限，具有本租户内的最高权限。', '0', now(), now(), '0',-1);
INSERT INTO `role` VALUES ('4', '-1', '访客', '1', '3', '能够查看Topic、Broker详情，但无法执行具体操作。', '0', now(), now(), '0',-1);
-- 增加数据开发角色 （数据开发的api管理权限中，查看、编辑权限都有。但数据开发只能编辑、发布、禁用、启用自己创建的api，不能修改和管理他人的API，但可查看他人的API信息）
INSERT INTO `role` VALUES ('5', '-1', '数据开发', '1', '5', '能够查看Topic，进行数据采样，但无法执行查看集群详情或进行其他操作。', '0', now(), now(), '0',-1);
INSERT INTO role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id, cluster_id)
VALUES (6,-1, '集群所有者', 1, 6, '集群的创建者，拥有集群内的最高权限，可对该集群内的Topic、Broker、分区和项目成员等进行管理，并为集群成员赋予就能管理员、数据开发、访客角色。', 0,-1);
INSERT INTO role (id,tenant_id, role_name, role_type, role_value, role_desc, modify_user_id, cluster_id)
VALUES (7,-1, '集群管理员', 1, 7, '集群的管理者，可对该集群内的Topic、Broker、分区和集群成员等进行管理，并为集群成员赋予集群管理员、数据开发、访客角色。集群管理员不能对集群所有者操作。', 0,-1);
-- 增加租户管理员，权限与租户所有者相同
INSERT INTO role (id, tenant_id, role_name, role_value, role_desc, modify_user_id, is_deleted, cluster_id)
VALUES (8, -1, '租户管理员', 8, '本项目内的全部权限，具有本租户内的全部权限，但不能对租户所有者操作', 0, 0, -1);

INSERT INTO `user`(`id`, `dtuic_user_id`, `user_name`, `email`, `status`, `gmt_create`, `gmt_modified`, `is_deleted`, `phone_number`) VALUES
(1, 1, 'admin@dtstack.com', 'admin@dtstack.com', 0, '2020-11-25 14:46:32', '2020-11-25 14:46:32', 0, '15757131114'),
(2, 2, 'ad', 'ad', 0, '2020-12-28 15:25:33', '2020-12-28 15:25:33', 0, '122');

-- *******************************************
-- 增加权限信息，并为角色分配权限
INSERT INTO `permission` VALUES ('1', 'root', 'root', 'root', '0', '1', '2018-03-10 12:56:07', '2018-03-10 12:56:07', '0');
INSERT INTO `permission` VALUES ('2', 'user_menu', '用户管理', '用户管理', '1', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('4', 'user_list_menu', '用户管理_用户列表', '用户列表', '2', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('6', 'user_list_query', '用户管理_用户列表_查看', '查看', '4', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('8', 'user_list_edit', '用户管理_用户列表_编辑', '编辑', '4', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
-- INSERT INTO `permission` VALUES ('8', 'user_list_add', '用户管理_用户列表_编辑', '编辑', '4', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('12', 'role_menu', '用户管理_角色管理', '角色管理', '2', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('14', 'role_query', '用户管理_角色管理_查看', '查看', '12', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
-- INSERT INTO `permission` VALUES ('16', 'role_edit', '用户管理_角色管理_编辑', '编辑', '12', '1', '2018-04-16 19:56:12', '2018-04-16 19:56:12', '0');
INSERT INTO `permission` VALUES ('18', 'cluster_menu', '集群管理', '集群管理', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('20', 'cluster_query', '集群管理_查看', '查看', '18', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('22', 'cluster_add', '集群管理_新增', '新增', '18', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('24', 'cluster_edit', '集群管理_修改', '修改', '18', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('26', 'cluster_del', '集群管理_删除', '删除', '18', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('28', 'topic_menu', 'Topic管理', 'Topic管理', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('30', 'topic_query', 'Topic管理_查看', '查看', '28', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('32', 'topic_add', 'Topic管理_新增', '新增', '28', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('34', 'topic_edit', 'Topic管理_修改', '修改', '28', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('36', 'topic_del', 'Topic管理_删除', '删除', '28', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('38', 'topic_reset_offset', 'Topic管理_重置offset', '重置offset', '28', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('40', 'data_sampling_menu', '数据采样', '数据采样', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('41', 'data_sampling', '数据采样', '数据采样', '40', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('42', 'cluster_detail_menu', '集群详情', '集群详情', '1', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('44', 'cluster_detail_query', '集群详情_查看集群', '查看集群', '42', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('46', 'cluster_detail_query_brokers', '集群管理_查看broker详情', '查看broker详情', '42', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('48', 'cluster_detail_leader_rebalance', '集群管理_重置领导者', '重置领导者', '42', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('50', 'cluster_detail_add_con', '集群管理_新增controller', '新增controller', '42', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');
INSERT INTO `permission` VALUES ('52', 'cluster_detail_del_con', '集群管理_删除controller', '删除controller', '42', '1', '2018-04-16 19:56:13', '2018-04-16 19:56:13', '0');


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
DECLARE cur CURSOR FOR (select id ,code ,parent_id from permission where is_deleted=0 and type = 1);
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO authId,authCode,authPId;
    WHILE ( stop is not null) DO
    SET @p_count = (select count(1) p_count from permission where (parent_id = authId and LOCATE("menu", authCode) = 0) and is_deleted=0);
    IF @p_count=0 THEN
    -- 租户所有者
    INSERT INTO role_permission(role_id,permission_id) VALUES ('1', authId);
    -- 访客
    INSERT INTO role_permission(role_id,permission_id) VALUES ('4', authId);
    -- 数据开发
    INSERT INTO role_permission(role_id,permission_id) VALUES ('5', authId);
    -- 集群所有者
    INSERT INTO role_permission(role_id,permission_id) VALUES ('6', authId);
    -- 集群管理员
    INSERT INTO role_permission(role_id,permission_id) VALUES ('7', authId);
    -- 租户管理员
    INSERT INTO role_permission(role_id,permission_id) VALUES ('8', authId);
    END IF;
    FETCH cur INTO authId,authCode,authPId;
    END WHILE;

CLOSE cur;

-- 集群所有者
delete from role_permission where role_id = (SELECT id FROM role WHERE role_value = 6) and permission_id IN (
    SELECT id from permission where type = 1 and code in (
      'cluster_add',
      'cluster_edit',
      'cluster_del'
        )
);

-- 集群管理员
delete from role_permission where role_id = (SELECT id FROM role WHERE role_value = 7) and permission_id IN (
    SELECT id from permission where type = 1 and code in (
                                                          'cluster_add',
                                                          'cluster_edit',
                                                          'cluster_del'
        )
);

-- 访客
delete from role_permission where role_id = (SELECT id FROM role WHERE role_value = 3) and permission_id IN (
  SELECT id from permission where type = 1 and code in (
    'user_list_edit',
    'cluster_add',
		'cluster_edit',
		'cluster_del',
		'topic_menu',
		'topic_query',
		'topic_add',
		'topic_edit',
		'topic_del',
		'topic_reset_offset',
		'data_sampling_menu',
		'data_sampling',
		'cluster_detail_menu',
		'cluster_detail_query',
		'cluster_detail_query_brokers',
		'cluster_detail_leader_rebalance',
		'cluster_detail_add_con',
		'cluster_detail_del_con'
  )
);


-- 数据开发
delete from role_permission where role_id = (SELECT id FROM role WHERE role_value = 5) and permission_id IN (
  SELECT id from permission where type = 1 and code in (
        'user_list_edit',
        'cluster_add',
        'cluster_edit',
        'cluster_del',
        'topic_add',
        'topic_edit',
        'topic_del',
        'topic_reset_offset',
        'cluster_detail_menu',
        'cluster_detail_query',
        'cluster_detail_query_brokers',
        'cluster_detail_leader_rebalance',
        'cluster_detail_add_con',
        'cluster_detail_del_con'
      )
);

END;//

delimiter ;

CALL pr_auth_admin();

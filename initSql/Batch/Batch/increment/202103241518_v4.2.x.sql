--  #项目相关
ALTER TABLE rdos_project ADD COLUMN modify_user_id int(11) COMMENT '修改人id';
ALTER TABLE rdos_project_stick CHANGE user_id create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_project_stick ADD modify_user_id int(11) COMMENT '修改人id';
ALTER TABLE rdos_project_engine ADD create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_project_engine ADD modify_user_id int(11) COMMENT '修改人id';

--  #读写锁表:增加 tenant_id和create_user_id字段
ALTER TABLE rdos_read_write_lock ADD tenant_id int(11) COMMENT '租户id';
ALTER TABLE rdos_read_write_lock ADD create_user_id int(11) COMMENT '创建人id';

--  #角色表增加:创建人id
ALTER TABLE rdos_role ADD create_user_id int(11) COMMENT '创建人id';

--  #角色权限表:增加创建人id，修改人Id，创建时间，修改时间 字段
ALTER TABLE rdos_role_permission ADD create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_role_permission ADD modify_user_id int(11) COMMENT '修改人id';
ALTER TABLE rdos_role_permission ADD tenant_id int(11) COMMENT '租户id';
ALTER TABLE rdos_role_permission ADD project_id int(11) COMMENT '项目Id';

--  #角色-用户关系表增加:创建人id，修改人Id 字段
ALTER TABLE rdos_role_user ADD create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_role_user ADD modify_user_id int(11) COMMENT '修改人id';

--  #表字段权限申请表增加:创建人id，修改人Id 字段
ALTER TABLE rdos_user_column_permission ADD create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_user_column_permission ADD modify_user_id int(11) COMMENT '修改人id';

--  #表权限申请表增加:创建人id，修改人Id 字段
ALTER TABLE rdos_user_operator_permission ADD create_user_id int(11) COMMENT '创建人id';
ALTER TABLE rdos_user_operator_permission ADD modify_user_id int(11) COMMENT '修改人id';
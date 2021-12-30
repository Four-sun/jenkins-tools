ALTER TABLE dl_group_tag COMMENT='群组圈群标签';
ALTER TABLE dl_group_tag MODIFY COLUMN group_tag_id int(11) NOT NULL COMMENT '群组圈群标签id';

ALTER TABLE dl_group_tag ADD tag_id int(11) NOT NULL COMMENT '标签id';
ALTER TABLE dl_group_tag CHANGE tag_id tag_id int(11) NOT NULL COMMENT '标签id' AFTER project_id;
ALTER TABLE dl_group_tag CHANGE group_tag_id ring_group_id int(11) NULL COMMENT '圈群群组id';

ALTER TABLE dl_group MODIFY COLUMN group_desc varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '群组描述';


UPDATE dl_permission set code="entity_manage_datasource_menu" where id = 14;
UPDATE dl_permission set code="entity_manage_datasource_query" where id = 15;
UPDATE dl_permission set code="entity_manage_datasource_edit" where id = 16;
UPDATE dl_permission set code="entity_manage_datasource_delete" where id = 17;


INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (53,'group_ring_group_menu','群组分析_标签圈群','标签圈群',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (54,'group_ring_group_query','群组分析_标签圈群_查看','查看',53);

INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (55,'group_comparative_analysis_menu','群组分析_对比分析','对比分析',41);
INSERT INTO dl_permission(id,code,name,display,parent_id) VALUES (56,'group_comparative_analysis_query','群组分析_对比分析_查看','查看',55);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 53, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 53) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 54, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 54) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 55, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 55) and role_value in (1,2,3,4,5);

INSERT INTO `dl_role_permission`( `role_id`, `permission_id`, `create_at`, `update_at`, `create_by`, `update_by`, `is_deleted`)
select  id, 56, NOW(), NOW(), 0, 0, 0
from dl_role where
dl_role.id not in (select role_id from dl_role_permission
where permission_id = 56) and role_value in (1,2,3,4,5);
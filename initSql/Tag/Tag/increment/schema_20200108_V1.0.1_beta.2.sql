ALTER TABLE dl_api ADD api_token varchar(255) NOT NULL COMMENT 'API token';
ALTER TABLE dl_api CHANGE api_token api_token varchar(255) NOT NULL COMMENT 'API token' AFTER api_desc;

UPDATE dl_permission set code="entity_manage_datasource_menu",name="数据源管理",parent_id=1 where id = 14;
UPDATE dl_permission set code="entity_manage_datasource_query",name="数据源管理",parent_id=14 where id = 15;
UPDATE dl_permission set code="entity_manage_datasource_edit",name="数据源管理_查看",parent_id=14 where id = 16;
UPDATE dl_permission set code="entity_manage_datasource_delete",name="数据源管理_新建/编辑",parent_id=14 where id = 17;

ALTER TABLE dl_relation_used_record DROP COLUMN user_group_id;
ALTER TABLE dl_relation_used_record CHANGE used_tag_id used_id int(11) NULL COMMENT '调用的衍生标签id';

update dl_tag_cate SET cate_name = '未分类' where cate_name = '默认分类';
update dl_tag_cate SET `level` = 0;
CREATE INDEX `index_entity_id2` ON `dl_tag`( `entity_id` );
CREATE INDEX `index_tag_status2` ON `dl_tag`( `tag_status` );
CREATE INDEX `index_tag_type2` ON `dl_tag`( `tag_type` );
CREATE INDEX `index_tag_update_status2` ON `dl_tag`( `tag_update_status` );
CREATE INDEX `index_tagsql_id2` ON `dl_tag`( `tagsql_id` );

CREATE INDEX `index_entity_id2` ON `dl_tag_publish`( `entity_id` );
CREATE INDEX `index_publish_status2` ON `dl_tag_publish`( `publish_status` );
CREATE INDEX `index_tag_id2` ON `dl_tag_publish`( `tag_id` );
CREATE INDEX `index_project_id2` ON `dl_tag_publish`( `project_id` );

CREATE INDEX `index_cate_id2` ON `dl_tag_cate_rel`( `cate_id` );
CREATE INDEX `index_tag_id2` ON `dl_tag_cate_rel`( `tag_id` );

CREATE INDEX `index_tag_id2` ON `dl_user_group_tag_rel`( `tag_id` );
CREATE INDEX `index_project_id2` ON `dl_user_group_tag_rel`( `project_id` );
CREATE INDEX `index_user_id2` ON `dl_user_group_tag_rel`( `user_id` );

CREATE INDEX `index_project_id2` ON `dl_user_group_rel`( `project_id` );
CREATE INDEX `index_user_group_id2` ON `dl_user_group_rel`( `user_group_id` );
CREATE INDEX `index_user_id2` ON `dl_user_group_rel`( `user_id` );

CREATE INDEX `index_user_id2` ON `dl_role_user`( `user_id` );
CREATE INDEX `index_project_id2` ON `dl_role_user`( `project_id` );
CREATE INDEX `index_tenant_id2` ON `dl_role_user`( `tenant_id` );
ALTER TABLE dl_tag ADD tag_relation_entity_name varchar(100) DEFAULT NULL COMMENT '关系所属实体名称';
ALTER TABLE dl_tag CHANGE tag_relation_entity_name tag_relation_entity_name varchar(100) DEFAULT NULL COMMENT '关系所属实体名称' AFTER relation_id;

ALTER TABLE dl_tag ADD tagsql_id int(11) DEFAULT NULL COMMENT '产生衍生标签的sql id';
ALTER TABLE dl_tag CHANGE tagsql_id tagsql_id int(11) DEFAULT NULL COMMENT '产生衍生标签的sql id' AFTER relation_id;


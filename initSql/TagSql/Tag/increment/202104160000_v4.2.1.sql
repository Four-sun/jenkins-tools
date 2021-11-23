ALTER TABLE dl_tag_task CHANGE group_id tag_group_id int(11) NULL COMMENT '标签/群组id';
ALTER TABLE dl_tag_task MODIFY COLUMN tag_group_id int(11) NULL COMMENT '标签/群组id';

ALTER TABLE dl_tag ADD data_type_str varchar(255) NULL COMMENT '数据类型';
ALTER TABLE dl_tag CHANGE data_type_str data_type_str varchar(255) NULL COMMENT '数据类型' AFTER tag_identifier;

ALTER TABLE dl_tag ADD circle_entity_id int(11) NULL COMMENT '圈选实体';
ALTER TABLE dl_tag CHANGE circle_entity_id circle_entity_id int(11) NULL COMMENT '圈选实体' AFTER tag_dict_id;

ALTER TABLE dl_relation ADD primary_key varchar(255) NOT NULL COMMENT '主键';
ALTER TABLE dl_relation CHANGE primary_key primary_key varchar(255) NOT NULL COMMENT '主键' AFTER module_type;

ALTER TABLE dl_tag_task MODIFY COLUMN schedule_conf varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '调度配置 json格式';
ALTER TABLE dl_tag_task MODIFY COLUMN task_desc varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL;

ALTER TABLE dl_entity ADD relation_type TINYINT(1) NULL COMMENT '关系类型 0:逻辑表 1:物理表';
ALTER TABLE dl_entity CHANGE relation_type relation_type TINYINT(1) NULL COMMENT '关系类型 0:逻辑表 1:物理表' AFTER relation_id;

ALTER TABLE dl_entity MODIFY COLUMN data_source_table varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据表（ES索引）';

ALTER TABLE dl_tag ADD tag_relation_entiy_name varchar(100) NULL COMMENT '关系所属实体名称';
ALTER TABLE dl_tag CHANGE tag_relation_entiy_name tag_relation_entiy_name varchar(100) NULL COMMENT '关系所属实体名称' AFTER relation_id;

ALTER TABLE dl_relation ADD parent_task_id_source INT NULL COMMENT '父任务数据来源';
ALTER TABLE dl_relation CHANGE parent_task_id_source parent_task_id_source INT NULL COMMENT '父任务数据来源' AFTER parent_task_name;

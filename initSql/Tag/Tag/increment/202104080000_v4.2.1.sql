ALTER TABLE dl_relation CHANGE entity_id relation_belong_entity_id int(11) NULL COMMENT '关系隶属实体';
ALTER TABLE dl_relation MODIFY COLUMN relation_belong_entity_id int(11) NULL COMMENT '关系隶属实体';

update dl_relation set module_type = 0 where module_type is null;
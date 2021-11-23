ALTER TABLE dl_relation ADD entity_id int(11) NULL COMMENT '实体id';
ALTER TABLE dl_relation CHANGE entity_id entity_id int(11) NULL COMMENT '实体id' AFTER data_source_id;

ALTER TABLE dl_relation ADD module_type tinyint(1) NULL COMMENT '储存模型 0:逻辑关系 1:物理表';
ALTER TABLE dl_relation CHANGE module_type module_type tinyint(1) NULL COMMENT '储存模型 0:逻辑关系 1:物理表' AFTER relation_desc;

ALTER TABLE dl_relation_collection MODIFY COLUMN right_attr_id int(11) NULL COMMENT '右表维度id';
ALTER TABLE dl_relation_collection MODIFY COLUMN left_attr_id int(11) NULL COMMENT '左表维度id';

ALTER TABLE dl_relation_collection MODIFY COLUMN left_entity_id int(11) NULL COMMENT '左表实体id';
ALTER TABLE dl_relation_collection MODIFY COLUMN right_entity_id int(11) NULL COMMENT '右表实体id';

ALTER TABLE dl_entity_attr ADD entity_name varchar(255) NULL COMMENT '实体名称';
ALTER TABLE dl_entity_attr CHANGE entity_name entity_name varchar(255) NULL COMMENT '实体名称' AFTER entity_id;

ALTER TABLE dl_entity_attr ADD data_type_str varchar(255) NULL COMMENT '数据类型';
ALTER TABLE dl_entity_attr CHANGE data_type_str data_type_str varchar(255) NULL COMMENT '数据类型' AFTER data_type;

ALTER TABLE dl_relation_collection ADD join_type TINYINT(1) NULL COMMENT '关联关系 1:LeftJoin 2:RightJoin 3:InnerJoin 4:OuterJoin';
ALTER TABLE dl_relation_collection CHANGE join_type join_type TINYINT(1) NULL COMMENT '关联关系 1:LeftJoin 2:RightJoin 3:InnerJoin 4:OuterJoin' AFTER right_attr_name;

ALTER TABLE dl_relation ADD module_id int(11) NULL COMMENT '模型id';
ALTER TABLE dl_relation CHANGE module_id module_id int(11) NULL COMMENT '模型id' AFTER relation_desc;

ALTER TABLE dl_tag MODIFY COLUMN tag_type tinyint(1) NOT NULL COMMENT '标签类型,0：原子标签,1:衍生标签，2:自定义标签 3.组合标签 4:物理表标签 5:附表标签';

ALTER TABLE dl_table_sync ADD begin_date varchar(64) NULL COMMENT '开始时间';
ALTER TABLE dl_table_sync CHANGE begin_date begin_date varchar(64) NULL COMMENT '开始时间' AFTER sync_minute;

ALTER TABLE dl_table_sync ADD end_date varchar(64) NULL COMMENT '结束时间';
ALTER TABLE dl_table_sync CHANGE end_date end_date varchar(64) NULL COMMENT '结束时间' AFTER begin_date;

ALTER TABLE dl_table_sync ADD begin_min varchar(64) NULL COMMENT '开始时间分钟';
ALTER TABLE dl_table_sync CHANGE begin_min begin_min varchar(64) NULL COMMENT '开始时间分钟' AFTER end_date;

ALTER TABLE dl_table_sync ADD end_min varchar(64) NULL COMMENT '结束时间分钟';
ALTER TABLE dl_table_sync CHANGE end_min end_min varchar(64) NULL COMMENT '结束时间分钟' AFTER begin_min;

ALTER TABLE dl_table_sync ADD gap_min varchar(64) NULL COMMENT '间隔时间分钟';
ALTER TABLE dl_table_sync CHANGE gap_min gap_min varchar(64) NULL COMMENT '间隔时间分钟' AFTER end_min;

ALTER TABLE dl_table_sync ADD begin_hour varchar(64) NULL COMMENT '结束时间小时';
ALTER TABLE dl_table_sync CHANGE begin_hour begin_hour varchar(64) NULL COMMENT '结束时间小时' AFTER gap_min;

ALTER TABLE dl_table_sync ADD end_hour varchar(64) NULL COMMENT '结束时间小时';
ALTER TABLE dl_table_sync CHANGE end_hour end_hour varchar(64) NULL COMMENT '结束时间小时' AFTER begin_hour;

ALTER TABLE dl_table_sync ADD gap_hour varchar(64) NULL COMMENT '间隔时间小时';
ALTER TABLE dl_table_sync CHANGE gap_hour gap_hour varchar(64) NULL COMMENT '间隔时间小时' AFTER end_hour;

ALTER TABLE dl_relation ADD parent_task_id int(11) NULL COMMENT '父任务id';
ALTER TABLE dl_relation CHANGE parent_task_id parent_task_id int(11) NULL COMMENT '父任务id' AFTER module_type;
ALTER TABLE dl_relation ADD parent_task_name varchar(100) NULL COMMENT '父任务名称';
ALTER TABLE dl_relation CHANGE parent_task_name parent_task_name varchar(100) NULL COMMENT '父任务名称' AFTER parent_task_id;

ALTER TABLE dl_entity ADD relation_id INT(11) NULL COMMENT '关系id';
ALTER TABLE dl_entity CHANGE relation_id relation_id INT(11) NULL COMMENT '关系id' AFTER entity_current_partition;

ALTER TABLE dl_relation MODIFY COLUMN relation_json text DEFAULT NULL COMMENT '关系JSON(前端展现)';

ALTER TABLE dl_entity ADD relevance_key varchar(255) DEFAULT NULL COMMENT '主附表关联键';
ALTER TABLE dl_entity CHANGE relevance_key relevance_key varchar(255) DEFAULT NULL COMMENT '主附表关联键' AFTER relation_id;

ALTER TABLE dl_entity ADD table_comment varchar(512) DEFAULT NULL COMMENT 'presto中该表的描述';
ALTER TABLE dl_entity CHANGE table_comment table_comment varchar(512) DEFAULT NULL COMMENT 'presto中该表的描述' AFTER relevance_key;

ALTER TABLE dl_tag_task_task ADD task_source int(11) DEFAULT NULL COMMENT '任务来源';
ALTER TABLE dl_tag_task_task CHANGE task_source task_source int(11) DEFAULT NULL COMMENT '任务来源' AFTER task_id;

ALTER TABLE dl_tag_task_task ADD parent_task_source int(11) DEFAULT NULL COMMENT '父任务来源';
ALTER TABLE dl_tag_task_task CHANGE parent_task_source parent_task_source int(11) DEFAULT NULL COMMENT '父任务来源' AFTER parent_task_id;

ALTER TABLE dl_entity MODIFY COLUMN entity_primary_key varchar(255) DEFAULT NULL COMMENT '实体主键';


ALTER TABLE dl_entity ADD master_entity_id int(11) DEFAULT '-1' COMMENT '主表值为-1，附表值为主表id';
ALTER TABLE dl_entity ADD platform_task_id int(11) DEFAULT NULL COMMENT '其他平台任务id';
ALTER TABLE dl_entity ADD platform_task_name varchar(255) DEFAULT NULL COMMENT '其他平台任务name';
ALTER TABLE dl_entity ADD platform_task_source int(2) DEFAULT NULL COMMENT '其他平台任务的来源';

update dl_tag_task_task set task_source = 4 ;
update dl_tag_task_task set parent_task_source = 4 ;
update dl_entity set master_entity_id = -1;
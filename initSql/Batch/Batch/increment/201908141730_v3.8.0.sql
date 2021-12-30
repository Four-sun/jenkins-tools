alter table rdos_batch_sys_parameter
ADD COLUMN gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
ADD COLUMN gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';


ALTER TABLE rdos_table_project_data_history
CHANGE COLUMN `gmt_create` `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
CHANGE COLUMN `gmt_modified` `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';

alter table rdos_batch_task_process_record
ADD COLUMN `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
ADD COLUMN `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
ADD COLUMN `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除';

ALTER TABLE rdos_datamask_config
CHANGE COLUMN `is_deleted` `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除';

alter table rdos_datamask_rule
CHANGE COLUMN `is_deleted` `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除';

alter table rdos_datamask_parse_record
ADD COLUMN `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
ADD COLUMN `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
ADD COLUMN `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除';

alter table rdos_datamask_columns_info
CHANGE COLUMN `is_deleted` `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1逻辑删除';

alter table rdos_batch_sql_template
CHANGE COLUMN `gmt_create` `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
CHANGE COLUMN `gmt_modified` `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';


alter table rdos_job_graph_trigger
CHANGE COLUMN `gmt_create` `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
CHANGE COLUMN `gmt_modified` `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间';

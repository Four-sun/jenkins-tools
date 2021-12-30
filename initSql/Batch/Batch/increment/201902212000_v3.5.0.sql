create table `rdos_carbon_task_relation`(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `task_id` int(11) NOT NULL COMMENT '工作任务id',
    `source_id` int(11) NULL COMMENT '数据源id',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` int(11) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_task_id` (`task_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES ('10', 'CARBON_SQL', '12', 'CarbonSQL', 'CarbonSQL', '12', now(), now(), '0');

-- 每个项目今日的周期实例各状态数量
create table `rdos_batch_job_state_count` (
    `id` int(11) NOT NULL auto_increment,
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `tenant_id` int(11) NOT NULL COMMENT '租户id',
    `failed` int(2) NOT NULL COMMENT '失败',
    `running` int(2) NOT NULL COMMENT '运行中',
    `waitengine` int(2) NOT NULL COMMENT '等待运行',
    `canceled` int(2) NOT NULL COMMENT '取消',
    `unsubmit` int(2) NOT NULL COMMENT '未提交',
    `submitting` int(2) NOT NULL COMMENT '提交中',
    `frozen` int(2) NOT NULL COMMENT '冻结',
    `finished` int(2) NOT NULL COMMENT '完成',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx_project_id` (`project_id`,`tenant_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
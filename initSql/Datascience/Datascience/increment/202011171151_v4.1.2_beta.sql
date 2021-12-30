alter table science_task add `main_algorithm_desc` varchar(256) COMMENT '主要使用的算法说明' after `task_desc`;
alter table science_task add `order_val` int(4) DEFAULT NULL COMMENT '排序字段';
alter table science_task add column component_id int(11) comment '组件id';

CREATE TABLE `science_market_read_table_data` (
                                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                                  `task_id` int(11) NOT NULL COMMENT '任务id',
                                                  `create_table_sql` varchar(2000) NOT NULL COMMENT '建表SQL',
                                                  `table_data_hdfs_url` varchar(500) NOT NULL COMMENT '表数据存放在HDFS上的路径',
                                                  `table_type` tinyint(2) NOT NULL COMMENT '数据表类型，目前只有hive表',
                                                  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
                                                  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                                  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
                                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

update science_task set preset=0 where preset=1;

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `id`, -1, '实验市场', 0, 1, 12, now(), now(), (select id from science_user where user_name='admin@dtstack.com' and email='admin@dtstack.com' limit 1) AS create_user_id, 0 FROM `science_tenant` WHERE is_deleted=0;

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '新零售类', `id`, 1, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '金融类', `id`, 2, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '智能运维类', `id`, 3, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '智慧医疗类', `id`, 4, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '用户运营类', `id`, 5, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';

INSERT INTO `science_catalogue`(`id`, `tenant_id`, `project_id`, `node_name`, `node_pid`, `order_val`, `level`, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted`)
SELECT NULL, `tenant_id`, `project_id`, '情感分析类', `id`, 6, `level` +1, `gmt_create`, `gmt_modified`, `create_user_id`, `is_deleted` FROM `science_catalogue` WHERE is_deleted=0 AND node_pid=0 AND node_name='实验市场';





INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '门店聚类', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 1, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据线下零售门店的大小、类型、地理位置、会员分布对门店进行聚类，以此提供决策依据', 'K-Means聚类', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='新零售类';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '销量预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '利用公司旗下连锁零售店的销售数据和各个店铺特征，预测各个店铺未来N天的销售额。', 'Sarima、GBDT回归', '', '{}', 0, -1, 0, -1, '', 2, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='新零售类';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '智能发券', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '通过RFM模型对用户进行分群，并建立模型预测用户的购买概率，实现对不同用户群组下的不同购买率用户实行不同的发券策略', 'K-Means聚类、XGB分类', '', '{}', 0, -1, 0, -1, '', 3, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='新零售类';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '电影推荐', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '用协同过滤的方式，将用户对电影的评分矩阵进行矩阵分解，得到用户矩阵和电影矩阵，再用内积的方式得到用户对各个电影的预测评分，并以此进行推荐', 'K-Means聚类', '', '{}', 0, -1, 0, -1, '', 4, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='新零售类';


INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '用户流失率预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据用户历史特征数据，以及用户是否流失标签，建立XGB分类模型，预测用户是否会流失，以及流失的概率', 'XGB分类', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='用户运营类';


INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, 'CPU使用率预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据CPU使用率的历史数据，通过时间序列Serima预测未来几个时刻的CPU使用率，同时利用滑动均值算法，检测当前时刻的CPU使用率是否发生异常', 'Serima', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='智能运维类';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '内存使用率预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据内存使用率的历史数据，通过聚合算法使数据平滑，再利用时间序列Serima预测未来几个时刻的内存使用率', 'Serima', '', '{}', 0, -1, 0, -1, '', 2, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='智能运维类';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '磁盘使用率预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据磁盘使用率的历史数据，通过时间序列Serima预测未来几个时刻的磁盘使用率，同时利用当前数据的前4个数据作为样本、当前数据为标签，构造训练数据，通过GBDT回归模型进行训练，构建预测模型', 'Serima、GBDT回归', '', '{}', 0, -1, 0, -1, '', 3, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='智能运维类';


INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '评论情感分析', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-01\",\"endDate\":\"2021-05-01\",\"isFailRetry\":true,\"maxRetryNum\":\"3\",\"scheduleStatus\":1}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据用户的外卖评论数据，分析评论中的情感偏向，得出该评论是正向还是负向评价', '分词、LDA、XGB分类', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='情感分析类';


INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '心脏病预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2021-03-13\",\"isFailRetry\":false,\"maxRetryNum\":\"3\",\"scheduleStatus\":1}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据体检指标，年龄、性别、胸部疼痛类型、血压、胆固醇、空腹血糖、心电图结果、是否心绞痛等预测用户是否会患心脏病', '逻辑回归二分类', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='智慧医疗类';







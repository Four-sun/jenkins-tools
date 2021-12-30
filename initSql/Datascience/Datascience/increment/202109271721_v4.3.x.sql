
-- 实验市场新增两个内置实验模板

DELETE FROM `science_task` WHERE preset = -1 AND NAME = '信用卡评分';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '信用卡评分', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2022-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据客户的属性和行为数据，利用信用评分模型对客户进行信用评分，以此决定是否给予授信和授信的额度，从而识别和减少金融交易中的风险', '逻辑回归', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='金融类';


DELETE FROM `science_task` WHERE preset = -1 AND NAME = '保险出险预测';

INSERT INTO `science_task`(`id`, `tenant_id`, `project_id`, `node_pid`, `name`, `task_type`, `engine_type`, `compute_type`, `sql_text`, `task_params`, `schedule_conf`, `period_type`, `schedule_status`, `submit_status`, `gmt_create`, `gmt_modified`, `modify_user_id`, `create_user_id`, `owner_user_id`, `version`, `is_deleted`, `task_desc`, `main_algorithm_desc`, `main_class`, `exe_args`, `flow_id`, `component_type`, `target_id`, `preset`, `gpu_params`, `order_val`, `component_id`)
SELECT NULL, a.tenant_id, -1, a.id AS node_pid, '保险出险预测', 14, 7, 1, '', '## 每个worker所占内存，比如512m\r\nworker.memory=512m\r\n\n## 每个worker所占的cpu核的数量\r\nworker.cores=1\r\n\n## 任务优先级, 范围:1-1000\r\njob.priority=10', '{\"selfReliance\":false,\"min\":0,\"hour\":0,\"periodType\":\"2\",\"beginDate\":\"2020-10-13\",\"endDate\":\"2022-03-13\",\"isFailRetry\":true,\"maxRetryNum\":\"3\"}', 2, 1, 0, now(), now(), a.create_user_id, a.create_user_id, a.create_user_id, 0, 0, '根据购买保险客户的相关指标，预测保险公司是否将需要理赔以及理赔的概率。', '随机森林分类', '', '{}', 0, -1, 0, -1, '', 1, NULL
FROM `science_catalogue` a
         INNER JOIN `science_catalogue` b ON b.is_deleted=0 AND b.node_pid=0 AND b.node_name='实验市场' AND b.id=a.node_pid
WHERE a.is_deleted=0 AND a.node_name='金融类';
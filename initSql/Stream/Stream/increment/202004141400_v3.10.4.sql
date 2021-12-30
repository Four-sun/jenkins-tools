-- 算子化保存界面组件信息
ALTER TABLE `rdos_stream_task`
ADD COLUMN `operator_jsons` LONGTEXT NULL COMMENT '算子化组件信息';

ALTER TABLE `rdos_stream_task_shade`
ADD COLUMN `operator_jsons` LONGTEXT NULL COMMENT '算子化组件信息';
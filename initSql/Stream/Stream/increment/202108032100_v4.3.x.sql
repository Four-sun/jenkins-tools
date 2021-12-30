ALTER TABLE `rdos_stream_strategy`
ADD COLUMN `extend_config` longtext NULL COMMENT '启停策略扩展参数' AFTER `start_type`;
ALTER TABLE `rdos_stream_strategy`
MODIFY `date_duration` varchar(200) NULL COMMENT '日期跨度集合';
ALTER TABLE `rdos_stream_job`
    ADD COLUMN `user_id` int(11) DEFAULT NULL COMMENT '操作人id' AFTER `tenant_id`;
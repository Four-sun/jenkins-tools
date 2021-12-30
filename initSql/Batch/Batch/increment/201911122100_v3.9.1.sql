alter table rdos_batch_job
    add column `next_cyc_time` varchar(256) DEFAULT NULL COMMENT '下一次调度时间 yyyyMMddHHmmss';
alter table rdos_batch_task_shade
       add column `is_expire`  TINYINT(1)   NOT NULL DEFAULT '0' COMMENT '过期策略：0永不过期 1过期取消';
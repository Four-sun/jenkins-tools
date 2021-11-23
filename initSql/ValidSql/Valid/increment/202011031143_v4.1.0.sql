-- 修改dq_verify_record中report字段类型
alter table dq_verify_record modify report longtext COMMENT '日志信息';

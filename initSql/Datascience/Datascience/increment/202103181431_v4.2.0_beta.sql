ALTER TABLE science_model_version ADD COLUMN  `log_info` TEXT  COMMENT '日志信息';
ALTER TABLE science_model_version MODIFY COLUMN model_file varchar(255) default null comment '模型文件路径';
ALTER TABLE science_model_version MODIFY COLUMN file_size int(11) default 0 comment '模型文件大小';
-- 添加钉钉
insert into dq_dict(type,dict_name,dict_value,dict_name_zh,dict_name_en,dict_sort,is_deleted) VALUES
('4','微信',3,'微信','weChat',3,1),
('4','钉钉',4,'钉钉','ding',4,0);
alter table dq_notify add column `webhook` varchar(256) NOT NULL DEFAULT '' COMMENT '钉钉告警-自定义机器人的webhook';
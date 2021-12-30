-- 增大alarm_type的存储大小，将存储结构修改为json类型
-- 例如 [{"alertGateSource":"default_MAIL_2",\"alertGateType\":1}]
alter table da_alarm_config modify `alarm_type` varchar(1024) NOT NULL DEFAULT '' COMMENT '告警方式';
alter table da_alarm_record modify `send_type` varchar(1024) NOT NULL DEFAULT '' COMMENT '告警方式';

-- 更新老数据
-- 邮箱
update da_alarm_config 
set alarm_type = "[{\"alertGateType\":2,\"alertGateName\":\"邮箱\"}]"
where alarm_type = '0100000000000000000000000000000000000000000000000000000000000000';

-- 短信
update da_alarm_config
set alarm_type = "[{\"alertGateType\":1,\"alertGateName\":\"短信\"}]"
where alarm_type = '0010000000000000000000000000000000000000000000000000000000000000';

-- 钉钉
update da_alarm_config
set alarm_type = "[{\"alertGateType\":3,\"alertGateName\":\"钉钉\"}]"
where alarm_type = '0000100000000000000000000000000000000000000000000000000000000000';

-- 邮箱+短信
update da_alarm_config
set alarm_type = "[{\"alertGateType\":1,\"alertGateName\":\"短信\"},{\"alertGateType\":2,\"alertGateName\":\"邮箱\"}]"
where alarm_type = '0110000000000000000000000000000000000000000000000000000000000000';

-- 邮箱+钉钉
update da_alarm_config
set alarm_type = "[{\"alertGateType\":1,\"alertGateName\":\"短信\"},{\"alertGateType\":3,\"alertGateName\":\"钉钉\"}]"
where alarm_type = '0100100000000000000000000000000000000000000000000000000000000000';

-- 邮箱+短信+钉钉
update da_alarm_config
set alarm_type = "[{\"alertGateType\":1,\"alertGateName\":\"短信\"},{\"alertGateType\":2,\"alertGateName\":\"邮箱\"},{\"alertGateType\":3,\"alertGateName\":\"钉钉\"}]"
where alarm_type = '0110100000000000000000000000000000000000000000000000000000000000';

-- 短信+钉钉
update da_alarm_config
set alarm_type = "[{\"alertGateType\":1,\"alertGateName\":\"短信\"},{\"alertGateType\":3,\"alertGateName\":\"钉钉\"}]"
where alarm_type = '0010100000000000000000000000000000000000000000000000000000000000';
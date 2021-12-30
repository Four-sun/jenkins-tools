ALTER TABLE uic_user ADD is_first_login varchar(1)  NOT NULL DEFAULT 'Y' COMMENT '是否是第一次登录,Y是，N否';

ALTER TABLE uic_tenant ADD external_id  varchar(50) DEFAULT NULL COMMENT '外部租户id';

update uic_user set is_first_login = 'N';
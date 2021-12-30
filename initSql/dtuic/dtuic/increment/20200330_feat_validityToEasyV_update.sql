
CREATE TABLE uic_tenant_product_renew_record (
id INT ( 11 ) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
is_deleted VARCHAR ( 1 ) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
gmt_create datetime DEFAULT NULL COMMENT '创建时间',
gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
creator INT ( 11 ) DEFAULT NULL COMMENT '创建人',
modifier INT ( 11 ) DEFAULT NULL COMMENT '修改人',
tenant_id INT ( 11 ) UNSIGNED NOT NULL COMMENT '关联租户id',
product_code VARCHAR ( 30 ) NOT NULL COMMENT '产品CODE',
before_renew_time datetime DEFAULT NULL COMMENT '续费之前的时间',
after_renew_time datetime DEFAULT NULL COMMENT '续费之后的时间' ,
PRIMARY KEY ( `id`)
) ENGINE = INNODB  DEFAULT CHARSET = utf8 COMMENT = '租户-产品续费记录表';


alter table uic_tenant_product_rel add column product_time datetime default now() COMMENT '产品有效期';

update uic_tenant_product_rel SET product_time = DATE_ADD(now(),INTERVAL 50 YEAR)
where product_code in('RDOS','EASYCLOUD','LOGAPP','EASYDB');


INSERT INTO `uic_event`(event_code, support_method, event_describe) VALUES
  ('ADD_TENANT', 'POST', '新增租户'),
  ('ADD_USER', 'POST', '新增用户'),
  ('EDIT_USER', 'POST', '编辑用户'),
  ('GRANT_USER', 'POST', '用户赋予产品权限'),
  ('TENANT_ADD_USER', 'POST', '租户添加用户'),
  ('TENANT_REMOVE_USER', 'POST', '租户移除用户'),
  ('EDIT_TENANT', 'POST', '编辑租户');
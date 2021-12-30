-- 初始化产品列表
INSERT INTO uic_product(is_deleted, gmt_create, gmt_modified, creator, modifier, product_code, product_name, product_version, prodcut_release_time, prodcut_desc, product_img_url,product_url) VALUES
  ('N',now(),now(),0,0,'LOGAPP','云日志','V1.7','2016-12-12 00:00:00','基于Elasticsearch的实时大数据平台','imgs/log_logo.png','http://127.0.0.1:81/'),
  ('N',now(),now(),0,0,'EASYCLOUD','EASYCLOUD','V1.7','2016-12-12 00:00:00','混合云资源管理平台','imgs/easycloud_logo.png','http://127.0.0.1:81/'),
  ('N',now(),now(),0,0,'EASYDB','EASYDB','V1.7','2016-12-12 00:00:00','业界领先的数据库运维神器','imgs/easydb_logo.png','http://127.0.0.1:81/'),
  ('N',now(),now(),0,0,'RDOS','RD-OS','V1.7','2016-12-12 00:00:00','实时大数据智能操作系统','imgs/rdos_logo.png','http://127.0.0.1:81/'),
  ('N',now(),now(),0,0,'EASYV','EASY-V','V1.7','2016-12-12 00:00:00','Easy-V','imgs/easyv_logo.png','http://127.0.0.1:81/');

-- 初始化默认人员
INSERT INTO uic_user(id,is_deleted, gmt_create, gmt_modified, creator, modifier, username, `password`, is_active, full_name, phone, email, company, own_tenant_id, last_login_date, last_login_tenant_id, `source`) VALUES
  (1,'N',now(),now(),0,0,'admin@dtstack.com','PBKDF2WithHmacSHA256$24000$da90a472a9d8be52$SUtwqbeaEE2A2hExFMJx23IvirjX9n4nsb1tP06jnbE=','Y','超级管理员','15999999999','admin@dtstack.com','DTStack',1,null,null,0);

-- 初始化默认租户
INSERT INTO uic_tenant(id, is_deleted, gmt_create, gmt_modified, creator, modifier, tenant_name, tenant_desc, contact_name, contact_email, contact_phone, belong_user_id, agent_token) VALUES
  (1,'N',now(),now(),0,0,'DTStack租户', '默认创建租户','admin','admin@dtstack.com','15999999999',1,'kRhisbdoTQMCZU5KqQqGkQ7sDA7BM9kpldnQ5Nf2al8ER9yp');

-- 用户-租户关联
INSERT INTO uic_user_tenant_rel(id, is_deleted, gmt_create, gmt_modified, creator, modifier, user_id, tenant_id, is_admin) VALUES
  (1,'N',now(),now(),0,0,1,1,'Y');

INSERT INTO `uic_event`(event_code, support_method, event_describe) VALUES
  ('LOG_OUT', 'POST', '用户登出'),
  ('CHANGE_TENANT_OWNER', 'POST', '切换租户所有者');
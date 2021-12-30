alter table da_api add column `dtuic_tenant_id` int(11) NOT NULL COMMENT 'uic租户id';
alter table da_api_test add column `dtuic_tenant_id` int(11) NOT NULL COMMENT 'uic租户id';
alter table da_api add column `data_center_id` int(11) DEFAULT NULL COMMENT '数据源中心id';
alter table da_api_test add column `data_center_id` int(11) DEFAULT NULL COMMENT '数据源中心id';


-- 更新dtuicTenantId
UPDATE da_api t1
LEFT JOIN da_tenant t2 ON t1.tenant_id = t2.id
SET t1.dtuic_tenant_id = t2.dtuic_tenant_id;
UPDATE da_api_test t1
LEFT JOIN da_tenant t2 ON t1.tenant_id = t2.id
SET t1.dtuic_tenant_id = t2.dtuic_tenant_id;

-- 更新数据源中心id
UPDATE da_api t1
LEFT JOIN da_data_source_center t2 ON t1.data_src_id = t2.id
SET t1.data_center_id = t2.data_source_center_id
where t1.data_src_id is not null;
UPDATE da_api_test t1
LEFT JOIN da_data_source_center t2 ON t1.data_src_id = t2.id
SET t1.data_center_id = t2.data_source_center_id
where t1.data_src_id is not null;



-- 给da_secret_key_info表加上唯一索引
alter table da_secret_key_info add unique index idx_user_tenant(user_id, tenant_id);
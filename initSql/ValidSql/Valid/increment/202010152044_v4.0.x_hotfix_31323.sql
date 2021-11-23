# 将唯一索引改为普通索引
drop index idx_tenant_name on dq_tenant;
create index idx_tenant_name
	on dq_tenant (tenant_name);
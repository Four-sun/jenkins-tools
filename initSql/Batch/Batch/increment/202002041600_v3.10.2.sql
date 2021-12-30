DROP INDEX index_tenant_name ON rdos_tenant;
ALTER TABLE rdos_tenant ADD UNIQUE INDEX `index_tenant_id` ( `dtuic_tenant_id` );
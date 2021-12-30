ALTER TABLE rdos_batch_catalogue ADD COLUMN catalogue_type TINYINT(1) DEFAULT '0' COMMENT '目录类型 0任务目录 1 项目目录';


ALTER TABLE rdos_project ADD COLUMN `catalogue_id` int(11) NOT NULL DEFAULT '0' COMMENT '目录id';


insert into rdos_batch_catalogue(tenant_id,project_id,node_name,node_pid,catalogue_type,create_user_id,level) select id,0,'default',0,1,0,0 from rdos_tenant where is_deleted = 0;

update rdos_project rp left join rdos_batch_catalogue rbc on rp.tenant_id = rbc.tenant_id and rbc.catalogue_type =1 and LEVEL =0
set catalogue_id = rbc.id
where rp.is_deleted = 0;
alter table `rdos_batch_task_task` add column `parent_apptype` int(2) NOT NULL DEFAULT '1' COMMENT '对应任务父节点的产品类型' after tenant_id;

alter table `rdos_batch_task_task` drop index `index_batch_task_task`;
alter table `rdos_batch_task_task` add unique key `index_batch_task_task` (`project_id`,`parent_task_id`,`task_id`,`parent_apptype`);

INSERT INTO dagschedulex.schedule_engine_project
            (project_id,
             uic_tenant_id,
             app_type,
             project_name,
             project_alias,
             project_Identifier,
             project_desc,
             status,
             create_user_id,
             gmt_create,
             gmt_modified,
             is_deleted)
SELECT rp.id,
       rt.dtuic_tenant_id,
       1,
       rp.project_name,
       rp.project_alias,
       rp.project_Identifier,
       rp.project_desc,
       rp.status,
       ru.dtuic_user_id,
       rp.gmt_create,
       rp.gmt_modified,
       rp.is_deleted
FROM   rdos_project rp
       LEFT JOIN rdos_tenant rt
              ON rp.tenant_id = rt.id
       LEFT JOIN rdos_user ru
              ON rp.create_user_id = ru.id;
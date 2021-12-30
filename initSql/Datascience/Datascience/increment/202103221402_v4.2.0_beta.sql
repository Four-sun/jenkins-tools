
CREATE TABLE science_dependent_task_task (
  id int(11) NOT NULL AUTO_INCREMENT,
  task_id int(11) NOT NULL COMMENT '关联的任务id',
  dtuic_tenant_id int(11) NOT NULL COMMENT 'uic租户id',
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) COMMENT '项目id',
  app_type int(5) NOT NULL COMMENT 'app类型',
  parent_task_id int(11) COMMENT '依赖任务的id',
  parent_dtuic_tenant_id int(11) NOT NULL COMMENT '依赖任务的uic租户id',
  parent_task_name varchar(64) NOT NULL COMMENT '依赖任务的名称',
  parent_project_name varchar(64) NOT NULL COMMENT '依赖项目项目名称',
  parent_app_type int(5) NOT NULL COMMENT '依赖任务app类型',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) DEFAULT '0' COMMENT '创建人',
  modify_user_id int(11) DEFAULT '0' COMMENT '修改人',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY index_task_id_parent_task_id_project_id (task_id,parent_task_id,project_id),
  KEY index_task_id (task_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='外部任务依赖表,notebook、算法实验、其他子产品任务三者的依赖关系';


-- 同步项目信息到引擎sql,
insert into dagschedulex.schedule_engine_project(project_id,uic_tenant_id,app_type,project_name,project_alias,project_Identifier,project_desc,status,create_user_id,gmt_create,gmt_modified,is_deleted)
select sp.id,st.dtuic_tenant_id,8,sp.project_name,sp.project_alias,sp.project_Identifier,sp.project_desc,sp.status,sp.create_user_id,sp.gmt_create,sp.gmt_modified,sp.is_deleted
from science.science_project sp left join science.science_tenant st on sp.tenant_id = st.id
WHERE sp.id not in (select project_id FROM dagschedulex.schedule_engine_project WHERE app_type = 8) and sp.is_deleted = 0 and st.dtuic_tenant_id is not null
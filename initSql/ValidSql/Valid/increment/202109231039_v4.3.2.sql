-- 更新部分原有权限点描述，新增实时校验权限点
update dq_permission set `name` = '数据源管理',`display` = '数据源管理' where `code` = 'datasource';
update dq_permission set `name` = '多表校验',`display` = '多表校验' where `code` = 'verify';
update dq_permission set `name` = '多表校验_编辑' where `code` = 'verify_edit';
update dq_permission set `name` = '多表校验_查看' where `code` = 'verify_query';
update dq_permission set `name` = '系统管理',`display` = '系统管理' where `code` = 'system';

-- 角色表
INSERT INTO `dt_pub_service`.`auth_role` (
    `app_type`,
    `dtuic_tenant_id`,
    `project_id`,
    `role_name`,
    `role_type`,
    `role_value`,
    `role_desc`,
    `modify_user_id`,
    `create_user_id`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`,
    `old_role_id`)
select
    2,
    CASE
    WHEN dr.`tenant_id` = -1 THEN
      -1
    WHEN dt.`dtuic_tenant_id` IS NULL THEN
      0
    ELSE
      dt.`dtuic_tenant_id`
    END,
    if(dr.tenant_id = -1, -1, dr.project_id),
    dr.`role_name`,
    dr.`role_type`,
    dr.`role_value`,
    dr.`role_desc`,
    if(u.`id` is null, 0, u.`id`),
    if(u.`id` is null, 0, u.`id`),
    dr.`gmt_create`,
    dr.`gmt_modified`,
    0,
    dr.`id`
from valid.dq_role dr
left join valid.dq_tenant dt on dr.tenant_id = dt.id
left join valid.dq_user u on dr.modify_user_id = u.id
where dr.`is_deleted` = 0;


-- 权限表
INSERT INTO `dt_pub_service`.`auth_permission` (
    `old_permission_id`,
    `app_type`,
    `code`,
    `name`,
    `display`,
    `parent_id`,
    `type`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`)
SELECT
    `id`,
    2,
    `code`,
    `name`,
    `display`,
    `parent_id`,
    `type`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`
FROM valid.dq_permission;

UPDATE dt_pub_service.auth_permission AS ap1 INNER JOIN dt_pub_service.auth_permission AS ap2 ON ap1.parent_id = ap2.old_permission_id SET ap1.parent_id = ap2.id WHERE ap1.app_type = 2 AND ap2.app_type = 2;


-- 角色权限表
INSERT INTO `dt_pub_service`.`auth_role_permission` (
    `app_type`,
    `role_id`,
    `permission_id`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`)
SELECT
    2,
    ar.`id`,
    per.`id`,
    drp.`gmt_create`,
    drp.`gmt_modified`,
    drp.`is_deleted`
from valid.dq_role_permission drp
LEFT JOIN dt_pub_service.auth_role ar ON ar.old_role_id = drp.role_id
LEFT JOIN dt_pub_service.auth_permission per ON per.old_permission_id = drp.permission_id
where drp.role_id in (select old_role_id from dt_pub_service.auth_role  where app_type = 2)
and ar.app_type = 2 and per.app_type = 2
GROUP BY drp.role_id, drp.permission_id;



-- 角色用户表
INSERT INTO `dt_pub_service`.`auth_role_user` (
    `app_type`,
    `project_id`,
    `dtuic_tenant_id`,
    `role_id`,
    `dtuic_user_id`,
    `gmt_create`,
    `gmt_modified`,
    `is_deleted`,
    `modify_user_id`,
    `create_user_id`)
SELECT
    2,
    dru.`project_id`,
    dt.`dtuic_tenant_id`,
    ar.`id`,
    u.`dtuic_user_id`,
    dru.`gmt_create`,
    dru.`gmt_modified`,
    dru.`is_deleted`,
    u.`dtuic_user_id`,
    u.`dtuic_user_id`
FROM valid.dq_role_user dru
LEFT JOIN dt_pub_service.auth_role ar ON ar.old_role_id = dru.role_id
left join valid.dq_tenant dt on dru.tenant_id = dt.id
left join valid.dq_user u on dru.user_id = u.id
where dru.project_id <> -1 and u.dtuic_user_id is not null and dru.role_id in (select old_role_id from dt_pub_service.auth_role  where app_type = 2)
and ar.app_type = 2;


INSERT IGNORE INTO `dt_pub_service`.`ps_user` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_user_id`,
  `user_name`,
  `user_email`,
  `user_status`,
  `phone_number`)
SELECT
	`gmt_create`,
    `gmt_modified`,
	`dtuic_user_id`,
	`dtuic_user_id`,
	`is_deleted`,
	`dtuic_user_id`,
	`user_name`,
	`email`,
	`status`,
	`phone_number`
from valid.dq_user;

INSERT IGNORE INTO `dt_pub_service`.`ps_tenant` (
  `gmt_create`,
  `gmt_modified`,
  `create_user_id`,
  `modify_user_id`,
  `is_deleted`,
  `dtuic_tenant_id`,
  `tenant_name`,
  `tenant_desc`,
  `tenant_status`)
select
	dt.`gmt_create`,
    dt.`gmt_modified`,
	u.`dtuic_user_id`,
	u.`dtuic_user_id`,
	dt.`is_deleted`,
	dt.`dtuic_tenant_id`,
	dt.`tenant_name`,
	dt.`tenant_desc`,
	dt.`status`
from valid.dq_tenant dt
left join valid.dq_user u on dt.create_user_id = u.id
where dt.create_user_id is not null;

INSERT INTO dt_pub_service.auth_project(
    project_id,
    dtuic_tenant_id,
    app_type,
    project_name,
    project_alias,
    project_Identifier,
    project_desc,
    `status`,
    create_user_id,
    gmt_create,
    gmt_modified,
    is_deleted)
SELECT
    dp.id,
    dt.dtuic_tenant_id,
    2,
    dp.project_name,
    dp.project_alias,
    dp.project_Identifier,
    dp.project_desc,
    dp.`status`,
    u.dtuic_user_id,
    dp.gmt_create,
    dp.gmt_modified,
    0
FROM valid.dq_project dp
         left join valid.dq_tenant dt on dp.tenant_id = dt.id
         left join valid.dq_user u on dp.create_user_id = u.id
WHERE dp.is_deleted = 0;

-- 新增hive3数据源支持
insert into dq_dict values (0, 1, 'Hive3.x', 50, 'Hive3.x', 'Hive3.x', 12, now(), now(), 0);
-- 新增hive3函数模版
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (1, 50, 'select count(1)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (2, 50, '', '');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (3, 50, 'select count(1) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (4, 50, 'select sum(case when ${col} is null then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (5, 50, 'select sum(case when length(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (6, 50, 'select sum(case when length(${col})=0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})=0 ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (7, 50, 'select count(1) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col} having count > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (8, 50, 'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (9, 50, 'select count(1) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col} having count = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (10, 50, 'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (11, 50, 'select count(1) as val from  ${table} where ${col} ${enum} ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (12, 50, 'select count(1) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (13, 50, 'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (14, 50, 'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (15, 50, 'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (16, 50, 'SELECT max(length(${col})) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})> ${expectation} ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (17, 50, 'SELECT min(length(${col})) as val from ${table} where 1=1 ${filter}', '${table} where length(${col})< ${expectation} ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (18, 50, 'select max(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (19, 50, 'select min(${col}) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (20, 50, 'select avg(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (21, 50, 'select sum(${col}) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (22, 50, 'SELECT count(1) AS val FROM ${table} WHERE ${col}  REGEXP \'(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)\' ${filter}', '${table} where ${col} NOT RLIKE \'(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)\' ${filter} ');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (23, 50, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike \"^[1]([3-9])[0-9]{9}$\" ${filter}', '${table} WHERE ${col}  NOT RLIKE \"^[1][35678][0-9]{9}$\" ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (24, 50, 'SELECT count(1) AS val FROM ${table} WHERE ${col} rlike \"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$\" ${filter}', '${table} WHERE ${col}  NOT RLIKE \"^[-[:alnum:]_]+@[-[:alnum:]_]+\\.[-[:alnum:]_]+$\" ${filter}');
INSERT INTO `dq_function_template`(function_id, data_source_type, template, template_query) VALUES (25, 50, 'SELECT count(1) AS val FROM ${table} WHERE ${range}  ${filter}', '${table} where ${reverse_range} ${filter}');

-- 更新对应的历史错误的工作流节点信息
update dq_monitor_record set flow_job_id = 0 where remote_id != 0 and flow_job_id is not null;






--  http://zenpms.dtstack.cn/zentao/bug-view-41331.html
-- 每个项目只保留一个租户所有者
delete
from da_role_user where id in (
    -- 需要用临时表包一层
    select id from (
        select id from da_role_user where
        -- 每个项目保留一个租户所有者
        id not in(
            select max(id) from da_role_user where role_id in (select id from da_role where role_value = 1) and is_deleted = 0 group by project_id
        )
        and role_id in (select id from da_role where role_value = 1) and is_deleted = 0
    ) a
);


-- 每个项目只保留一个租户管理员
delete
from da_role_user where id in (
    -- 需要用临时表包一层
    select id from (
        select id from da_role_user where
        -- 每个项目只保留一个租户管理员
        id not in(
            select max(id) from da_role_user where role_id in (select id from da_role where role_value = 8) and is_deleted = 0 group by project_id
        )
        and role_id in (select id from da_role where role_value = 8) and is_deleted = 0
    ) a
);

-- 修改role_user表索引 为唯一索引
drop index  idx_project_user_role on da_role_user;
alter table da_role_user add unique idx_project_user_role(user_id,role_id,tenant_id,project_id);

-- 清除初始化的项目
update
    rdos_project
set project_name  = concat(project_name, '_', 'del'),
    project_alias = concat(project_alias, '_', 'del'),
    is_deleted    = 1
where is_deleted = 0
  and status = 0;
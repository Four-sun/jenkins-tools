-- 清除所有伪删除数据
delete from rdos_role_user where is_deleted = 1;
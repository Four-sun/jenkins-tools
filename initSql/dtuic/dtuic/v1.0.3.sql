-- 用户产品权限去掉查看和管理员
ALTER TABLE uic_user_product_rel
DROP is_admin,
DROP is_viewer;
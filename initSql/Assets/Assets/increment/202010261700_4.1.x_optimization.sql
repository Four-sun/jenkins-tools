ALTER TABLE `assets_data_table_column`
    ADD COLUMN `column_order` SMALLINT(4) NOT NULL DEFAULT '0'  COMMENT '字段顺序标识' AFTER `column_type`;

-- 血缘编辑
insert into assets_permission(id, create_at, update_at, create_by, update_by, is_deleted, permission_code,
                              permission_name, permission_display, parent_id, permission_type)
values (26,now(),now(),0,0,0,'dmap_center_dataLineage_edit','数据地图_元数据中心_血缘_编辑','血缘编辑',21,1);
-- 已有数据添加血缘编辑权限
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 26
from assets_role r
where role_value in (1, 2, 3);


ALTER TABLE `assets_resource`
    ADD COLUMN `data_source_type` TINYINT(1) NOT NULL COMMENT '数据源类型' AFTER `data_id`;
ALTER TABLE `assets_resource`
    ADD COLUMN `data_source_id` BIGINT(20) NOT NULL COMMENT '数据源ID' AFTER `data_source_type`;
delimiter $$
DROP PROCEDURE
    IF
        EXISTS add_ds_and_db_to_resource;
CREATE PROCEDURE add_ds_and_db_to_resource()
BEGIN
    DECLARE
        done INT DEFAULT 0;
    DECLARE
        table_id_ BIGINT(20) DEFAULT NULL;
    DECLARE
        data_source_type_ TINYINT(1) DEFAULT NULL;
    DECLARE
        data_source_id_ BIGINT(20) DEFAULT NULL;
    DECLARE
        db_id_ BIGINT(20) DEFAULT NULL;
    DECLARE
        cur CURSOR FOR SELECT id,
                              data_source_type,
                              data_source_id,
                              db_id
                       FROM assets_data_table
                       WHERE id IN (SELECT DISTINCT table_id FROM assets_resource);
    -- 需要读取的数据列表
--  游标中的内容执行完后将done设置为1
    DECLARE
        CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;-- 打开游标
    OPEN cur;--  执行循环
    read_loop :
    LOOP
        -- 提取游标里的数据
        FETCH cur INTO table_id_,
            data_source_type_,
            data_source_id_,
            db_id_;-- 判断是否结束循环
        IF
            done = 1 THEN
            LEAVE read_loop;

        END IF;
        UPDATE assets_resource
        SET data_source_type = data_source_type_,
            data_source_id   = data_source_id_,
            db_id            = db_id_
        WHERE table_id = table_id_;

    END LOOP;-- 关闭游标
    CLOSE cur;

END;
$$
CALL add_ds_and_db_to_resource();

-- 用户管理和角色管理
delete from assets_permission where id = 81;
insert into assets_permission(id, create_at, update_at, create_by, update_by, is_deleted, permission_code,
                              permission_name, permission_display, parent_id, permission_type)
values (81,now(),now(),0,0,0,'securityMgr_userMgr','安全管理_用户管理','用户管理',80,1),
(82,now(),now(),0,0,0,'securityMgr_roleMgr','安全管理_角色管理','角色管理',80,1);

insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 82
from assets_role r
where role_value in (1, 2);

-- 访客新增资产盘点INVENTORY权限
insert into assets_role_permission(create_at, update_at, create_by, update_by, is_deleted, role_id, permission_id)
select now(), now(), 0, 0, 0, r.id, 100
from assets_role r
where role_value in (4);

ALTER TABLE `assets_resource`
	CHANGE COLUMN `resource_name` `resource_name` VARCHAR(100) NOT NULL COMMENT '资源名称' COLLATE 'utf8_general_ci';
ALTER TABLE `assets_resource`
	CHANGE COLUMN `resource_name_cn` `resource_name_cn` VARCHAR(100) NULL DEFAULT NULL COMMENT '资源中文名' COLLATE 'utf8_general_ci';

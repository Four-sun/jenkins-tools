BEGIN;
-- 资源表新增一个字段
ALTER TABLE `rdos_stream_resource`
	ADD COLUMN `modify_user_id` int(11) NOT NULL COMMENT '修改资源的用户';

-- 插入修改资源用户列数据
DROP PROCEDURE IF EXISTS pr_auth_insert_modify_user_id;
DELIMITER //
create procedure pr_auth_insert_modify_user_id()
BEGIN
    DECLARE resourceId INT;
    DECLARE userId INT;
    DECLARE stop INT DEFAULT 0;
    DECLARE cur CURSOR FOR (select id,create_user_id from rdos_stream_resource where is_deleted = 0);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

    OPEN cur;
    FETCH cur INTO resourceId,userId;
    WHILE ( stop is not null) DO
            UPDATE  rdos_stream_resource SET modify_user_id = userId WHERE id = resourceId;
            FETCH cur INTO resourceId,userId;
        END WHILE;
    CLOSE cur;
END; //
DELIMITER ;

CALL pr_auth_insert_modify_user_id();

-- 新增资源历史表
DROP TABLE IF EXISTS `rdos_stream_resource_history`;
CREATE TABLE `rdos_stream_resource_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL COMMENT '资源id',
  `version` varchar(256) NOT NULL COMMENT '版本',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `url` varchar(1028) NOT NULL COMMENT '资源路径',
  `resource_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 1,jar 2 file',
  `resource_name` varchar(256) NOT NULL COMMENT '资源名称',
  `origin_file_name` varchar(256) NOT NULL COMMENT '源文件名',
  `resource_desc` varchar(256) NOT NULL COMMENT '源文描述',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '新建资源的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改资源的用户',
  `is_current_version` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0不是当前版本 1当前版本',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 把资源表的数据复制一份到历史资源表
insert into `rdos_stream_resource_history`(`version`,`is_current_version`,`resource_id`,`tenant_id`,`project_id`,`url`,`resource_type`,`resource_name`,`origin_file_name`,`resource_desc`,`gmt_create`,`gmt_modified`,`create_user_id`,`modify_user_id`,`is_deleted`)
select "1",1, `id`,`tenant_id`,`project_id`,`url`,`resource_type`,`resource_name`,`origin_file_name`,`resource_desc`,`gmt_create`,`gmt_modified`,`create_user_id`,`modify_user_id`,`is_deleted` from `rdos_stream_resource`;


COMMIT;
ALTER TABLE `rdos_project`
DROP INDEX `index_project_name`;



CREATE TABLE `rdos_batch_fill_data_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fill_id` int(11) NOT NULL COMMENT '补数据id',
  `job_id` int(11) NOT NULL COMMENT '实例id',
  `status` tinyint(2) COMMENT '状态值',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




DROP PROCEDURE IF EXISTS rdos_fill_data_relation;

DELIMITER //

create procedure rdos_fill_data_relation()
BEGIN
DECLARE sql_1 VARCHAR(500);
DECLARE fillId INT;
DECLARE fillName VARCHAR(64);
DECLARE stop INT DEFAULT 0;
DECLARE cur CURSOR FOR (select id, job_name from rdos_batch_fill_data_job where is_deleted=0);
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

OPEN cur;

    FETCH cur INTO fillId,fillName;
    WHILE ( stop is not null) DO
		 	SET sql_1 = CONCAT("insert into rdos_batch_fill_data_relation (fill_id,job_id,project_id,tenant_id,gmt_create,gmt_modified) select  ", fillId, ",id,project_id,tenant_id,gmt_create,gmt_modified from rdos_batch_job where type =1 and job_name like '", fillName, "%'");
			SET @sql_1 = sql_1;
			PREPARE stmt1 FROM @sql_1;
			EXECUTE stmt1;
			DEALLOCATE PREPARE stmt1;
    FETCH cur INTO fillId,fillName;
    END WHILE;

CLOSE cur;
END; //

DELIMITER ;

CALL rdos_fill_data_relation();



-- 更新系统函数中的类名
update rdos_batch_function set class_name = '' where type = 1;
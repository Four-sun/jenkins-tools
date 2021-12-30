-- 删除索引
DROP PROCEDURE IF EXISTS sp_dropindex;
DELIMITER //
CREATE PROCEDURE sp_dropindex
(
    IN    databasename             VARCHAR(50)   ,
    IN    tablename                VARCHAR(50)   ,
    IN    indexname                VARCHAR(50)
)
    proc:BEGIN
    DECLARE   str       VARCHAR(512)  DEFAULT NULL;
    DECLARE   cnt       INT           DEFAULT 0;
    SET @str = CONCAT(' drop index ',indexname,' on ',databasename,'.',tablename);

SELECT COUNT(*) INTO cnt FROM information_schema.statistics
WHERE TABLE_SCHEMA=databasename AND TABLE_NAME=tablename
  AND INDEX_NAME=indexname;

IF cnt > 0 THEN
    PREPARE stmt FROM @str;
EXECUTE stmt;
END IF;
    LEAVE proc;
END
//
DELIMITER ;

CALL sp_dropindex('science','science_tenant','index_tenant_name');
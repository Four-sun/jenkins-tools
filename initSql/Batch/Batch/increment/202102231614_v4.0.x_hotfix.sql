-- 处理因项目删除导致误删除的项目目录
DROP PROCEDURE IF EXISTS pr_batch_catalogue_deal_history;
DELIMITER //
create procedure pr_batch_catalogue_deal_history()
BEGIN
		DECLARE catalogueId INT;
        DECLARE catalogueProjectId INT;
		DECLARE stop INT DEFAULT 0;
        -- 查找出当前 rdos_batch_catalogue 中所有的被删除目录树
		DECLARE cur CURSOR FOR (select id, project_id from rdos_batch_catalogue where is_deleted = 1 order by level desc);
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stop = null;

		OPEN cur;
		FETCH cur INTO catalogueId, catalogueProjectId;
		WHILE ( stop is not null) DO
		                -- 处理项目未被删除的
						SET @p_count = (select count(1) p_count from rdos_project where is_deleted=0 and catalogue_id = catalogueId);
						IF @p_count>0 THEN
							update rdos_batch_catalogue
                            set is_deleted = 0, gmt_modified = NOW()
                            where id = catalogueId;
						END IF;
						-- 处理子目录还存在的
						SET @p_count = (select count(1) p_count from rdos_batch_catalogue where is_deleted=0 and node_pid = catalogueId);
						IF @p_count>0 THEN
                            update rdos_batch_catalogue
                            set is_deleted = 0, gmt_modified = NOW()
                            where id = catalogueId;
                        END IF;
						FETCH cur INTO catalogueId, catalogueProjectId;
				END WHILE;
		CLOSE cur;
END; //
DELIMITER ;

CALL pr_batch_catalogue_deal_history();
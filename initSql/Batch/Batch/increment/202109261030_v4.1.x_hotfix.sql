DROP PROCEDURE IF EXISTS task_index_change;
DELIMITER //
CREATE PROCEDURE task_index_change() BEGIN
	IF NOT EXISTS (SELECT * FROM information_schema.statistics WHERE table_schema='ide' AND table_name = 'rdos_batch_task' AND index_name = 'flow_id_index') THEN
ALTER TABLE `rdos_batch_task` ADD INDEX `flow_id_index`(`flow_id`);
END IF;
END//
DELIMITER ;
CALL task_index_change();
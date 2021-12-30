ALTER TABLE rdos_batch_task ADD COLUMN component_version varchar(25) DEFAULT NULL COMMENT '组件版本';

-- 同步console的组件版本
DROP PROCEDURE IF EXISTS update_rdos_batch_task_component_version;

delimiter //
create procedure update_rdos_batch_task_component_version()
 begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE dtUicTenantId int;
    DECLARE id_cur CURSOR FOR SELECT dt_uic_tenant_id FROM dagschedulex.console_dtuic_tenant where is_deleted = 0;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;
    open id_cur;

    FETCH id_cur INTO dtUicTenantId;
    WHILE (stopFlag <> 1)
    	DO
    	SET @tenantId = (select id from rdos_tenant where dtuic_tenant_id = dtUicTenantId);
    	set @flink_componentversion = (SELECT sd.dict_name
FROM   dagschedulex.console_component cc
       INNER JOIN dagschedulex.console_engine_tenant cet
               ON cc.engine_id = cet.engine_id
       INNER JOIN dagschedulex.console_dtuic_tenant cdt
               ON cdt.id = cet.tenant_id
       INNER JOIN dagschedulex.schedule_dict sd
               ON sd.dict_value = cc.hadoop_version
WHERE  cc.component_type_code = 0
       AND cc.is_default = 1
       AND cc.is_deleted = 0
       AND cdt.dt_uic_tenant_id = dtUicTenantId);

       IF @flink_componentversion is not null THEN
                update rdos_batch_task set component_version = @flink_componentversion where task_type in (0, 1, 3) and tenant_id = @tenantId;
            end if;

       set @spark_componentversion = (SELECT sd.dict_name
FROM   dagschedulex.console_component cc
       INNER JOIN dagschedulex.console_engine_tenant cet
               ON cc.engine_id = cet.engine_id
       INNER JOIN dagschedulex.console_dtuic_tenant cdt
               ON cdt.id = cet.tenant_id
       INNER JOIN dagschedulex.schedule_dict sd
               ON sd.dict_value = cc.hadoop_version
WHERE  cc.component_type_code = 1
       AND cc.is_default = 1
       AND cc.is_deleted = 0
       AND cdt.dt_uic_tenant_id = dtUicTenantId);

       IF @spark_componentversion is not null THEN
                update rdos_batch_task set component_version = @spark_componentversion where task_type = 2 and tenant_id = @tenantId;
            end if;
   FETCH id_cur INTO dtUicTenantId;
END WHILE;
   CLOSE id_cur;
end //
delimiter ;

CALL update_rdos_batch_task_component_version();
drop procedure update_rdos_batch_task_component_version;

-- hive表生命周期迁移
drop procedure if exists schedule_job_user_id;

DELIMITER //

-- 更新schedule_job的create_user_id为uic用户id
create procedure schedule_job_user_id()
begin
	  declare user_id int(11);
	  declare flag int default 0;
	  declare cur cursor for (select distinct(create_user_id) from dagschedulex.schedule_job where app_type = 1);
	  declare continue handler for sqlstate '02000' set flag = null;

    open cur;
        fetch cur into user_id;
        while (flag is not null) do

           	set @dtuic_user_id = (select dtuic_user_id from rdos_user where id = user_id);
           	if @dtuic_user_id is not null then
            	update dagschedulex.schedule_job set create_user_id = @dtuic_user_id where create_user_id = user_id and app_type = 1;
            end if;

        fetch cur into user_id;
            end while;
    close cur;

end; //

DELIMITER ;

call schedule_job_user_id();
drop procedure schedule_job_user_id;

-- 更新schedule_task_shade的user_id为uic用户id
drop procedure if exists schedule_task_shade_user_id;

DELIMITER //
create procedure schedule_task_shade_user_id()
begin
	  declare task_id int(11);
	  declare flag int default 0;
	  declare cur cursor for (select id from dagschedulex.schedule_task_shade where app_type = 1);
	  declare continue handler for sqlstate '02000' set flag = null;

    open cur;
        fetch cur into task_id;
        while (flag is not null) do
			set @modify_user_id = (select modify_user_id from dagschedulex.schedule_task_shade where id = task_id);
			set @create_user_id = (select create_user_id from dagschedulex.schedule_task_shade where id = task_id);
			set @owner_user_id = (select owner_user_id from dagschedulex.schedule_task_shade where id = task_id);
			set @new_modify_user_id = (select dtuic_user_id from rdos_user where id = @modify_user_id);
			set @new_create_user_id = (select dtuic_user_id from rdos_user where id = @create_user_id);
			set @new_owner_user_id = (select dtuic_user_id from rdos_user where id = @owner_user_id);

		    if @new_modify_user_id is not null then
            	update dagschedulex.schedule_task_shade set modify_user_id = @new_modify_user_id where id = task_id;
            end if;
            if @new_create_user_id is not null then
            	update dagschedulex.schedule_task_shade set create_user_id = @new_create_user_id where id = task_id;
            end if;
            if @new_owner_user_id is not null then
            	update dagschedulex.schedule_task_shade set owner_user_id = @new_owner_user_id where id = task_id;
            end if;

        fetch cur into task_id;
            end while;
    close cur;

end; //

DELIMITER ;

call schedule_task_shade_user_id();
drop procedure schedule_task_shade_user_id;

-- 迁移血缘信息
DROP PROCEDURE IF EXISTS public_service_lc_table_life;

delimiter //
create procedure public_service_lc_table_life()
begin
    DECLARE stopFlag INT DEFAULT 0;
    DECLARE table_id int;
    DECLARE data_source_id int;
    DECLARE id_cur CURSOR FOR SELECT a.id FROM rdos_hive_table_info a inner join rdos_project b on b.id=a.project_id and b.is_deleted=0 where a.is_deleted = 0;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET stopFlag = 1;
    open id_cur;

    FETCH id_cur INTO table_id;
    WHILE (stopFlag <> 1)
    	DO
    	select project_id, tenant_id, table_name, table_desc, life_day, life_status, charge_user_id, user_id, modify_user_id, gmt_create, gmt_modified
			from rdos_hive_table_info where id = table_id
		into @project_id, @tenant_id, @table_name, @table_desc, @life_day, @life_status, @charge_user_id, @create_user_id, @modify_user_id, @gmt_create, @gmt_modified ;
		IF @table_desc is null THEN
			set @table_desc = '';
		end if;

    	set @engine_type = (SELECT CASE table_type
				WHEN 1 THEN 1
				WHEN 6 THEN 1
				WHEN 2 THEN 2
				WHEN 3 THEN 4
				WHEN 4 THEN 5
				WHEN 5 THEN 6
				WHEN 7 THEN 9
				WHEN 8 THEN 10
				WHEN 9 THEN 11
			END AS engine_type
		FROM rdos_hive_table_info
		WHERE id = table_id);

		set @data_source_type = (SELECT CASE table_type
				WHEN 1 THEN 7
				WHEN 2 THEN 21
				WHEN 3 THEN 31
				WHEN 4 THEN 2
				WHEN 5 THEN 36
				WHEN 6 THEN 29
				WHEN 7 THEN 54
				WHEN 8 THEN 1
				WHEN 9 THEN 3
			END AS data_source_type
		FROM rdos_hive_table_info
		WHERE id = table_id and is_deleted = 0);


	IF @data_source_type = 7 THEN
	 set data_source_id = (SELECT a.id
		FROM dt_pub_service.dsc_info a
			LEFT JOIN dt_pub_service.dsc_import_ref b ON a.id = b.data_info_id
		WHERE a.data_type_code IN (27, 7, 50, 29, 45)
			AND a.is_meta = 1
			AND b.project_id = @project_id
			AND a.is_deleted = 0
			AND b.is_deleted = 0
			AND b.app_type = 1
		ORDER BY b.gmt_create ASC
		LIMIT 1);
	ELSE
	 set data_source_id = (SELECT a.id
		FROM dt_pub_service.dsc_info a
			LEFT JOIN dt_pub_service.dsc_import_ref b ON a.id = b.data_info_id
		WHERE a.data_type_code = @data_source_type
			AND a.is_meta = 1
			AND b.project_id = @project_id
			AND a.is_deleted = 0
			AND b.is_deleted = 0
			AND b.app_type = 1
		ORDER BY b.gmt_create ASC
		LIMIT 1);
	end if;

	set @db_schema = (SELECT engine_identity FROM rdos_project_engine where project_id = @project_id and engine_type = @engine_type and is_deleted = 0);

	if data_source_id is not null then
		INSERT INTO dt_pub_service.lc_table_life (old_table_id, project_id, uic_tenant_id, app_type, table_name,
			table_desc, life_day, life_status, charge_user_id, create_user_id,
			modify_user_id, db_schema, gmt_create, gmt_modified, data_source_id)
		VALUES (table_id, @project_id, @tenant_id, 1, @table_name,
			@table_desc, @life_day, @life_status, @charge_user_id, @create_user_id,
			@modify_user_id, @db_schema, @gmt_create, @gmt_modified, data_source_id);
	end if;
   FETCH id_cur INTO table_id;
END WHILE;
   CLOSE id_cur;
end //
delimiter ;

CALL public_service_lc_table_life();
drop procedure public_service_lc_table_life;
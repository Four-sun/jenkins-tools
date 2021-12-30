alter table science_hive_table_info add column data_tag tinyint(4) not null default 0;
alter table science_hive_table_info add column data_source_id int(11) unsigned not null default 0;

delimiter //
CREATE PROCEDURE insert_data_source_id()
BEGIN
    DECLARE pid, dataSourceId int;
    DECLARE done int DEFAULT 0;
    DECLARE cur CURSOR FOR select p.id as pId from science_project p;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    start transaction;
    open cur;
    set dataSourceId = 0;
    model_loop:loop
        fetch cur into pid;
        if done = 1 then
            leave model_loop;
        end if;
        select id into dataSourceId from science_data_source_aiworks where project_id = pid and is_deleted = 0;
        update science_hive_table_info set data_source_id = dataSourceId where project_id = pid;
    end loop;
    close cur;
    commit;
END ;
//
delimiter ;
CALL insert_data_source_id();
DROP PROCEDURE insert_data_source_id;

update science_hive_table_info set data_tag = 2 where table_name in ('science_emotion_analysis', 'shop_location', 'shop_info', 'science_preset_dataset1');
update science_hive_table_info set data_tag = 3 where table_name like '%tmp%';
update science_hive_table_info set data_tag = 1 where table_name like '%normal%';
update science_hive_table_info set data_tag = 1 where data_tag not in (1,2,3);
update dt_center_cron_schedule set is_deleted = 1 where job_detail_name = 'syncHiveMetaDataJob';
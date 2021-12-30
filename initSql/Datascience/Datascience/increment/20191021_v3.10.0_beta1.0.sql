INSERT INTO `science_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`,
                           `gmt_modified`, `is_deleted`)
VALUES ('13', 'Component', '3', '特征工程', 'component', '8', now(), now(), '0');

    DROP PROCEDURE IF EXISTS insert_catalogue;
DELIMITER $
CREATE PROCEDURE insert_catalogue()
BEGIN
    DECLARE auto_id, pj_id, tt_id int;
    DECLARE done boolean DEFAULT true;
    DECLARE catalogue CURSOR FOR select id, project_id, tenant_id
                                 from science_catalogue
                                 where level = 12 and node_name = '组件'
                                 group by project_id, tenant_id;
    open catalogue;
    while done
        do
            fetch catalogue into auto_id, pj_id, tt_id;
            if done = true then
                insert into science_catalogue
                values (default, tt_id, pj_id, '特征工程', auto_id, 8, 13, now(), now(), 29, 0);
            end if;
        end while;
    close catalogue;
END $
CALL insert_catalogue();
DROP PROCEDURE insert_catalogue;
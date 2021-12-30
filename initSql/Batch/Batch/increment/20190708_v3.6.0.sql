INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
 ('1', 'Kylin', '23', 'Kylin', 'Kylin', '23', now(), now(), '0'),
 ('10', 'KYLIN_CUBE', '16', 'Cube(Kylin)', 'Cube(Kylin)', '16', now(), now(), '0')
on duplicate key update gmt_create=values(gmt_create);
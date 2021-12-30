INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUE ('10','HIVE_SQL','17','HiveSQL','HiveSQL','17', now(), now(), '0')
 on duplicate key update gmt_create=values(gmt_create);
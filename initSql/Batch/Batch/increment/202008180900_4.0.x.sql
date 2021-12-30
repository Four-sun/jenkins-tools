ALTER TABLE `rdos_batch_function` MODIFY class_name VARCHAR(512) DEFAULT NULL COMMENT 'main函数类名';
ALTER TABLE `rdos_batch_function` ADD COLUMN `sql_text` text DEFAULT NULL COMMENT 'sql文本' ;


INSERT INTO `ide`.`rdos_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`, `gmt_modified`, `is_deleted`)
  VALUES ('13', 'ProcedureFunction', '6', '存储过程', 'ProcedureFunction', '6', now(), now(), '0');
INSERT INTO `ide`.`rdos_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`, `gmt_modified`, `is_deleted`)
  VALUES ('13', 'GreenPlumCustomFunction', '6', '自定义函数', 'GreenPlumCustomFunction', '8', now(), now(), '0');
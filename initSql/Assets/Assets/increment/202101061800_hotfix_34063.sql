-- TiDB表元模型技术属性-存储大小-field_type
update assets_model_attribute set field_type = 7 where data_source_type = 31 and field_type = 6 and attribute_type = 0 and attribute_name = 'total_size';

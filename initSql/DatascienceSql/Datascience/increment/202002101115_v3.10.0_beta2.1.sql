alter table science_model add model_type int(2) NOT NULL COMMENT '模型类型，0为sklearn,1为spark,2为python';
update science_model set model_type = 0;
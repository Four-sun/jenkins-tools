ALTER TABLE science_project ADD COLUMN  temp_table_life INT(11)  DEFAULT 30 COMMENT '临时表生命周期，默认为30天';

UPDATE science_project SET temp_table_life = 30 WHERE is_deleted = 0




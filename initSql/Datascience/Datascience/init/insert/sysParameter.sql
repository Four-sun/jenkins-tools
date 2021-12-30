INSERT INTO `science_sys_parameter`
VALUES ('1', 'bdp.system.bizdate', 'yyyyMMdd-1', '0');
INSERT INTO `science_sys_parameter`
VALUES ('2', 'bdp.system.cyctime', 'yyyyMMddHHmmss', '0');
INSERT INTO `science_sys_parameter`
VALUES ('3', 'bdp.system.currmonth', 'yyyyMM-0', '0');
INSERT INTO `science_sys_parameter`
VALUES ('4', 'bdp.system.premonth', 'yyyyMM-1', '0');
INSERT INTO science_sys_parameter VALUES(DEFAULT(id), 'bdp.system.runtime', 'yyyyMMddHHmmss', 0);
INSERT INTO science_sys_parameter VALUES(DEFAULT(id), 'bdp.system.bizdate2', 'yyyy-MM-dd,-1', 0);

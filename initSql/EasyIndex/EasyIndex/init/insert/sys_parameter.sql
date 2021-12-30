INSERT INTO `rdos_batch_sys_parameter` VALUES (1, 'bdp.system.bizdate', 'yyyyMMdd-1', now(),  now(), 0);
INSERT INTO `rdos_batch_sys_parameter` VALUES (2, 'bdp.system.cyctime', 'yyyyMMddHHmmss',  now(),  now(), 0);
INSERT INTO `rdos_batch_sys_parameter` VALUES (3, 'bdp.system.currmonth', 'yyyyMM-0',  now(),  now(), 0);
INSERT INTO `rdos_batch_sys_parameter` VALUES (4, 'bdp.system.premonth', 'yyyyMM-1',  now(),  now(), 0);
INSERT INTO `rdos_batch_sys_parameter` VALUES (5, 'bdp.system.runtime', '${bdp.system.currenttime}',  now(), now(), 0);
INSERT INTO `rdos_batch_sys_parameter` VALUES (6, 'bdp.system.bizdate2', 'yyyy-MM-dd,-1',  now(), now(), 0);
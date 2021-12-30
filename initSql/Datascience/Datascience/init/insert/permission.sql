INSERT INTO `science_permission`
VALUES ('1', 'root', 'root', 'root', '0', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('2', 'project', '项目管理', '项目管理', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('3', 'project_query', '查看权限', '查看权限', '2', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('4', 'project_edit', '编辑权限', '编辑权限', '2', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('5', 'notebook', 'Notebook', 'Notebook', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('6', 'notebook_query', '查看权限', '查看权限', '5', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('7', 'notebook_schedule', '提交/发布', '提交/发布', '5', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30',
        '0');
INSERT INTO `science_permission`
VALUES ('8', 'notebook_deploy', '模型在线部署', '模型在线部署', '5', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30',
        '0');
INSERT INTO `science_permission`
VALUES ('9', 'lab', '实验', '实验', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('10', 'lab_query', '查看权限', '查看权限', '9', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('11', 'lab_schedule', '提交/发布', '提交/发布', '9', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('12', 'lab_deploy', '模型在线部署', '模型在线部署', '9', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('13', 'component', '组件', '组件', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('14', 'model', '模型', '模型', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('15', 'model_query', '模型_查看', '查看', '14', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('16', 'model_edit', '模型_编辑', '编辑', '14', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('17', 'maintain', '运维中心', '运维中心', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('18', 'maintain_overview', '运维概览', '运维概览', '17', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('19', 'maintain_task_manager', '任务管理', '任务管理', '17', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30',
        '0');
INSERT INTO `science_permission`
VALUES ('20', 'data_manager', '数据管理', '数据管理', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '1');
INSERT INTO `science_permission`
VALUES ('21', 'member_manager', '用户管理', '用户管理', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('22', 'member_manager_query', '用户管理_查看', '查看', '21', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('23', 'member_manager_edit', '用户管理_编辑', '编辑', '21', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('24', 'role_manager', '角色管理', '角色管理', '1', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('25', 'role_manager_query', '角色管理_查看', '查看', '24', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');
INSERT INTO `science_permission`
VALUES ('26', 'role_manager_edit', '角色管理_编辑', '编辑', '24', '1', '2019-04-02 18:59:30', '2019-04-02 18:59:30', '0');

insert into science_permission values(27,'project_create','创建权限','创建权限',2,1,now(),now(),0);
insert into science_permission values(28,'data','数据管理','数据管理',1,1,now(),now(),0);
insert into science_permission values(29,'data_query','查看权限','查看权限',28,1,now(),now(),0);
insert into science_permission values(30,'data_edit','编辑权限','编辑权限',28,1,now(),now(),0);
insert into science_permission values(31,'maintain_task_manager_query','查看权限','查看权限',19,1,now(),now(),0);
insert into science_permission values(32,'maintain_task_manager_control','任务控制','任务控制',19,1,now(),now(),0);
insert into science_permission values(33,'maintain_task_history','运行历史','运行历史',17,1,now(),now(),0);
insert into science_permission values(34,'maintain_task_history_query','查看权限','查看权限',33,1,now(),now(),0);
insert into science_permission values(35,'maintain_task_history_control','任务控制','任务控制',33,1,now(),now(),0);
insert into science_permission values(36,'maintain_task_alarm_record','告警记录','告警记录',42,1,now(),now(),0);
insert into science_permission values(37,'maintain_task_alarm_rule','告警规则','告警规则',42,1,now(),now(),0);
insert into science_permission values(38,'maintain_task_alarm_rule_query','查看权限','查看权限',37,1,now(),now(),0);
insert into science_permission values(39,'maintain_task_alarm_rule_edit','编辑权限','编辑权限',37,1,now(),now(),0);
insert into science_permission values(40,'notebook_edit','编辑权限','编辑权限',5,1,now(),now(),0);
insert into science_permission values(41,'lab_edit','编辑权限','编辑权限',9,1,now(),now(),0);
insert into science_permission values(42,'monitoring_alarm','监控告警','监控告警',17,1,now(),now(),0);
CREATE TABLE science_distribute_lock (
  id int(11) NOT NULL AUTO_INCREMENT,
  lock_name varchar(128) NOT NULL COMMENT '锁名称',
  instance varchar(128) NOT NULL COMMENT '节点hostname',
  thread_id int(11) NOT NULL COMMENT '线程id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  lockName varchar(255) DEFAULT NULL,
  threadId bigint(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY index_distribute_lock (lock_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE science_project (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_name varchar(256) NOT NULL COMMENT '项目名称',
  project_alias varchar(256) NOT NULL COMMENT '项目别名',
  project_Identifier varchar(256) NOT NULL COMMENT '项目标识',
  project_desc varchar(4000) DEFAULT NULL,
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  create_user_id int(11) NOT NULL COMMENT '新建项目的用户id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  project_type tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型:0-普通项目，1-测试项目，2-生产项目',
  produce_project_id int(11) DEFAULT NULL COMMENT '绑定的生产项目id',
  schedule_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '调度状态：1-开启，2-暂停',
  is_allow_download tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否允许下载查询结果 1-正常 0-禁用',
  target_project_id int(11) DEFAULT '0' COMMENT '目标项目id',
  ref_project_id int(11),
  ref_project_name varchar(26) ,
  total_size int(11) NOT NULL DEFAULT '0',
  is_switch_jupyter tinyint(4) default 0 comment '是否开启jupyterlab,默认0,关闭',
  jupyter_url varchar(1000) default '' comment 'jupyter地址信息',
  jupyter_status tinyint(4) null comment 'jupyter运行状态',
  job_id varchar(32) null comment 'jupyter对应的jobid',
  jupyter_param text comment 'jupyter 环境参数',
  model_size int(11) not null default 0 COMMENT '已部署模型数量',
  switch_gpu tinyint(4) default 0 comment '默认关闭，0为关闭 1 为开启',
  temp_table_life int(11) DEFAULT 30 COMMENT '临时表生命周期，默认为30天',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE science_tenant (
  id int(11) NOT NULL AUTO_INCREMENT,
  dtuic_tenant_id int(11) NOT NULL COMMENT '租户id',
  tenant_name varchar(256) NOT NULL COMMENT '用户名称',
  tenant_desc varchar(256) DEFAULT NULL COMMENT '租户描述',
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  create_user_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY index_tenant_name (tenant_name(128))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE science_user (
  id int(11) NOT NULL AUTO_INCREMENT,
  dtuic_user_id int(11) NOT NULL COMMENT 'dtuic userid',
  user_name varchar(256) NOT NULL COMMENT '用户名称',
  email varchar(256) NOT NULL COMMENT '用户手机号',
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态0：正常，1：禁用',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  default_project_id int(11) DEFAULT NULL COMMENT '默认项目id',
  phone_number varchar(256) DEFAULT NULL COMMENT '用户手机号',
  PRIMARY KEY (id),
  UNIQUE KEY index_dtuic_user_id (dtuic_user_id),
  KEY index_user_name (user_name(128))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE science_dict (
  id int(11) NOT NULL AUTO_INCREMENT,
  type int(11) NOT NULL DEFAULT '0' COMMENT '区分字典类型，1：数据源字典 ...',
  dict_name VARCHAR(256) NOT NULL DEFAULT '' COMMENT '字典名',
  dict_value int(11) NOT NULL DEFAULT '0' COMMENT '字典值',
  dict_name_zh varchar(256) NOT NULL DEFAULT '' COMMENT '字典中文名',
  dict_name_en varchar(256) NOT NULL DEFAULT '' COMMENT '字典英文名',
  dict_sort int(11) NOT NULL DEFAULT '0' COMMENT '字典顺序',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;



CREATE TABLE science_permission (
  id int(11) NOT NULL AUTO_INCREMENT,
  code varchar(256) NOT NULL DEFAULT '' COMMENT '权限CODE',
  name varchar(256) DEFAULT NULL COMMENT '权限名',
  display varchar(256) DEFAULT NULL COMMENT '展示名称',
  parent_id int(11) DEFAULT NULL COMMENT '父权限id',
  type tinyint(1) DEFAULT '1' COMMENT '1:功能权限;2:数据权限',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='权限表';

CREATE TABLE science_role (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '角色所属租户id,0:基础角色',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  role_name varchar(256) NOT NULL COMMENT '角色名称',
  role_type tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色类型：1：功能权限',
  role_value tinyint(1) NOT NULL DEFAULT '0' COMMENT 'TEANTOWNER(1), PROJECTOWNER(2), PROJECTADMIN(3), MEMBER(4), OPERATION(5), DATADEVELOP(6)',
  role_desc varchar(256) NOT NULL DEFAULT '' COMMENT '角色描述',
  modify_user_id int(11) COMMENT '修改的用户',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  role_order tinyint(4) not null default 0 comment '角色排序',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';


CREATE TABLE science_role_permission (
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  role_id int(11) unsigned NOT NULL COMMENT '关联角色id',
  permission_id int(11) unsigned NOT NULL COMMENT '关联权限id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

CREATE TABLE science_role_user (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '-1' COMMENT '项目id',
  role_id int(11) NOT NULL COMMENT '角色id',
  user_id int(11) NOT NULL COMMENT '用户id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY index_project_user_role (project_id,user_id,role_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色用户关联表';

CREATE TABLE science_read_write_lock (
  id int(11) NOT NULL AUTO_INCREMENT,
  lock_name varchar(256) NOT NULL COMMENT '锁名称',
  project_id int(11) NOT NULL COMMENT '项目Id',
  relation_id int(11) NOT NULL COMMENT 'Id',
  type varchar(256) NOT NULL COMMENT '任务类型 ',
  modify_user_id int(11) NOT NULL COMMENT '修改的用户',
  version int(11) NOT NULL DEFAULT '1' COMMENT '乐观锁,0是特殊含义',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY index_read_write_lock (lock_name(128)),
  UNIQUE KEY index_lock (project_id,relation_id,type(128))
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
alter table science_read_write_lock add index idx_project_relation_type(project_id, type, is_deleted, relation_id);

create table science_task_save_version(
  id int(11) unsigned auto_increment primary key comment '主键 id',
  task_id int(11) unsigned not null comment '任务 id',
  sql_text text comment '代码文本/画布内容',
  exe_args text comment '运行参数',
  task_params text comment '任务参数',
  schedule_conf text comment '调度配置',
  task_version int(11) unsigned comment '版本号',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  create_user_id int(11) NOT NULL COMMENT '创建人id',
  modify_user_id int(11) DEFAULT '0' COMMENT '修改人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务保存版本';
alter table science_task_save_version add unique index idx_task_version_is_deleted(task_id, task_version, is_deleted);

CREATE TABLE science_notify (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  biz_type tinyint(1) NOT NULL COMMENT '业务类型，1：实时，2：离线',
  relation_id int(11) NOT NULL DEFAULT '0' COMMENT '关联id',
  name varchar(256) DEFAULT '' COMMENT '通知名称',
  trigger_type tinyint(1) NOT NULL DEFAULT '0' COMMENT '触发类型',
  webhook varchar(256) NOT NULL DEFAULT '' COMMENT '钉钉告警-自定义机器人的webhook',
  uncomplete_time VARCHAR (20) DEFAULT NULL COMMENT 'batch 任务 未完成超时的时间设置,HH:mm',
  send_way varchar (128) NOT NULL DEFAULT '' COMMENT '通知方式，从右到左如果不为0即选中（索引位从0开始，第1位：邮件，第2位: 短信，第3位: 微信，第4位: 钉钉）',
  start_time varchar(256) DEFAULT '' COMMENT '允许通知的开始时间，如5：00，早上5点',
  end_time varchar(256) DEFAULT '' COMMENT '允许通知的结束时间，如22：00，不接受告警',
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：正常，1：停止，2 停止访问',
  create_user_id int(11) NOT NULL COMMENT '创建的用户',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY idx_biz_type_relation_id (biz_type,relation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知表';

CREATE TABLE science_notify_record (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  notify_id int(11) NOT NULL DEFAULT '0' COMMENT '通知id',
  content_id int(11) NOT NULL DEFAULT '0' COMMENT '内容文本id',
  cyc_time VARCHAR(32) COMMENT '批处理调度的时间',
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息记录';

CREATE TABLE science_notify_user (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  notify_id int(11) NOT NULL COMMENT '通知id',
  user_id int(11) NOT NULL COMMENT '接收人id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (id),
KEY idx_notify_id_user_id (notify_id,user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知与接收人关系表';

CREATE TABLE science_notify_alarm (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  biz_type tinyint(1) NOT NULL COMMENT '业务类型，1：实时，2：离线',
  notify_id int(11) NOT NULL COMMENT '通知id',
  alarm_id int(11) NOT NULL COMMENT '告警id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY idx_biz_type_notify_id_alarm_id (biz_type,notify_id,alarm_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知记录表';

CREATE TABLE science_project_stick (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  project_id int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  user_id int(11) NOT NULL COMMENT '用户id',
  stick datetime DEFAULT NULL COMMENT '置顶字段',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY idx_project_user (project_id,user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';



CREATE TABLE science_task (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_pid int(11) COMMENT '父文件夹id, 组件不需要',
  name varchar(256) NOT NULL COMMENT '任务名称',
  task_type tinyint(1) NOT NULL COMMENT '任务类型 0 sql,1 mr 2 数据同步',
  engine_type tinyint(1) NOT NULL COMMENT '执行引擎类型 0 flink, 1 spark',
  compute_type tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  sql_text longtext NOT NULL COMMENT 'sql 文本',
  task_params text NOT NULL COMMENT '任务参数',
  schedule_conf varchar(2048) NOT NULL COMMENT '调度配置 json格式',
  period_type tinyint(2) COMMENT '周期类型',
  schedule_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  submit_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  modify_user_id int(11) NOT NULL COMMENT '最后修改task的用户',
  create_user_id int(11) NOT NULL COMMENT '新建task的用户',
  owner_user_id int(11) NOT NULL COMMENT '负责人id',
  version int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  task_desc varchar(256) NOT NULL,
  main_algorithm_desc varchar(256) COMMENT '主要使用的算法说明',
  main_class varchar(256) NOT NULL,
  exe_args text DEFAULT NULL,
  flow_id int(11) NOT NULL DEFAULT '0' COMMENT '工作流id',
  component_type tinyint(1) DEFAULT '0' COMMENT '组件类型',
  component_id int(11) comment '组件id',
  target_id int(11) DEFAULT '0' COMMENT '发布目标id',
  preset tinyint(4) default 0 comment '是否为预置实验演示任务,0为非预置,1为预置演示,默认为0',
  gpu_params text comment 'gpu 参数',
  order_val int(4) DEFAULT NULL COMMENT '排序字段',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


CREATE TABLE science_task_task (
  id int(11) NOT NULL AUTO_INCREMENT,
  task_id int(11) NOT NULL COMMENT 'batch 任务id',
  parent_task_id int(11) DEFAULT NULL COMMENT '对应batch任务父节点的id',
  input_type tinyint(1) DEFAULT NULL COMMENT '任务依赖类型,当前组件对应的上游组件输出,是当前组件获取的数据源',
  output_type tinyint(1) DEFAULT NULL COMMENT '任务依赖类型,也是input_type才对，标识上游输出对应的当前哪个输入桩',
  project_id int(11) NOT NULL COMMENT '项目id',
  tenant_id int(11) NOT NULL COMMENT '租户id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY index_batch_task_task (project_id,parent_task_id,task_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE science_job (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  job_id varchar(256) NOT NULL COMMENT '工作任务id',
  job_key varchar(256) NOT NULL DEFAULT '',
  log_info text COMMENT '日志',
  task_id int(11) NOT NULL COMMENT '任务id',
  status tinyint(1) NOT NULL COMMENT '任务状态',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) NOT NULL COMMENT '发起操作的用户',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY index_task_id (job_id(128),task_id,is_deleted),
  KEY index_project_id (project_id),
  UNIQUE KEY idx_jobKey (job_key(255))
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;


CREATE TABLE science_job_job (
  id int(11) NOT NULL AUTO_INCREMENT,
  job_key varchar(256) NOT NULL COMMENT 'batch 任务key',
  parent_job_key varchar(256) DEFAULT NULL COMMENT '对应batch任务父节点的key',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY idx_job_parentJobKey (job_key(255),parent_job_key(255))
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;


CREATE TABLE science_model (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  model_name varchar(256) NOT NULL COMMENT '模型名称',
  algorithm_id int(11) NOT NULL COMMENT '算法实验id',
  status tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  model_type int(2) NOT NULL COMMENT '模型类型，0为sklearn,1为spark,2为python',
  api_url varchar(256) NOT NULL DEFAULT '',
  host varchar(256) NOT NULL DEFAULT '' comment 'hdfs host',
  log_info text,
  model_origin tinyint(4) default 0 comment '模型来源:0为页面运行的模型,1为调度生成的模型,2为用户自己上传的模型',
  model_desc varchar(255) default '' comment '模型描述',
  algorithm_name varchar(64) default '' comment '算法名称',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) NOT NULL COMMENT '发起操作的用户',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE science_model_version (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  model_id int(11) NOT NULL COMMENT '模型id',
  version int(2) NOT NULL,
  active tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用状态 0 1',
  task_id int(11) NOT NULL COMMENT '模型组件id',
  model_file varchar(255) default null comment '模型文件路径',
  file_size int(11) default 0 comment '模型文件大小',
  flow_id int(11) default 0 comment '主流程Id',
  snapshot_path varchar(255) default '' comment 'pipLine流程快照',
  request_body text comment '该版本预测接口请求数据',
  response_data text comment '该版本预测接口响应数据',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) NOT NULL COMMENT '发起操作的用户',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  retry_count tinyint(1) NOT NULL DEFAULT '0' COMMENT '定时任务重新load模型的次数，连续load失败3次后，则不再load此模型',
  log_info text COMMENT '日志信息',
  PRIMARY KEY (id),
  UNIQUE KEY idx_version_modelId (model_id,version)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

create table if not exists science_model_version_param(
  id int(11) not null auto_increment comment '自增Id',
  model_id int(11) not null  default 0 comment '所部署的模型Id',
  model_version_id int(11) not null  default 0 comment '所部署的模型版本Id',
  io_param TEXT comment '输入输出信息',
  pip_line_param TEXT comment 'PipLine参数信息',
  component_param TEXT comment '组件参数',
  algorithm_id int(11) not null  default 0 comment '对应算法的任务id',
  component_type int(11) not null  default 0 comment '组件类型',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  create_user_id int(11) NOT NULL COMMENT '创建用户',
  modify_user_id int(11) NOT NULL COMMENT '修改用户',
  primary key (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8mb4;


CREATE TABLE science_sys_parameter (
  id int(11) NOT NULL AUTO_INCREMENT,
  param_name varchar(64) NOT NULL COMMENT '参数名称',
  param_command varchar(64) NOT NULL COMMENT '参数替换指令',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


CREATE TABLE science_task_param (
  id int(11) NOT NULL AUTO_INCREMENT,
  task_id int(11) NOT NULL COMMENT 'batch 任务id',
  type int(2) NOT NULL COMMENT '0:系统参数, 1:自定义参数',
  param_name varchar(64) NOT NULL COMMENT '参数名称',
  param_command varchar(64) NOT NULL COMMENT '参数替换指令',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY index_batch_task_parameter (task_id,param_name)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


CREATE TABLE science_catalogue (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_name varchar(128) NOT NULL COMMENT '文件夹名称',
  node_pid int(11) NOT NULL DEFAULT '-1' COMMENT '父文件夹id -1:没有上级目录',
  order_val int(3) DEFAULT NULL,
  level tinyint(1) NOT NULL DEFAULT '3' COMMENT '目录层级 0:一级 1:二级3:二级以下目录',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) NOT NULL COMMENT '创建用户',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY index_catologue_name (project_id,node_pid,node_name) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;



CREATE TABLE science_hive_select_sql (
  id int(11) NOT NULL AUTO_INCREMENT,
  job_id varchar(256) NOT NULL COMMENT '工作任务id',
  temp_table_name varchar(256) NOT NULL COMMENT '临时表名',
  is_select_sql tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-否 1-是',
  project_id int(11) NOT NULL COMMENT '项目id',
  tenant_id int(11) NOT NULL COMMENT '租户id',
  user_id int(11) DEFAULT NULL COMMENT '执行用户',
  sql_text longtext COMMENT 'sql',
  parsed_columns longtext COMMENT '字段信息',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY idx (job_id(128))
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='sql查询临时表';



-- 默认notebook任务模版
CREATE TABLE science_task_template (
  id int(11) NOT NULL AUTO_INCREMENT,
  task_type tinyint(2) NOT NULL COMMENT '任务类型',
  type tinyint(2) NOT NULL COMMENT '1-ods  2-dwd  3-dws  4-ads  5-dim',
  task_desc text NOT NULL COMMENT '任务描述',
  content text NOT NULL COMMENT '任务内容',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE science_data_source (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  name varchar(256) NOT NULL COMMENT '数据源名称',
  type varchar(32) NOT NULL COMMENT 'hive,txt,cvs',
  datasource_desc varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  location varchar(256) NOT NULL DEFAULT '' COMMENT '数据源路径',
  address varchar(256) NOT NULL DEFAULT '' COMMENT '数据源服务器地址',
  life_day int(11) NOT NULL COMMENT '生命周期',
  ref_hive_table_id int(11) NOT NULL COMMENT '关联hive表中id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE science_model_task_relation (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  model_file varchar(256) NOT NULL DEFAULT '模型文件路径',
  model_version_id int(11) NOT NULL COMMENT '模型分id',
  task_id int(11) NOT NULL COMMENT '模型组件id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

CREATE TABLE science_project_hit (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL,
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE science_resource (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_pid int(11) NOT NULL COMMENT '父文件夹id',
  url varchar(1028) NOT NULL COMMENT '资源路径',
  resource_type tinyint(1) NOT NULL DEFAULT '1' COMMENT '资源类型 1,jar 2 shell,3:py',
  resource_name varchar(256) NOT NULL COMMENT '资源名称',
  origin_file_name varchar(256) NOT NULL COMMENT '源文件名',
  resource_desc varchar(256) NOT NULL COMMENT '源文描述',
  target_id int(11) COMMENT '发布Id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  create_user_id int(11) NOT NULL COMMENT '新建资源的用户',
  modify_user_id int(11) NOT NULL COMMENT '修改人',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  KEY index_resource_name (project_id,resource_name(128)),
  KEY index_resource_type (resource_type,is_deleted)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

CREATE TABLE science_task_resource (
  id int(11) NOT NULL AUTO_INCREMENT,
  task_id int(11) NOT NULL COMMENT 'batch 任务id',
  resource_id int(11) DEFAULT NULL COMMENT '对应batch资源的id',
  resource_type int(11) COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
  project_id int(11) NOT NULL COMMENT '项目id',
  tenant_id int(11) NOT NULL COMMENT '租户id',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id),
  UNIQUE KEY index_project_task_resource_id (project_id,task_id,resource_id,resource_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE science_task_batch (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_pid int(11) DEFAULT NULL COMMENT '父文件夹id, 组件不需要',
  task_name varchar(256) NOT NULL COMMENT '批量任务名称',
  task_status tinyint(1) NOT NULL COMMENT '任务状态：0进行中，1成功（循环结束），2失败（循环异常结束）',
  sql_text longtext NOT NULL COMMENT '模版sql文本',
  task_params text COMMENT '任务参数',
  schedule_conf varchar(2048) DEFAULT NULL COMMENT '调度配置 json格式',
  period_type tinyint(2) DEFAULT NULL COMMENT '周期类型',
  create_type tinyint(1) DEFAULT '0' COMMENT '任务创建类型：0创建，1创建并提交',
  gmt_create datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  modify_user_id int(11) NOT NULL COMMENT '最后修改task的用户',
  create_user_id int(11) NOT NULL COMMENT '新建task的用户',
  owner_user_id int(11) NOT NULL COMMENT '负责人id',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='批量创建任务表（notebook）';

-- dataScience项目索引关联表
CREATE TABLE `science_project_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `engine_type` tinyint(1) NOT NULL COMMENT '多引擎的类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  `engine_identity` varchar(256) NOT NULL COMMENT '标识信息，比如hive的dbname',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态0：初始化，1：正常,2:禁用,3:失败',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- dataScience数据源表
CREATE TABLE if NOT EXISTS science_data_source_aiworks (
id int(11) NOT NULL AUTO_INCREMENT,
data_name varchar(128) NOT NULL COMMENT '数据源名称',
data_desc varchar(1024) NOT NULL COMMENT '数据源描述',
data_json varchar(2048) NOT NULL COMMENT '链接数据源信息需要加密 json格式',
type tinyint(1) NOT NULL DEFAULT '0' COMMENT '数据源类型 1:mysql, 2:oracle, 3:sqlserver, 4:postgresql, 5:rdbms, 6:hdfs, 7:hive, 8:hbase, 9:ftp, 10:maxcompute, 11:es, 12:redis, 13:mongodb, 14:kafka_11, 15:ads, 16:beats, 17:kafka_10, 18:kafka_09, 19:db2, 20:carbondata, 21:libra, 22:gbase_8a, 23:kylin',
active tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：未启用，1：使用中',
link_state tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：连接丢失，1：连接可用',
gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
tenant_id int(11) NOT NULL COMMENT '租户id',
project_id int(11) NOT NULL COMMENT '项目id',
create_user_id int(11) NOT NULL COMMENT '创建的用户',
modify_user_id int(11) NOT NULL COMMENT '修改的用户',
is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
is_default tinyint(4) DEFAULT '0',
PRIMARY KEY (id),
KEY index_science_data_source_aiworks (tenant_id,project_id,data_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据表信息
CREATE TABLE if NOT EXISTS science_hive_table_info (
id int(11) NOT NULL AUTO_INCREMENT,
project_id int(11) NOT NULL COMMENT '项目id',
tenant_id int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
table_name varchar(256) NOT NULL COMMENT '表名称',
table_type TINYINT(2) NOT NULL COMMENT '表类型',
table_desc varchar(2048) NULL COMMENT '表描述',
life_day int(11) NOT NULL DEFAULT '90' COMMENT '生命周期，单位：day',
life_status int(11) DEFAULT '0' COMMENT '生命周期状态，0：未开始，1：存活，2：销毁，3：执行过程出现异常',
table_size bigint(30) DEFAULT NULL COMMENT '表大小',
grade varchar(128) COMMENT '模型层级',
subject varchar(128) COMMENT '主题域',
refresh_rate varchar(128) COMMENT '刷新频率',
incre_type varchar(128) COMMENT '增量类型',
is_ignore tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
check_result varchar(256) COMMENT '检测结果',
size_update_time datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '表大小更新时间',
user_id int(11) NOT NULL COMMENT '用户id',
charge_user_id int(11) NOT NULL COMMENT '负责人',
modify_user_id int(11) NOT NULL COMMENT '修改人',
path varchar(512) NOT NULL DEFAULT '""' COMMENT '目录路径',
location varchar(1024) NOT NULL DEFAULT '' COMMENT 'hdfs路径',
delim varchar(50) NULL COMMENT '列分隔符',
store_type varchar(100) not null default 'orc' comment '存储格式',
catalogue_id int(11) NOT NULL DEFAULT '0' COMMENT '目录id',
last_ddl_time datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后表结构修改时间',
last_dml_time datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后数据更改时间',
gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
is_dirty_data_table tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-普通表 1-脏数据表',
life_check_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '表生命周期检查',
data_tag tinyint(4) not null default 0 comment '数据标签',
data_source_id int(11) unsigned not null default 0 comment '数据源 id',
PRIMARY KEY (id),
UNIQUE KEY idx (tenant_id,project_id,table_name(128), table_type),
KEY `idx_life_check` (`life_check_time`) USING BTREE COMMENT '表生命检查时间索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据表分区
CREATE TABLE `science_hive_table_partition`(
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`table_id` int(11) NOT NULL COMMENT '表id',
`partition` varchar(1024) NOT NULL COMMENT 'hdfs路径',
`store_size` bigint(30) NOT NULL COMMENT '分区大小',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `unique_idx` (`table_id`,`partition`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE if NOT EXISTS science_task_shade (
  id int(11) NOT NULL AUTO_INCREMENT,
  tenant_id int(11) NOT NULL COMMENT '租户id',
  project_id int(11) NOT NULL COMMENT '项目id',
  node_pid int(11) NOT NULL COMMENT '父文件夹id',
  name varchar(256) NOT NULL COMMENT '任务名称',
  task_type tinyint(1) NOT NULL COMMENT '任务类型 -1:虚节点, 0:sparksql, 1:spark, 2:数据同步, 3:pyspark, 4:R, 5:深度学习, 6:python, 7:shell, 8:机器学习, 9:hadoopMR, 10:工作流, 12:carbonSQL, 13:notebook, 14:算法实验, 15:libra sql, 16:kylin, 17:hiveSQL',
  engine_type tinyint(1) NOT NULL COMMENT '执行引擎类型 0:flink, 1:spark, 2:datax, 3:learning, 4:shell, 5:python2, 6:dtyarnshell, 7:python3, 8:hadoop, 9:carbon, 10:postgresql, 11:kylin, 12:hive',
  compute_type tinyint(1) NOT NULL COMMENT '计算类型 0实时，1 离线',
  sql_text LONGTEXT NOT NULL COMMENT 'sql 文本',
  task_params text NOT NULL COMMENT '任务参数',
  schedule_conf varchar(512) NOT NULL COMMENT '调度配置 json格式',
  period_type tinyint(2) COMMENT '周期类型',
  schedule_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
  submit_status tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未提交,1已提交',
  gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  modify_user_id int(11) NOT NULL COMMENT '最后修改task的用户',
  create_user_id int(11) NOT NULL COMMENT '新建task的用户',
  owner_user_id int(11) NOT NULL COMMENT '负责人id',
  version int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
  is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  task_desc varchar(256) NOT NULL,
  main_class varchar(256) NOT NULL,
  exe_args text DEFAULT NULL,
  flow_id INT ( 11 ) NOT NULL DEFAULT '0' COMMENT '工作流id',
  is_publish_to_produce tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布到生产环境：0-否，1-是',
  is_expire  TINYINT(1)   NOT NULL DEFAULT '0' COMMENT '过期策略：0永不过期 1过期取消',
  PRIMARY KEY (id),
  KEY index_name (project_id,name(128))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

CREATE TABLE if NOT EXISTS `science_hive_table_column` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`table_id` int(11) NOT NULL COMMENT '表id',
`column_name` varchar(128) NOT NULL COMMENT '字段名称',
`column_type` varchar(128) NOT NULL COMMENT '字段类型',
`column_desc` varchar(256) DEFAULT NULL COMMENT '字段描述',
`column_index` int(11) DEFAULT NULL COMMENT '排序',
`check_result` varchar(256) DEFAULT NULL COMMENT '检测结果',
`is_ignore` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否忽略 0:不忽略, 1:忽略',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx` (`table_id`,`column_type`,`column_index`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='表名模型检测表';

CREATE TABLE if NOT EXISTS `science_batch_model_rule` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
`project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
`rule` varchar(128) NOT NULL COMMENT '建表规则配置',
`create_user_id` int(11) NOT NULL COMMENT '新建用户',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='表名规则表';

-- 数据脱敏
CREATE TABLE `science_datamask_config` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`name` varchar(128) NOT NULL COMMENT '名称',
`table_id` int(11) NOT NULL COMMENT '关联表id',
`column_name` varchar(128) NOT NULL COMMENT '列名称',
`rule_id` int(11) NOT NULL COMMENT '关联规则id',
`example` varchar(255) COMMENT '样例',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
`enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_datamask_rule` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `tenant_id` int(11) NOT NULL COMMENT '租户id',
 `project_id` int(11) NOT NULL COMMENT '项目id',
 `name` varchar(128) NOT NULL COMMENT '名称',
 `example` varchar(255) COMMENT '样例',
 `mask_type` int(11) NOT NULL COMMENT '脱敏效果 0-全部脱敏 1-部分脱敏',
 `replace_str` varchar(32) NOT NULL COMMENT '替换字符',
 `begin_pos` int(11) NOT NULL DEFAULT '0' COMMENT '起始位置',
 `end_pos` int(11) NOT NULL DEFAULT '0' COMMENT '结束位置',
 `modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
 `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
 `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (`id`),
 UNIQUE KEY `unique_project_id_name` (`project_id`,`name`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_task_param_shade` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`task_id` int(11) NOT NULL COMMENT 'batch 任务id',
`type` int(2) NOT NULL COMMENT '0:系统参数, 1:自定义参数',
`param_name` varchar(64) NOT NULL COMMENT '参数名称',
`param_command` varchar(64) NOT NULL COMMENT '参数替换指令',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
KEY `index_science_parameter` (`task_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_task_resource_shade` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`task_id` int(11) NOT NULL COMMENT 'batch 任务id',
`resource_id` int(11) DEFAULT NULL COMMENT '对应batch资源的id',
`resource_type` int(11) DEFAULT NULL COMMENT '使用资源的类型 1:主体资源, 2:引用资源',
`project_id` int(11) NOT NULL COMMENT '项目id',
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `index_project_task_resource_id` (`project_id`,`task_id`,`resource_id`,`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `science_datamask_columns_info`(
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`config_id` int(11) NOT NULL COMMENT '关联脱敏配置id',
`table_id` int(11) NOT NULL COMMENT '关联表id',
`column_name` varchar(128) NOT NULL COMMENT '列名称',
`modify_user_id` int(11) NOT NULL COMMENT '最近修改人',
`enable` int(11) NOT NULL DEFAULT '0' COMMENT '是否禁用 0-正常 1-禁用',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `unique_config_table_column` (`config_id`,`table_id`,`column_name`,`is_deleted`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `science_task_version` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`tenant_id` int(11) NOT NULL COMMENT '租户id',
`project_id` int(11) NOT NULL COMMENT '项目id',
`task_id` int(11) NOT NULL COMMENT '父文件夹id',
`origin_sql` longtext COMMENT '原始sql',
`sql_text` longtext NOT NULL COMMENT 'sql 文本',
`publish_desc` text NOT NULL COMMENT '任务参数',
`create_user_id` int(11) NOT NULL COMMENT '新建的用户',
`version` int(11) NOT NULL DEFAULT '0' COMMENT 'task版本',
`task_params` text NOT NULL COMMENT '任务参数',
`schedule_conf` varchar(512) NOT NULL COMMENT '调度配置 json格式',
`schedule_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开始,1正常调度,2暂停',
`dependency_task_ids` text NOT NULL COMMENT '依赖的任务id，多个以,号隔开',
`period_type` tinyint(4) DEFAULT '-1' comment '周期调度类型,0:min,1:hour,2:day,3:week,4:month',
`gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
`gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
`exe_args` text comment '任务参数',
`component_type` int(11) default 0 not null comment '组件类型',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
`custom_params` text comment 'Notebook 自定义参数',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table science_task_version add index idx_project_task_version(is_deleted, project_id, task_id,version, period_type);
alter table science_task_version add index idx_task_create_time(is_deleted, task_id,gmt_create);

CREATE TABLE `science_alarm` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) DEFAULT '0' COMMENT '创建人',
  `update_by` int(11) DEFAULT '0' COMMENT '修改人',
  `alarm_rule_id` int(11) NOT NULL COMMENT '规则id',
  `task_id` int(11) NOT NULL COMMENT '规则id',
  `nextCheckTime` datetime NOT NULL COMMENT '下一次检查时间',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警表 主要记录下次扫描时间，规则和任务关联关系';


CREATE TABLE `science_alarm_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `alarm_rule_id` int(11) NOT NULL COMMENT '规则id',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `job_id` varchar(32) NOT NULL COMMENT '告警记录和job实例关联，特殊jobid 000000，特殊规则发送的告警',
  `task_name` varchar(255) DEFAULT NULL,
  `task_type` tinyint(4) DEFAULT NULL,
  `policy_type` tinyint(4) DEFAULT NULL,
  `send_time` datetime NOT NULL COMMENT '预期发送时间',
  `send_status` tinyint(3) NOT NULL COMMENT '发送状态 0未发送 1已发送',
  `send_type` varchar(64) NOT NULL,
  `receive_user` varchar(512) NOT NULL,
  `alarm_content` varchar(512) NOT NULL COMMENT '告警内容',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警记录表';


CREATE TABLE `science_alarm_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改人',
  `alarm_name` varchar(64) NOT NULL COMMENT '告警规则名称',
  `policy_type` tinyint(4) DEFAULT NULL COMMENT '触发策略类型 0任务失败，1任务成功，2定时未完成，3超时未完成，4特殊规则',
  `policy_conf` varchar(255) NOT NULL,
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '0开启，1关闭',
  `send_conf` varchar(255) NOT NULL COMMENT '发送策略配置',
  `scope` tinyint(4) DEFAULT '0' COMMENT '告警规则作用域 0 指定task，1当前项目全部task',
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则表';


CREATE TABLE `science_alarm_rule_receive_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_rule_id` int(11) NOT NULL COMMENT '告警规则id',
  `user_id` int(11) NOT NULL COMMENT '告警接收人',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则接收人表';


CREATE TABLE `science_alarm_rule_send` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `alarm_rule_id` int(11) NOT NULL COMMENT '告警规则id',
  `send_type` tinyint(4) NOT NULL COMMENT '1 邮件 2短信 3微信 4钉钉',
  PRIMARY KEY (`id`),
  KEY `idx_alarm_rule_id` (`alarm_rule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警规则-告警发送方式表';


CREATE TABLE `science_component` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) NOT NULL COMMENT '项目id',
  `component_name` varchar(64) NOT NULL COMMENT '组件名称',
  `component_type` tinyint(1) NOT NULL COMMENT '组件类型',
  `component_feature` tinyint(1) NOT NULL COMMENT '组件特征,0：数据处理类,1 ：特征工程类(带模型训练),2：特征工程(不带模型训练),3：机器学习类',
  `ml_type` tinyint(1) DEFAULT NULL COMMENT '机器学习类型，组件特征为机器学习时，用此字段标识具体的机器学习类型',
  `component_desc` varchar(256) DEFAULT NULL COMMENT '组件描述',
  `node_pid` int(11) NOT NULL COMMENT '父文件夹id',
  `script_text` text DEFAULT NULL COMMENT '脚本代码',
  `is_cite` tinyint(1) DEFAULT '0' COMMENT '是否被引用，0:否，1:是',
  `status` tinyint(1) DEFAULT '0' COMMENT '组件状态：0：未发布，1：已发布',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) DEFAULT '0' COMMENT '创建人',
  `modify_user_id` int(11) DEFAULT '0' COMMENT '修改人',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`),
  KEY `idx_project_id_node_pid` (`project_id`,`node_pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT = 1000 DEFAULT CHARSET=utf8mb4 COMMENT='自定义组件表';


CREATE TABLE `science_market_read_table_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `create_table_sql` varchar(2000) NOT NULL COMMENT '建表SQL',
  `table_data_hdfs_url` varchar(500) NOT NULL COMMENT '表数据存放在HDFS上的路径',
  `table_type` tinyint(2) NOT NULL COMMENT '数据表类型，目前只有hive表',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE science_dependent_task_task (
 id int(11) NOT NULL AUTO_INCREMENT,
 task_id int(11) NOT NULL COMMENT '关联的任务id',
 dtuic_tenant_id int(11) NOT NULL COMMENT 'uic租户id',
 tenant_id int(11) NOT NULL COMMENT '租户id',
 project_id int(11) COMMENT '项目id',
 app_type int(5) NOT NULL COMMENT 'app类型',
 parent_task_id int(11) COMMENT '依赖任务的id',
 parent_dtuic_tenant_id int(11) NOT NULL COMMENT '依赖任务的uic租户id',
 parent_task_name varchar(64) NOT NULL COMMENT '依赖任务的名称',
 parent_project_name varchar(64) NOT NULL COMMENT '依赖项目项目名称',
 parent_app_type int(5) NOT NULL COMMENT '依赖任务app类型',
 gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 gmt_modified datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
 create_user_id int(11) DEFAULT '0' COMMENT '创建人',
 modify_user_id int(11) DEFAULT '0' COMMENT '修改人',
 is_deleted tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
 PRIMARY KEY (id),
 KEY index_task_id_parent_task_id_project_id (task_id,parent_task_id,project_id),
 KEY index_task_id (task_id) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='外部任务依赖表,notebook、算法实验、其他子产品任务三者的依赖关系';


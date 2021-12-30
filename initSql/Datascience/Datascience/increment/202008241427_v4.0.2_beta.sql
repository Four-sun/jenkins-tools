alter table science_model add column model_origin tinyint(4) default 0 comment '模型来源:0为页面运行的模型,1为调度生成的模型,2为用户自己上传的模型';
alter table science_model add column model_desc varchar(255) default '' comment '模型描述';
alter table science_model add column algorithm_name varchar(64) default '' comment '算法名称';
alter table science_model_version add column flow_id int(11) default 0 comment '主流程Id';
alter table science_model_version add column snapshot_path varchar(255) default '' comment 'pipLine流程快照';
alter table science_model_version add column request_body text comment '该版本预测接口请求数据';
alter table science_model_version add column response_data text comment '该版本预测接口响应数据';
update science_model set model_origin = 0;
update science_model set algorithm_name = '其他' where algorithm_name is null or algorithm_name = '';
alter table science_model_version modify model_file varchar(255) null;
alter table science_model_version modify file_size int(11) null;

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
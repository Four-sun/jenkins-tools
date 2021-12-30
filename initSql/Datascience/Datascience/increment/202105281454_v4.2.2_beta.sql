CREATE TABLE science_model_service (
   id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
   name VARCHAR(128) NOT NULL COMMENT '服务英文名称',
   cn_name VARCHAR(128) DEFAULT '' COMMENT '服务中文名称',
   url VARCHAR(128) DEFAULT '' COMMENT '调用地址',
   protocol VARCHAR(16) NOT NULL COMMENT '协议',
   method VARCHAR (16) NOT NULL COMMENT '请求方式',
   content_type VARCHAR (16) NOT NULL COMMENT '返回格式',
   project_id INT(11) COMMENT '项目id',
   tenant_id INT(11) comment '租户 id',
   api_id INT(11) COMMENT '模型服务在api的id',
   token VARCHAR(128) COMMENT 'gateway token',
   gmt_create DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   gmt_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
   create_user_id INT(11) DEFAULT '0' COMMENT '创建人',
   modify_user_id INT(11) DEFAULT '0' COMMENT '修改人',
   is_deleted TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
   KEY index_project_id (project_id)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='模型服务，对应api服务分组';

ALTER TABLE science_model ADD COLUMN model_name_cn VARCHAR(32) DEFAULT '' COMMENT '模型中文名称';
ALTER table science_model ADD COLUMN online_time DATETIME  DEFAULT NULL COMMENT '上线时间';
ALTER table science_model ADD COLUMN offline_time DATETIME  DEFAULT NULL COMMENT '下线时间';
ALTER table science_model ADD COLUMN model_service_id INT(11) NOT NULL DEFAULT 0 COMMENT '所属服务 Id';
ALTER table science_model ADD COLUMN flow_percent TINYINT(3) NOT NULL DEFAULT 100 COMMENT '流量占比';
ALTER table science_model ADD COLUMN online_status TINYINT(1) NOT NULL DEFAULT '-1' COMMENT '上线状态, 未上线 -1,已上线 1,已下线0';
ALTER table science_model ADD COLUMN api_id INT(11) COMMENT '模型在api的id';

CREATE TABLE IF NOT EXISTS science_model_op (
    id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    op_content VARCHAR(128) NOT NULL COMMENT '操作内容',
    project_id INT(11) COMMENT '项目id',
    model_id  INT(11) COMMENT '模型id',
    user_name VARCHAR(256) NOT NULL COMMENT '用户名称',
    biz_time INT(11) NOT NULL COMMENT '业务时间(秒级时间戳)',
    tenant_id INT(11) comment '租户 id',
    gmt_create DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    gmt_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    create_user_id INT(11) DEFAULT '0' COMMENT '创建人',
    modify_user_id INT(11) DEFAULT '0' COMMENT '修改人',
    is_deleted TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    KEY index_project_id(project_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='模型操作变更记录';
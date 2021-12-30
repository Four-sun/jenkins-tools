ALTER TABLE da_apply_invoke DROP INDEX userid_apiId_isdeleted;

ALTER TABLE da_api ADD COLUMN cn_name varchar(255) DEFAULT NULL COMMENT 'api中文名称';
ALTER TABLE da_api_test ADD COLUMN cn_name varchar(255) DEFAULT NULL COMMENT 'api中文名称';

CREATE TABLE `da_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `label_name` varchar(255) NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='标签表';

CREATE TABLE `da_api_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  `tenant_id` int(11) NOT NULL COMMENT '租户id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user_id` int(11) NOT NULL COMMENT '创建的用户',
  `modify_user_id` int(11) NOT NULL COMMENT '修改的用户',
  `label_id` int(11) NOT NULL COMMENT '对应da_lable的id',
  `api_id` int(11) NOT NULL COMMENT '对应da_api的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT ='api标签关联表表';


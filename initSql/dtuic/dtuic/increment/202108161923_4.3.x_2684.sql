CREATE TABLE `uic_user_auth_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT '所属id',
  `type` int(1) NOT NULL COMMENT '类型 1 用于个人 2 用户组',
  `auth_file_id` bigint(20) not null comment '认证文件表主键',
  `auth_type_id` bigint(20) not null comment '认证文件类型主键 1 kerberos',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` varchar(1) COLLATE utf8_bin NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户认证文件关系表';

CREATE TABLE `uic_kerberos` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `open_kerberos` tinyint(1) NOT NULL COMMENT '是否开启kerberos配置',
    `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'kerberos文件名称',
    `kerberos_file_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '上传文件名',
    `remote_path` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'sftp存储路径',
    `principal` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'principal',
    `krb_name` varchar(26) COLLATE utf8_bin DEFAULT NULL COMMENT 'krb5_conf名称',
    `principals` text COLLATE utf8_bin COMMENT 'keytab用户文件列表',
    `merge_krb_content` text COLLATE utf8_bin COMMENT '合并后的krb5',
    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted` varchar(1) COLLATE utf8_bin NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
    `creator` int(11) DEFAULT NULL COMMENT '创建人',
    `modifier` int(11) DEFAULT NULL COMMENT '修改人',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='kerberos 信息表';

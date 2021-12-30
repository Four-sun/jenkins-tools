alter table `uic_user` add column `update_last_time` datetime DEFAULT NULL COMMENT '最近更新密码时间';

update `uic_user` set `update_last_time` = `gmt_create`;



CREATE TABLE `uic_group` (
     `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
     `group_name` varchar(128) NOT NULL COMMENT '组名称',
     `description` varchar(255) DEFAULT NULL COMMENT '组描述',
     `tenant_id` int(11) NOT NULL COMMENT '租户id',
     `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
     `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
     `creator` int(11) DEFAULT NULL COMMENT '创建人',
     `modifier` int(11) DEFAULT NULL COMMENT '修改人',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组表';



CREATE TABLE `uic_user_group_relation` (
       `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
       `user_id` int(11) NOT NULL COMMENT '用户id',
       `group_id` int(11) NOT NULL COMMENT '组id',
       `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
       `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
       `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
       `creator` int(11) DEFAULT NULL COMMENT '创建人',
       `modifier` int(11) DEFAULT NULL COMMENT '修改人',
       `tenant_id` int(11) NOT NULL COMMENT '租户id',
       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户组关系表';

alter table uic_group add unique index(group_name,tenant_id);

insert into uic_info(name,value) value ("is_hide_product", "Y");

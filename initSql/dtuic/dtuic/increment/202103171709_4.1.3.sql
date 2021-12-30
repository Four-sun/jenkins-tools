alter table uic_user add column user_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '用户有效期';

update uic_user set user_time =  DATE_ADD(now(),INTERVAL 50 YEAR);
CREATE TABLE `uic_user_renew_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `is_deleted` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `modifier` int(11) DEFAULT NULL COMMENT '修改人',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `before_renew_time` datetime NOT NULL COMMENT '续费之前的时间',
  `after_renew_time` datetime NOT NULL COMMENT '续费之后的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户续期记录表';

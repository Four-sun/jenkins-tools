CREATE TABLE  dl_api_invoke_log (
   id int(11) NOT NULL AUTO_INCREMENT,
   api_id  varchar(255) NOT NULL COMMENT '被调用的api的id',
   create_at  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   update_at  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
   create_by  int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
   update_by  int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
   is_deleted  tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='API调用日志表';
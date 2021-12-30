ALTER TABLE uic_user add COLUMN is_root varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是root用户,Y是，N否',
add COLUMN is_admin varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否是管理员,Y是，N否'

-- 租户-产品关联
CREATE TABLE uic_tenant_product_rel(
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_id int(11) unsigned NOT NULL  COMMENT '关联租户id',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  PRIMARY KEY(id)
) AUTO_INCREMENT=1001  DEFAULT CHARSET=utf8 COMMENT='租户-产品关联表';
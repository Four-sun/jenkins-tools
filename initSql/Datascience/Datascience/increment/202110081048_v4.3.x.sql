-- python模块表
CREATE TABLE IF NOT EXISTS `science_python_module` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_module_id` int(11) COMMENT '上级 module Id',
    `module_name`  VARCHAR(256) NOT NULL COMMENT 'python模块名称',
    `module_desc` VARCHAR(256) NOT NULL DEFAULT '' COMMENT 'python模块描述',
    `source_type`  tinyint(1) NOT NULL COMMENT '来源类型，-1:预置，0:平台，1:用户自定义',
    `order_val` int(3) DEFAULT 0 COMMENT '层次',
    `project_id` int(11) NOT NULL COMMENT '项目id',
    `dtuic_tenant_id` int(11) NOT NULL DEFAULT -1 COMMENT 'uic租户id',
    `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_user_id` INT(11) DEFAULT '0' COMMENT '创建人',
    `modify_user_id` INT(11) DEFAULT '0' COMMENT '修改人',
    `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id),
    KEY index_project_id(project_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='python模块表';

-- python类表
CREATE TABLE IF NOT EXISTS `science_python_class` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_class_id` int(11) COMMENT '上级 class Id',
    `module_id` INT(11) COMMENT '所属模块id',
    `class_name`  VARCHAR(256) NOT NULL COMMENT 'python类名称',
    `class_desc` VARCHAR(256) NOT NULL DEFAULT '' COMMENT 'python类描述',
    `source_type`  tinyint(1) NOT NULL COMMENT '来源类型，-1:预置，0:平台，1:用户自定义',
    `order_val` int(3) DEFAULT 0 COMMENT '层次',
    `project_id` int(11) NOT NULL COMMENT '项目id, -1:预置',
    `dtuic_tenant_id` int(11) NOT NULL DEFAULT -1 COMMENT 'uic租户id',
    `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_user_id` INT(11) DEFAULT '0' COMMENT '创建人',
    `modify_user_id` INT(11) DEFAULT '0' COMMENT '修改人',
    `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id),
    KEY index_project_id(project_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='python类表';


-- python函数表
CREATE TABLE IF NOT EXISTS `science_python_function` (
    `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `function_name`  VARCHAR(256) NOT NULL COMMENT '函数名称',
    `function_scope` tinyint(1) NOT NULL DEFAULT 0 COMMENT '函数作用域，0:public, 1:protect _ 2:private __',
    `function_desc` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '函数描述',
    `module_id` INT(11) COMMENT '所属模块id',
    `class_id` INT(11)  COMMENT '所属类id',
    `source_type`  tinyint(1) NOT NULL COMMENT '来源类型，-1:预置，0:平台，1:用户自定义',
    `order_val` int(3) DEFAULT 0 COMMENT '层次',
    `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
    `dtuic_tenant_id` int(11) NOT NULL DEFAULT -1 COMMENT 'uic租户id',
    `gmt_create` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `create_user_id` INT(11) DEFAULT '0' COMMENT '创建人',
    `modify_user_id` INT(11) DEFAULT '0' COMMENT '修改人',
    `is_deleted` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (id),
    KEY index_project_id(project_id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='python函数表';


-- 第三方python依赖
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('Crypto', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('Cython', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('PIL', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('PyQt5', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('TCLIService', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('_pytest', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('absl', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('alabaster', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('alembic', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('apscheduler', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('asn1crypto', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('astor', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('astroid', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('astropy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('attr', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('babel', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('backcall', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('backports', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bayes_opt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bcrypt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('binstar_client', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bitarray', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bkcharts', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('blaze', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bleach', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bokeh', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('boto', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bottleneck', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('bs4', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('caffe2', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('certifi', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cffi', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('chardet', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('click', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('clickhouse_driver', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cloudpickle', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('clyent', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('codecov', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('colorama', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('conda_verify', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('contextlib2', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('coverage', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cryptography', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cycler', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cython', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('cytoolz', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('dask', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('databricks', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('datashape', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('dateutil', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('decorator', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('defusedxml', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('dill', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('distributed', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('docs', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('docutils', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('easy_install', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('editor', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('entrypoint', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('et_xmlfile', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('fastcache', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('filelock', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('findspark', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_apscheduler', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_cors', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_migrate', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_script', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_session', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('flask_sqlalchemy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('future', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('gast', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('gevent', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('glob2', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('gmpy2.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('google', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('greenlet.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('grpc', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('gssapi', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('h5py', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('heapdict', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('html5lib', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('hyperopt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('idna', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('imageio', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('imagesize', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('importlib_metadata', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('ipykernel_launcher', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('isort', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('itsdangerou', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jdcal', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jedi', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jieba', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jinja2', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('joblib', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jsonschema', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jupyter', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('jupyterlab', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('kafka', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('kazoo', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('keras', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('keras_applications', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('keras_preprocessing', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('kiwisolver.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('krbcontext', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('lazy_object_proxy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('libfuturize', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('libpasteurize', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('llvmlite', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('lxml', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mako', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('markdown', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('markupsafe', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('matplotlib', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mccabe', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mistune', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mistune.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mkl', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mkl_fft', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mkl_random', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mpl_toolkits', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('mpmath', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('msgpack', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('multipledispatch', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('nacl', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('navigator_updater', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('nbconvert', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('nbformat', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('networkx', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('nltk', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('nose', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('numba', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('numexpr', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('numpy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('numpydoc', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('odo', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('olefile', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('openpyxl', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('packaging', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pandas', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pandocfilter', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('paramiko', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('parso', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('partd', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('past', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pasta', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('path', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('patsy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pep8', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pexpect', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pickleshare', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pkginfo', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pluggy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('ply', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('prometheus_client', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('prompt_toolkit', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('psutil', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('ptyprocess', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('py', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('py4j', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyarrow', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pycodestyle', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pycosat.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pycparser', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pycurl.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyflakes', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pygments', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyhdf', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyhive', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pylab', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pylint', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pymysql', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyodbc.cpython-36m-x86_64-linux-gnu', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pypandoc', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyparsing', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyspark', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest_arraydiff', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest_cov', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest_doctestplus', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest_openfiles', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytest_remotedata', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pytz', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pywt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('pyximport', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('qtawesome', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('qtconsole', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('qtpy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('redis', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('requests', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('rope', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('ruamel_yaml', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sasl', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('scipy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('scripts', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('seaborn', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('send2trash', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('setuptools', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('simplegeneric', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('simplejson', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('singledispatch', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('singledispatch_helper', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sip', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sipconfig', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sipdistutil', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('six', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('skimage', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sklearn', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('snowballstemmer', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sock', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sockshandler', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sortedcollections', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sortedcontainers', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sphinx', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sphinxcontrib', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder_breakpoints', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder_io_dcm', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder_io_hdf5', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder_profiler', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('spyder_pylint', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sqlalchemy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('statsmodels', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('sympy', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tables', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tblib', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tensorboard', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tensorflow', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tensorflow_estimator', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('termcolor', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('terminado', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('test_path', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('test_pycosat', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('testpath', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('thrift', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tlz', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('toolz', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('torch', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tornado', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tqdm', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('traitlets', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('typing', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('tzlocal', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('unicodecsv', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('urllib3', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('wcwidth', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('webencodings', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('werkzeug', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('wheel', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('widgetsnbextension', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('wrapt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('xgboost', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('xlrd', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('xlsxwriter', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('xlwt', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('yaml', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('zi', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('zict', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('zmq', '', '-1', '-1', now(), now(), '0', '0', '0', '-1', NULL);


-- 平台python依赖
INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `project_id`,`order_val`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`) VALUES
('aiworks_plugins', '', '0', '-1', 0 ,now(), now(), '0', '0', '0', '-1', NULL);


INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `order_val`,`project_id`,`gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`)
SELECT 'tf_plugins', '', '0', 1 ,'-1', now(), now(), '0', '0', '0', '-1',id FROM science_python_module WHERE module_name = 'aiworks_plugins' AND order_val = 0 AND source_type = 0;


INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `order_val`,`project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`)
SELECT 'hdfs_plugins', '', '0', 1,'-1', now(), now(), '0', '0', '0', '-1',id FROM science_python_module WHERE module_name = 'aiworks_plugins' AND order_val = 0 AND source_type = 0;


INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `order_val`,`project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`)
SELECT 'saved_model', '', '0', 2,'-1', now(), now(), '0', '0', '0', '-1',id FROM science_python_module WHERE module_name = 'tf_plugins' AND order_val = 1 AND source_type = 0;


INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`,`order_val`, `project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`)
SELECT 'saved_model', '', '0', 2,'-1', now(), now(), '0', '0', '0', '-1',id FROM science_python_module WHERE module_name = 'hdfs_plugins' AND order_val = 1 AND source_type = 0;


INSERT INTO `science_python_module` (`module_name`, `module_desc`, `source_type`, `order_val`,`project_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`, `dtuic_tenant_id`, `parent_module_id`)
SELECT 'saved_model_pyspark', '', '0', 2,'-1', now(), now(), '0', '0', '0', '-1',id FROM science_python_module WHERE module_name = 'hdfs_plugins' AND order_val = 1 ;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_tf_model_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model' AND t2.module_name = "tf_plugins" AND t1.order_val = 2 AND t1.source_type = 0;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_keras_model_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model' AND t2.module_name = "tf_plugins" AND t1.order_val = 2 AND t1.source_type = 0;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_torch_model_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1',now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model' AND t2.module_name = "tf_plugins" AND t1.order_val = 2 AND t1.source_type = 0;



INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_python_model_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model' AND t2.module_name = 'hdfs_plugins' AND t1.order_val = 2 AND t1.source_type = 0;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_python_pipeline_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model' AND t2.module_name = 'hdfs_plugins' AND t1.order_val = 2 AND t1.source_type = 0;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_pyspark_model_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model_pyspark' AND t2.module_name = 'hdfs_plugins' AND t1.order_val = 2 AND t1.source_type = 0;


INSERT INTO `science_python_function` (`function_name`, `function_scope`, `function_desc`, `module_id`, `class_id`, `source_type`, `order_val`, `project_id`, `dtuic_tenant_id`, `gmt_create`, `gmt_modified`, `create_user_id`, `modify_user_id`, `is_deleted`)
SELECT 'save_spark_pipeline_to_hdfs', '0', '', t1.id, NULL, '0', '0', '-1', '-1', now(), now(), '0', '0', '0' FROM science_python_module t1
LEFT JOIN science_python_module t2 on t1.parent_module_id = t2.id
WHERE t1.module_name = 'saved_model_pyspark' AND t2.module_name = 'hdfs_plugins' AND t1.order_val = 2 AND t1.source_type = 0;
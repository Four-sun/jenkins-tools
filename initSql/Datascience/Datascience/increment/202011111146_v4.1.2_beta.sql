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

INSERT INTO `science_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`,`gmt_modified`, `is_deleted`)
VALUES ('13', 'Component', '3', '自定义组件', 'component', '9', now(), now(), '0');
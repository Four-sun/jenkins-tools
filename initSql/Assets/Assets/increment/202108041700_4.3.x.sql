-- 数据库拾取表
CREATE TABLE `assets_database_collection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `collect_type` tinyint(1) NOT NULL COMMENT '拾取类型,0词根管理,1数据标准',
  `collect_from` varchar(255) NOT NULL COMMENT '拾取来源',
  `collect_condition` varchar(255) NOT NULL COMMENT '拾取条件',
  `collect_status` tinyint(1) NOT NULL COMMENT '拾取状态,0拾取中,1拾取完成',
  `collect_count` bigint(20) DEFAULT '0' COMMENT '拾取数量',
  `finish_date` datetime DEFAULT NULL COMMENT '拾取完成时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据库拾取表';

-- 词根拾取结果记录表
CREATE TABLE `assets_root_collection_record` (
 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
 `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
 `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
 `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
 `collect_id` bigint(20) NOT NULL COMMENT '拾取id',
 `root_abbreviation` varchar(255) NOT NULL COMMENT '词根简称',
 `root_cn` varchar(255) DEFAULT NULL COMMENT '词根中文名',
 `repeat_count` bigint(20) DEFAULT '0' COMMENT '重复情况',
 `status` tinyint(1) NOT NULL COMMENT '状态,0未引用,1已引用',
 `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='词根拾取结果记录表';

-- 标准拾取结果记录表
CREATE TABLE `assets_standard_collection_record` (
 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
 `create_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
 `update_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新人',
 `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
 `collect_id` bigint(20) NOT NULL COMMENT '拾取id',
 `column_name` varchar(255) NOT NULL COMMENT '字段名',
 `column_comment` varchar(255) DEFAULT NULL COMMENT '字段注释',
 `standard_name_cn` varchar(255) DEFAULT NULL COMMENT '标准中文名',
 `repeat_count` bigint(20) DEFAULT '0' COMMENT '重复情况',
 `status` tinyint(1) NOT NULL COMMENT '状态,0未引用,1已引用',
 `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标准拾取结果记录表';

-- 词根来源id
ALTER TABLE `assets_standard_root`
    ADD COLUMN `from_id` BIGINT(20) DEFAULT NULL COMMENT '词根来源id' AFTER `quote_count`;

-- 标准新增字段
ALTER TABLE `assets_standard`
  ADD COLUMN `bind_count` BIGINT(100) NOT NULL DEFAULT '0' COMMENT '字段绑定（个）' AFTER `enum_range`;

-- 标准来源id
ALTER TABLE `assets_standard`
    ADD COLUMN `from_id` BIGINT(20) DEFAULT NULL COMMENT '标准来源id' AFTER `bind_count`;



-- 标准映射表新增字段
ALTER TABLE `assets_standard_mapping`
    ADD COLUMN `data_type` varchar(255) NOT NULL DEFAULT '' COMMENT '字段类型' AFTER `bind_status`,
		ADD COLUMN `mapping_date` datetime DEFAULT NULL COMMENT '映射时间' AFTER `data_type`;

-- 匹配相关度分数
ALTER TABLE `assets_standard_mapping`
    ADD COLUMN `score` int(11) NOT NULL DEFAULT '0' COMMENT '匹配相关度分数' AFTER `mapping_date`;

-- 删除match_status字段
ALTER TABLE assets_standard_mapping DROP match_status;

-- 字段标准绑定记录表
CREATE TABLE `assets_column_bind_record` (
 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
 `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
 `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
 `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
 `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
 `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
 `column_id` bigint(20) NOT NULL COMMENT '字段id',
 `standard_id` bigint(20) NOT NULL COMMENT '标准id',
 `data_source_type` int(11) NOT NULL COMMENT '数据源类型',
 `column_name` varchar(255) NOT NULL DEFAULT '' COMMENT '字段名',
 `table_name` varchar(255) NOT NULL DEFAULT '' COMMENT '表名',
 `bind_date` datetime NOT NULL COMMENT '绑定时间',
 `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段标准绑定记录表';

-- 映射发起记录表
CREATE TABLE `assets_standard_mapping_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by` int(11) NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by` int(11) NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `standard_id` bigint(100) NOT NULL COMMENT '标准id',
  `mapping_date` datetime DEFAULT NULL COMMENT '映射发起时间',
  `mapping_status` tinyint(1) NOT NULL COMMENT '映射状态,-1初始化状态,0映射中,1映射结束',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='映射发起记录表';

-- 更新标准字段绑定数量
update assets_standard inner join (select
    standard_id,
    count(distinct column_id) as total
    from assets_standard_mapping
    where is_deleted = 0
    and bind_status = 1
    group by standard_id) c on assets_standard.id = c.standard_id set assets_standard.bind_count = c.total;

-- 绑定字段迁移
insert into assets_column_bind_record(create_by, update_by, column_id, standard_id, data_source_type, column_name, table_name, bind_date, tenant_id)
select
    t1.create_by,
    t1.update_by,
    t1.column_id,
    t1.standard_id,
    t1.data_source_type,
    t2.column_name,
    t2.table_name,
    t1.update_at as bind_date,
    t1.tenant_id
from
    assets_standard_mapping t1
        left join assets_data_table_column t2 on t1.column_id = t2.id
where t1.is_deleted = 0 and t1.bind_status = 1;

-- 填充映射记录中的映射时间
update assets_standard_mapping inner join (select
    id,
    create_at
    from assets_standard_mapping
    ) c on assets_standard_mapping.id = c.id set assets_standard_mapping.mapping_date = c.create_at;

-- 填充映射记录中的数据类型
update assets_standard_mapping inner join (select
    id,
    column_type
    from assets_data_table_column
    ) c on assets_standard_mapping.column_id = c.id set assets_standard_mapping.data_type = c.column_type;

-- 补充映射发起记录
insert into assets_standard_mapping_record(standard_id, mapping_date, mapping_status, tenant_id)
select
    standard_id,
    mapping_date,
    1,
    tenant_id
from assets_standard_mapping
where is_deleted = 0
group by standard_id, mapping_date;

-- 标准统计表
CREATE TABLE `assets_standard_statistic`
(
  `id`                bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`         bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`         datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`        tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `statistic_date`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `total_count`       int(11)             NOT NULL COMMENT '标准总数',
  `published_count`   int(11)             NOT NULL COMMENT '已发布总数',
  `unpublished_count` int(11)             NOT NULL COMMENT '未发布总数',
  `tenant_id`         bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标准统计表';

-- 代码统计表
CREATE TABLE `assets_standard_code_statistic`
(
  `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`   bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`   bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`   datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`   datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`  tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `total_count` int(11)             NOT NULL COMMENT '代码总数',
  `tenant_id`   bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='代码统计表';


-- 词根统计表
CREATE TABLE `assets_standard_root_statistic`
(
  `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`   bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`   bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`   datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`   datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`  tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `total_count` int(11)             NOT NULL COMMENT '词根总数',
  `tenant_id`   bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='词根统计表';


-- 代码热度统计表
CREATE TABLE `assets_standard_heat_statistic`
(
  `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`      bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`      datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`     tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `total_count`    int(11)             NOT NULL COMMENT '热度',
  `heat_name`      varchar(255)        NOT NULL COMMENT '名称',
  `type`           int(11)             NOT NULL COMMENT '1 标准 2 代码',
  `statistic_date` datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '统计时间',
  `tenant_id`      bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='代码热度统计表';

-- 标准来源统计表
CREATE TABLE `assets_standard_from_statistic`
(
  `id`            bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`    tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `total_count`   int(11)             NOT NULL COMMENT '标准总数',
  `standard_from` varchar(255)        NOT NULL COMMENT '标准来源',
  `tenant_id`     bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  `standard_type` tinyint(1)          NOT NULL COMMENT '统计类型code【1-数据标准，2-码表】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标准来源统计表';


CREATE TABLE `assets_standard_catalog_statistic`
(
  `id`            bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`    tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `total_count`   int(11)             NOT NULL COMMENT '标准总数',
  `catalog_name`  varchar(255)        NOT NULL COMMENT '标准目录名称',
  `catalog_id`    bigint(20)          NOT NULL COMMENT '标准目录id',
  `tenant_id`     bigint(20)          NOT NULL COMMENT '租户id,用于租户隔离',
  `standard_type` tinyint(1)          NOT NULL COMMENT '统计标准类型1-标准，2-码表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标准目录统计表';

-- 标准预设模版表
CREATE TABLE `assets_standard_preset_template`
(
  `id`            bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '创建人',
  `update_by`     bigint(20)          NOT NULL DEFAULT '0' COMMENT '更新人',
  `create_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`     datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted`    tinyint(1)          NOT NULL DEFAULT '0' COMMENT '0 未删除 1 已删除',
  `template_name` varchar(255)        NOT NULL COMMENT '模版名称',
  `industry`      varchar(255)        NOT NULL COMMENT '所属行业',
  `type`          tinyint(1)                   DEFAULT NULL COMMENT '标准类型[1-数据标准，2-码表]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='标准模版表';

INSERT INTO `assets_standard_preset_template`
(`id`, `create_by`, `update_by`, `create_at`, `update_at`, `template_name`, `industry`, `type`)
VALUES (1, 1, 1, now(), now(), '中国银监会银行业金融机构监管标准化规范', '金融行业', 1),
       (2, 1, 1, now(), now(), '银行间市场基础数据元(JR/T 0065—2019)', '金融行业', 1),
       (3, 1, 1, now(), now(), '银行信息化通用数据元(JR/T 0015—2004)', '金融行业', 1),
       (4, 1, 1, now(), now(), '银行信息化通用代码集(JR/T 0014-2005)', '金融行业', 2);

-- 预设标准模版表
CREATE TABLE `assets_standard_preset_standard`
(
  `id`                         bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at`                  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`                  datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by`                  int(11)             NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by`                  int(11)             NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted`                 tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `standard_name_cn`           varchar(255)        NOT NULL COMMENT '标准中文名',
  `standard_name`              varchar(255)        NOT NULL COMMENT '标准名称',
  `data_length`                int(11)                      DEFAULT NULL COMMENT '数据长度',
  `data_length_operator`       varchar(4)                   DEFAULT NULL COMMENT '数据长度-运算符',
  `default_value`              varchar(255)                 DEFAULT NULL COMMENT '默认值',
  `data_type_id`               tinyint(1)                   DEFAULT NULL COMMENT '默认数据类型',
  `pre_precision`              int(3)                       DEFAULT NULL COMMENT '数据精度-小数点前',
  `post_precision`             int(3)                       DEFAULT NULL COMMENT '数据精度-小数点后',
  `standard_from`              varchar(255)                 DEFAULT NULL COMMENT '标准来源',
  `standard_number`            varchar(255)                 DEFAULT NULL COMMENT '标准编号',
  `standard_name_abbreviation` varchar(255)        NOT NULL DEFAULT '' COMMENT '标准缩写',
  `catalog`                    varchar(255)         NOT NULL COMMENT '标准目录路径',
  `business_definition`        varchar(255)                 DEFAULT NULL COMMENT '业务定义',
  `custom_attribute`           json                         DEFAULT NULL COMMENT '自定义属性 json字符串',
  `nullable`                   tinyint(1)                   DEFAULT NULL COMMENT '允许为空 0不可空 1可空',
  `repeatable`                 tinyint(1)                   DEFAULT NULL COMMENT '允许重复 0不允许 1允许',
  `value_range`                json                         DEFAULT NULL COMMENT '取值范围 json字符串',
  `template_id`                bigint(20)          NOT NULL COMMENT '代码目录id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 157
  DEFAULT CHARSET = utf8 COMMENT ='预设标准模版表';


-- 预设码表模版表
CREATE TABLE `assets_standard_preset_code`
(
  `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_at`    datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '创建的用户',
  `update_by`    int(11)             NOT NULL DEFAULT '0' COMMENT '修改的用户',
  `is_deleted`   tinyint(1)          NOT NULL DEFAULT '0' COMMENT '是否删除,1删除，0未删除',
  `code_name`    varchar(255)        NOT NULL COMMENT '代码名称',
  `code_number`  varchar(255)        NOT NULL COMMENT '代码编号',
  `code_desc`    varchar(255)                 DEFAULT NULL COMMENT '代码说明',
  `code_from`    varchar(255)                 DEFAULT NULL COMMENT '代码来源',
  `code_content` json                         DEFAULT NULL COMMENT '代码内容 json字符串',
  `catalog`      varchar(255)                 DEFAULT NULL COMMENT '标准目录路径',
  `template_id`  bigint(20)          NOT NULL COMMENT '代码目录id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='预设码表模版表';

-- 标准统计定时任务
INSERT INTO `dt_center_cron_schedule` ( `id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`, `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`, `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted` ) VALUES( 17, 'standardStatisticJob', 'standardStatisticJobGroup', 'standardStatisticJobTrigger', 'standardStatisticJobGroup', 'com.dtstack.assets.service.schedule.job.StandardStatisticJob', '0 0 3 * * ?', 0, NULL, NULL, 'assets', '2020-11-17 19:56:40', '2020-11-17 19:56:40', 0 );

-- 预设模版数据插入
delete
from assets_standard_preset_standard;
insert into assets_standard_preset_standard (standard_name_cn, standard_name, standard_name_abbreviation,
                                             standard_number, catalog, business_definition, custom_attribute,
                                             data_type_id, data_length, data_length_operator, post_precision,
                                             pre_precision, nullable, repeatable, default_value, value_range,
                                             template_id)
values ('名称', 'Name', 'Name', '001001', '公共信息', '名称应与公章所使用的名称完全一致。银行机构以银监会金融机构许可证登记名称为准。无独立金融机构许可证的机构，可在本名称中体现出机构特征。
客户名称按照客户的不同类型按如下标准填报。
（1）集团客户，填报银行对该集团授信采用的集团客户名称。视同集团客户填报的供应链融资填报核心企业客户名称。
（2）单一法人客户，经有关部门批准正式使用的全称，与公章所使用的名称完全一致。视同单一法人客户填报的分公司，填报分公司全称，与分公司公章所使用的名称完全一致。
（3）同业客户，经有关部门批准正式使用的客户全称，与客户公章所', null, null, 200, '<=', null, null, null, null, null, null, 1)
     ,('是否标志', 'Yes_or_No', 'Yes_or_No', '1002.', '公共信息', '是，否。', null, null, 4, '<=', null, null, null, null, null,
       null, 1)
     ,('比例', 'Ratio', 'Ratio', '1003.', '公共信息', '百分比为单位，即1/100，保留两位小数。', null, null, null, null, 2, 10, null, null,
       null, null, 1)
     ,('面积', 'Area', 'Area', '1004.', '公共信息', '平方米。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('日期', 'Date', 'Date', '1005.', '公共信息', 'YYYYMMDD，默认值99991231。', null, null, null, null, null, null, null, null,
       null, null, 1)
     ,('年月', 'Year_&_Month', 'Year_&_Month', '1006.', '公共信息', 'YYYYMM，默认值999912。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('时间', 'Time', 'Time', '1007.', '公共信息', '24小时制时间，精确到秒。hhmmss，默认值000000。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('时间戳', 'Timestamp', 'Timestamp', '1008.', '公共信息',
       '交易的唯一性的时间表示，YYYYMMDDhhmmssuuuuuu（后六位代表精确度微秒级），默认值99991231000000000000。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('地址', 'Address', 'Address', '1009.', '公共信息',
       '中文描述。个人住址。金融机构以金融机构许可证登记地址为准。集团母公司为境内企业的，按照《企业法人营业执照》中的注册地填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）。集团母公司为境外企业的，不填报。',
       null, null, 400, '<=', null, null, null, null, null, null, 1)
     ,('电话', 'Tel.', 'Tel.', '1010.', '公共信息', '银行自定义。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('银行机构代码', 'Bank_code', 'Bank_code', '1011.', '公共信息', '人行支付行号', null, null, 30, '<=', null, null, null, null,
       null, null, 1)
     ,('金融许可证号', 'Financial_license_number', 'Financial_license_number', '1012.', '公共信息', '金融许可证机构编码编制规则（试行）
_一、机构编码结构
_机构编码由大写英文字母和数字组成，共15位。分六个部分，分别是机构类型代码、机构代码、组织类别代码、发证机关代码、地址代码、顺序代码，从左至右顺序排列，如下表所示。
_二、机构编码含义
_（一）第［一］位是机构类型代码，用大写英文字母表示。
_A-政策性银行
B-商业银行
C-农村合作银行
D-城市信用社
E-农村信用社
F-资金互助社
J-金融资产管理公司
K-信托公司
L-财务公司
M-金融租赁公司
N-汽车金融公司
P-货币经纪公司
Q-贷款', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('内部机构号', 'Inner_organization_number', 'Inner_organization_number', '1013.', '公共信息', '银行内部机构号。应具有标识机构的唯一性。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('机构类别', 'Organization_type', 'Organization_type', '1014.', '公共信息', '中文字典或中文描述，银行自定义。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('邮政编码', 'Zip_code', 'Zip_code', '1015.', '公共信息', '该机构注册地邮政编码，6位。超过6位的只取前6位。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('网点号', 'Branch_number', 'Branch_number', '1016.', '公共信息', '银行内部机构号。', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('营业状态', 'Business_state', 'Business_state', '1017.', '公共信息', '营业，停业，被合并。', null, null, 9, '<=', null, null, null,
       null, null, null, 1)
     ,('工号', 'Emp_ID', 'Emp_ID', '1018.', '公共信息', '工号。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('姓名', 'Name_(people)', 'Name_(people)', '1019.', '公共信息', '姓名。', null, null, 100, '<=', null, null, null, null,
       null, null, 1)
     ,('所属部门', 'Department', 'Department', '1021.', '公共信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null, null,
       null, null, null, 1)
     ,('职务', 'Post.', 'Post.', '1022.', '公共信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null, null, null, null,
       null, 1)
     ,('状态', 'Status', 'Status', '1023.', '公共信息', '中文字典或中文描述，银行自定义。', null, null, 30, '<=', null, null, null, null,
       null, null, 1)
     ,('柜员号', 'Teller_number', 'Teller_number', '1024.', '公共信息', '柜员编号。银行自定义。', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('柜员类型', 'Type_of_teller', 'Type_of_teller', '1025.', '公共信息', '中文字典或中文描述，银行自定义。', null, null, 30, '<=', null,
       null, null, null, null, null, 1)
     ,('审批授信额度', 'Limit_of_credit_approval', 'Limit_of_credit_approval', '1026.', '公共信息', '审批授信额度（币种：人民币）。', null, null,
       null, null, 2, 10, null, null, null, null, 1)
     ,('授权范围', 'Scope_of_authority', 'Scope_of_authority', '1027.', '公共信息', '可以授权的业务种类，银行自定义。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('柜员用户级别', 'Teller_level', 'Teller_level', '1028.', '公共信息', '银行自定义。', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('柜员权限级别', 'Teller_authority', 'Teller_authority', '1029.', '公共信息', '柜员权限级别，银行自定义。', null, null, 30, '<=', null,
       null, null, null, null, null, 1)
     ,('岗位编号', 'Post_number', 'Post_number', '1030.', '公共信息', '银行自定义。', null, null, 60, '<=', null, null, null, null,
       null, null, 1)
     ,('岗位种类', 'Post_type', 'Post_type', '1031.', '公共信息', '岗位种类，中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('岗位名称', 'Post_name', 'Post_name', '1032.', '公共信息', '岗位名称，中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('岗位说明', 'Post_description', 'Post_description', '1033.', '公共信息', '对岗位工作的中文描述，银行自定义。', null, null, 400, '<=',
       null, null, null, null, null, null, 1)
     ,('金融机构代码', 'Bank_code_for_statistic', 'Bank_code_for_statistic', '001034', '公共信息',
       '上报人行全科目时所用的金融机构代码。金融机构代码由中国人民银行统一编发。第一级：清算中心编码，占4个字节。规定一个中心城市范围内只能用中心城市人民银行的清算中心代码，不能使用人民银行县级支行清算中心代码。第二级：机构代码，占3个字节。在原1位银行行别和保险公司标志代码（GB13496-92）的基础上，左右各扩充1位。最左边1位可以作为机构类别代码，将顺序编码法改为分类编码法。数据资源不足时，可以向英文字母A-Z扩充。第三级：分支机构代码，占3个字节。第1位为中心城市下属地区（主要是下属县或县级市、区）编码',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('地区名称', 'District_name', 'District_name', '001035', '公共信息',
       '地区名称。金融机构填写金融机构代码对应的地区名称。集团母公司为境内企业的，按照《企业法人营业执照》中的注册地填报，要写明省（区、市）、地（区、市、州、盟）、县（区、市、旗）。集团母公司为境外企业的，不填报。', null,
       null, 60, '<=', null, null, null, null, null, null, 1)
     ,('数量', 'Quantity', 'Quantity', '001036', '公共信息', '数量。', null, null, null, null, null, null, null, null, null,
       null, 1)
     ,('名称集合', 'Collection_of_names', 'Collection_of_names', '001037', '公共信息', '多个名称', null, null, 1000, '<=', null,
       null, null, null, null, null, 1)
     ,('代码集合', 'Collection_of_code', 'Collection_of_code', '001038', '公共信息', '多个代码', null, null, 400, '<=', null, null,
       null, null, null, null, 1)
     ,('客户统一编号', 'Customer_number', 'Customer_number', '2001.', '客户信息', '银行自定义的唯一识别客户的标识。供应链融资的填写供应链融资编码。', null, null,
       60, '<=', null, null, null, null, null, null, 1)
     ,('客户英文姓名', 'English_name_of_customer', 'English_name_of_customer', '2002.', '客户信息', '英文或拼音。', null, null, 200,
       '<=', null, null, null, null, null, null, 1)
     ,('证件类别', 'Document_type', 'Document_type', '2003.', '客户信息',
       '统一社会信用代码，组织机构代码，居民身份证，军官证，文职干部证，警官证，士兵证，户口簿，临时身份证，其他有效通行旅行证件，护照，学生证，无证件，其他。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('证件号码', 'Document_number', 'Document_number', '2004.', '客户信息', '证件号码。涉及个人身份证件时需按照本规范给定规则进行脱敏处理。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('来源系统', 'Source_system', 'Source_system', '2005.', '客户信息', '该客户信息源自的系统名称。', null, null, 100, '<=', null, null,
       null, null, null, null, 1)
     ,('国籍', 'Nationality', 'Nationality', '2006.', '客户信息', '参照《GB/T_2659-2000_世界各国和地区名称》。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('民族', 'Ethnicity', 'Ethnicity', '2007.', '客户信息', '国家认可的在公安户籍管理部门正式登记注册的客户所属民族的名称。', null, null, 30, '<=', null,
       null, null, null, null, null, 1)
     ,('性别', 'Gender', 'Gender', '2008.', '客户信息', '男，女，其他类型按银行自定义填写中文描述。', null, null, 10, '<=', null, null, null, null,
       null, null, 1)
     ,('学历', 'Education_degree', 'Education_degree', '2009.', '客户信息', '参照《GB/T_4658-2006_学历代码》填写中文描述或中文字典。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('职业', 'Career', 'Career', '2010.', '客户信息', '中文描述或中文字典，银行自定义。', null, null, 80, '<=', null, null, null, null,
       null, null, 1)
     ,('婚姻情况', 'Marriage', 'Marriage', '2011.', '客户信息', '未婚，已婚，初婚，再婚，复婚，丧偶，离异；
未说明的婚姻状况。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('上黑名单原因', 'Reason_of_on_black_list', 'Reason_of_on_black_list', '2012.', '客户信息', '中文字典或中文描述，银行自定义。', null, null,
       400, '<=', null, null, null, null, null, null, 1)
     ,('单位性质', 'Unit_property', 'Unit_property', '2013.', '客户信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('职称', 'Title', 'Title', '2014.', '客户信息', '参照《GB/T_8561-2001_专业技术职务代码》填写中文描述或中文字典。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('社会关系', 'Social_relationship', 'Social_relationship', '2015.', '客户信息', '对应个人客户与个人客户的关系，按各机构实际数据情况填写。', null,
       null, 60, '<=', null, null, null, null, null, null, 1)
     ,('法人代表', 'Legal_person', 'Legal_person', '2016.', '客户信息', '该对公客户法人代表。依照法律或者法人组织章程规定，代表法人行使职权的负责人姓名。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('营业执照号', 'Business_license_number', 'Business_license_number', '2017.', '客户信息',
       '已登记统一社会信用代码的，填18位统一社会信用代码；未登记统一社会信用代码的，按原有方式填写。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('经营范围', 'Business_scope', 'Business_scope', '2018.', '客户信息', '客户的经营范围。', null, null, 1000, '<=', null, null,
       null, null, null, null, 1)
     ,('所属行业', 'Industry', 'Industry', '2019.', '客户信息', '填报该客户所属行业的小类代码对应的行业。行业分类按《GB/T_4754_国民经济行业分类》执行。境外机构按“境外”填报。',
       null, null, 100, '<=', null, null, null, null, null, null, 1)
     ,('客户类别', 'Customer_type', 'Customer_type', '2020.', '客户信息', '银监会客户分类标准。对公，对私。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('贷款卡号', 'Loan_number', 'Loan_number', '2021.', '客户信息', '中国人民银行发放的企业贷款卡号码。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('国税证号', 'National_tax_number', 'National_tax_number', '2022.', '客户信息',
       '已登记统一社会信用代码的，填18位统一社会信用代码；未登记统一社会信用代码的，按原有方式填写。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('地税证号', 'Local_tax_number', 'Local_tax_number', '2023.', '客户信息',
       '已登记统一社会信用代码的，填18位统一社会信用代码；未登记统一社会信用代码的，按原有方式填写。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('信用评级结果', 'Credit_level_result_', 'Credit_level_result_', '2024.', '客户信息',
       '指银行内部对该集团的信用评级结果。银行对集团客户不进行信用评级的，不填报。', null, null, 200, '<=', null, null, null, null, null, null, 1)
     ,('传真号码', 'Fax', 'Fax', '2025.', '客户信息', '区号座机电话。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('人数', 'Number_of_people', 'Number_of_people', '2026.', '客户信息', '人。', null, null, 10, '<=', null, null, null,
       null, null, null, 1)
     ,('统一社会信用代码', 'Unified_social_credit_code', 'Unified_social_credit_code', '2027.', '客户信息',
       '已登记统一社会信用代码的，填18位统一社会信用代码；未登记统一社会信用代码的，填组织机构代码。境外金融机构、临时验资户类客户填写默认值0。', null, null, 40, '<=', null, null, null,
       null, null, null, 1)
     ,('关联人类别', 'Associated_person_type', 'Associated_person_type', '2028.', '客户信息', '对公，对私。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('关系类型', 'Relationship_type', 'Relationship_type', '2029.', '客户信息',
       '股东，上下游关系，共同出资组建企业关系，亲属关系，担保关系，实际控制人，共同受同一自然人控制，集团成员，法定代表人，董事长（理事长），监事长，总经理，财务主管，个人股东，其他关联关系。同一个人兼任或具有多重关联关系的，分别填报。',
       null, null, 300, '<=', null, null, null, null, null, null, 1)
     ,('柜员流水号', 'Serial_number_of_Teller', 'Serial_number_of_Teller', '2030.', '客户信息', '一个柜员当日所有交易的笔次顺序。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('账号', 'Account_number', 'Account_number', '3001.', '账户', '系统内最细一级的账号，无唯一性约束，不需要和序号、子序号等做拼接。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('总账会计科目编号', 'Subject_number_of_general_ledger_accounting', 'Subject_number_of_general_ledger_accounting',
       '3002.', '账户', '机构实际使用的总账会计科目编码。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('总账会计科目名称', 'Subject_name_of_general_ledger_accounting', 'Subject_name_of_general_ledger_accounting', '3003.',
       '账户', '机构实际使用的总账会计科目编码对应的名称。', null, null, 200, '<=', null, null, null, null, null, null, 1)
     ,('统计科目编号', 'Statistic_subject_number', 'Statistic_subject_number', '3004.', '账户', '对应相关人民银行统计科目编号。', null, null,
       20, '<=', null, null, null, null, null, null, 1)
     ,('统计科目名称', 'Statistic_subject_name', 'Statistic_subject_name', '3005.', '账户', '对应相关人民银行统计科目名称。', null, null, 120,
       '<=', null, null, null, null, null, null, 1)
     ,('明细科目编号', 'Subject_number_', 'Subject_number_', '3006.', '账户', '机构实际使用的明细科目编号。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('明细科目名称', 'Subject_name_', 'Subject_name_', '3007.', '账户', '机构实际使用的明细科目名称。', null, null, 300, '<=', null, null,
       null, null, null, null, 1)
     ,('总账会计科目级次', 'Subject_grade_of_general_ledger_accounting', 'Subject_grade_of_general_ledger_accounting', '3008.',
       '账户', '总账会计科目编号在科目结构中所对应的级次。', null, null, 2, '<=', null, null, null, null, null, null, 1)
     ,('总账会计科目类型', 'Subject_type_of_general_ledger_accounting', 'Subject_type_of_general_ledger_accounting', '3009.',
       '账户', '1资产，2负债，3所有者权益，4损益，5资产负债共同类，6表外，7其他', null, null, 2, '<=', null, null, null, null, null, null, 1)
     ,('借贷标志', 'D.C._flag', 'D.C._flag', '3010.', '账户', '借，贷，借贷并列。', null, null, 12, '<=', null, null, null, null, null,
       null, 1)
     ,('金额', 'Amount', 'Amount', '3011.', '账户', '元。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('余额', 'Balance', 'Balance', '3012.', '账户', '元。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('额度_', 'Limit', 'Limit', '3013.', '账户', '元。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('手续费', 'Commission', 'Commission', '3014.', '账户', '元。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('手续费率', 'Commission_rate', 'Commission_rate', '3015.', '账户', '百分比为单位，即1/100。', null, null, null, null, 6, 10,
       null, null, null, null, 1)
     ,('币种', 'Currency', 'Currency', '3016.', '账户', '遵循《GB/T_12406-2008_表示货币和资金的代码》的字母代码，如CNY。', null, null, null, null,
       null, null, null, null, null, null, 1)
     ,('归并口径', 'Merge_requirement', 'Merge_requirement', '3017.', '账户', '该会计科目或统计科目如何由明细科目计算的公式。', null, null, 2000,
       '<=', null, null, null, null, null, null, 1)
     ,('口径说明', 'Illustration', 'Illustration', '3018.', '账户', '该会计科目或统计科目如何由明细科目计算的文字说明，与归并口径不能同时为空。文字描述清晰，便于实际操作参考。',
       null, null, 2000, '<=', null, null, null, null, null, null, 1)
     ,('账户名称', 'Account_name', 'Account_name', '3019.', '账户', '账户归属者的名称。', null, null, 200, '<=', null, null, null,
       null, null, null, 1)
     ,('个人活期存款账户类型', 'Type_of_individual_current_deposit_account', 'Type_of_individual_current_deposit_account',
       '3020.', '账户', '个人存款账户的类别。I类户，II类户，III类户。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('分类账号类型', 'Type_of_account_number', 'Type_of_account_number', '3021.', '账户', '借记卡，存折，存单，其他。', null, null, 30,
       '<=', null, null, null, null, null, null, 1)
     ,('账户状态', 'Account_state', 'Account_state', '3022.', '账户', '中文描述，银行自定义，标识账户的状态，例如“正常”、“冻结”等。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('钞汇类别', 'Cash_or_remittance', 'Cash_or_remittance', '3023.', '账户', '人民币，钞，汇，可钞可汇等。', null, null, 12, '<=', null,
       null, null, null, null, null, 1)
     ,('个人定期存款账户类型', 'Type_of_individual_term_deposit_account', 'Type_of_individual_term_deposit_account', '3024.',
       '账户', '中文描述，银行自定义，通知存款，零存整取等除活期之外其他类型。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('存款期限', 'Deposit_term', 'Deposit_term', '3025.', '账户',
       '1天通知，7天通知，1个月，3个月，6个月，12个月，18个月，24个月，36个月，60个月，72个月，80个月，不固定，其他期限。', null, null, 20, '<=', null, null, null,
       null, null, null, 1)
     ,('对公活期存款账户类型', 'Type_of_corporation_current_deposit', 'Type_of_corporation_current_deposit', '3026.', '账户', '人民币：基本户，一般户，专用户，临时户，临时户（验资注册），临时户（验资增资），待核准账户，人民币保证金账户，同业存款账户，委贷基金账户。
外币：经常-结算户，经常-保税监管区结算户，经常-离岸户，经常-其他，资本-资本金户，资本-保税监管资本金户，资本-股本金户，资本-外债专户，资本-其他，外汇贷转存专户，外汇待核查户。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('利息', 'Interest', 'Interest', '3027.', '账户', '元。', null, null, null, null, 2, 10, null, null, null, null, 1)
     ,('利率', 'Interest_rate', 'Interest_rate', '3028.', '账户', '百分比为单位，即1/100，一般为年利。', null, null, null, null, 6, 10,
       null, null, null, null, 1)
     ,('对公定期存款账户类型', 'Type_of_corporation_time_deposit', 'Type_of_corporation_time_deposit', '3029.', '账户',
       '中文描述，银行自定义，通知存款，零存整取等除活期之外其他类型。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('内部分户账账户类型', 'Type_of_Internal_subsidiary_ledger_account', 'Type_of_Internal_subsidiary_ledger_account', '3030.',
       '账户', '中文描述，银行自定义。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('计息方式', 'Interest_method', 'Interest_method', '3031.', '账户', '利息的计算方法，按月结息，按季结息，按半年结息，按年结息，不定期结息，不记利息，利随本清等。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('借据号', 'Duebill_number', 'Duebill_number', '3032.', '账户', '借据统一编号。', null, null, 100, '<=', null, null, null,
       null, null, null, 1)
     ,('合同号', 'Contract_number', 'Contract_number', '3033.', '账户', '合同号。', null, null, 100, '<=', null, null, null,
       null, null, null, 1)
     ,('贷款五级分类', 'The_five_category_assets_classification_for_bank_loans',
       'The_five_category_assets_classification_for_bank_loans', '3034.', '账户', '正常，关注，次级，可疑，损失。', null, null, null,
       null, null, null, null, null, null, null, 1)
     ,('还款账号', 'Repay_number', 'Repay_number', '3035.', '账户', '用于扣划本金或利息的客户存款账号。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('会计周期', 'Accounting_cycle', 'Accounting_cycle', '3036.', '账户', '1日报，2月报，3季报，4半年报，5年报', null, null, 2, '<=', null,
       null, null, null, null, null, 1)
     ,('业务类型', 'Business_type', 'Business_type', '003037', '账户', '银行业务类型，内容同总账会计科目类型', null, null, 2, '<=', null, null,
       null, null, null, null, 1)
     ,('子业务类型', 'Sub_business_type', 'Sub_business_type', '003038', '账户', '资产类业务子类：1各项贷款，2投资，3拆借资金（拆出），4各项垫款，5各项准备金；负债类业务子类：6各项存款，7拆借资金（拆入），8发行债券；表外及其它业务类别：9担保（保函），10承兑票据，11委托贷款，12信用证，13理财业务，14交易，15利息收入，16中间业务收入。
填报科目归属的16类主要业务类别，主要类业务未覆盖的一级科目及其余科目为空。归属多个业务子类时使用英文半角分号隔开，按照数字代码报送。', null, null, 30, '<=', null, null, null, null,
       null, null, 1)
     ,('交易借贷标志', 'Debit_record_or_Credit__record_flag', 'Debit_record_or_Credit__record_flag', '003039', '账户', '借，贷。',
       null, null, 12, '<=', null, null, null, null, null, null, 1)
     ,('核心交易流水号', 'Serial_number_of_core_trading', 'Serial_number_of_core_trading', '4001.', '交易流水信息',
       '如核心交易流水号不能唯一识别，则加上日期。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('子交易流水号', 'Serial_number_of_sub_trading', 'Serial_number_of_sub_trading', '4002.', '交易流水信息', '子交易流水号，或分录交易流水号。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('笔次序号', 'Serial_number_of_trading', 'Serial_number_of_trading', '4003.', '交易流水信息', '笔次序号。批量业务执行时的执行序号。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('凭证号', 'Voucher_number', 'Voucher_number', '4004.', '交易流水信息', '凭证号。', null, null, 60, '<=', null, null, null,
       null, null, null, 1)
     ,('交易类型', 'Trading_type', 'Trading_type', '4005.', '交易流水信息', '交易代码对应的中文描述，银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('交易渠道', 'Trading_channel', 'Trading_channel', '4006.', '交易流水信息', '柜面，ATM，VTM，POS，网银，手机银行，其他。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('交易介质名称', 'Trading_media_name', 'Trading_media_name', '4007.', '交易流水信息', '卡，折，单，其他。', null, null, 6, '<=', null,
       null, null, null, null, null, 1)
     ,('交易介质号', 'Trading_media_number', 'Trading_media_number', '4008.', '交易流水信息', '卡、折、单及其他对应介质号码', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('现转标志', 'Cash_or_transfer', 'Cash_or_transfer', '4009.', '交易流水信息', '现，转。', null, null, 4, '<=', null, null, null,
       null, null, null, 1)
     ,('摘要', 'Memo', 'Memo', '4010.', '交易流水信息', '交易内容的中文简要描述。', null, null, 400, '<=', null, null, null, null, null,
       null, 1)
     ,('冲补抹标志', 'Regular,_strike,_mend', 'Regular,_strike,_mend', '4011.', '交易流水信息', '正常，冲账，补账，抹账。', null, null, 10,
       '<=', null, null, null, null, null, null, 1)
     ,('交易系统名称', 'Trading_system_name', 'Trading_system_name', '4012.', '交易流水信息', '中文描述或中文字典，银行自定义。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('业务类型', 'Business_type', 'Business_type', '4013.', '交易流水信息', '中文描述，以银行电子字典定义为准。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('凭证种类', 'Voucher_type', 'Voucher_type', '4014.', '交易流水信息', '中文描述或中文字典，银行自定义。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('账户标志', 'Corporation_or_individual', 'Corporation_or_individual', '4015.', '交易流水信息', '对公，对私，内部。', null, null,
       null, null, null, null, null, null, null, null, 1)
     ,('开销户标志', 'Open_or_close', 'Open_or_close', '4016.', '交易流水信息', '开户，销户。', null, null, null, null, null, null, null,
       null, null, null, 1)
     ,('产品名称', 'Product_name', 'Product_name', '5001.', '授信交易对手信息', '银行内部产品中文名称，银行自定义。', null, null, 200, '<=', null,
       null, null, null, null, null, 1)
     ,('贷款新规种类', 'Loan_type_(New)', 'Loan_type_(New)', '5002.', '授信交易对手信息', '按三办法一指引分类，个贷，固贷和流贷。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('信贷业务种类', 'Loan_business_type', 'Loan_business_type', '5003.', '授信交易对手信息',
       '填报该笔贷款所属的业务类型。流动资金贷款，项目贷款，一般固定资产贷款（除项目贷款外的固定资产贷款），住房贷款，商用房贷款，公积金贷款，汽车贷款，助学贷款，消费贷款，个人经营性贷款，农户贷款，其他贷款。', null,
       null, 100, '<=', null, null, null, null, null, null, 1)
     ,('利率浮动', 'Rate_float', 'Rate_float', '5004.', '授信交易对手信息', '基准点为单位。', null, null, 10, '<=', null, null, null, null,
       null, null, 1)
     ,('主要担保方式', 'Main_guarantee_way', 'Main_guarantee_way', '5005.', '授信交易对手信息', '质押（含保证金），抵押，保证，信用，其他。', null, null,
       60, '<=', null, null, null, null, null, null, 1)
     ,('放款方式', 'Distribute_way', 'Distribute_way', '5006.', '授信交易对手信息', '自主支付，受托支付，混合支付。', null, null, null, null, null,
       null, null, null, null, null, 1)
     ,('资金来源', 'Capital_source', 'Capital_source', '5007.', '授信交易对手信息', '中文字典或中文描述，银行自定义。', null, null, 100, '<=', null,
       null, null, null, null, null, 1)
     ,('贷款用途', 'Loan_purpose', 'Loan_purpose', '5008.', '授信交易对手信息', '贷款使用的具体内容。', null, null, 400, '<=', null, null,
       null, null, null, null, 1)
     ,('贷款投向行业', 'Invest_industry', 'Invest_industry', '5009.', '授信交易对手信息',
       '依据《GB/T_4754_国民经济行业分类》填报该笔贷款投向行业的代码。详细填报至小类。贴现、流动资金贷款、表外形成的垫款等无法确定实际投向的，按照客户主营业务所属行业填报。投向境外的贷款按“境外”填报。', null,
       null, 100, '<=', null, null, null, null, null, null, 1)
     ,('项目名称', 'Project_name', 'Project_name', '5010.', '授信交易对手信息', '项目贷款名称。', null, null, 100, '<=', null, null, null,
       null, null, null, 1)
     ,('项目类型', 'Project_type', 'Project_type', '5011.', '授信交易对手信息',
       '中文描述，以项目融资指引为准，建造一个或一组大型生产装置、基础设施、房地产项目或其他项目，包括对在建或已建项目的再融资。', null, null, 100, '<=', null, null, null, null,
       null, null, 1)
     ,('项目贷款期限', 'Term_of_project_loan', 'Term_of_project_loan', '5012.', '授信交易对手信息', '借款合同约定起止期限。YYYYMMDD-YYYYMMDD。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('批文文号', 'Approval_number', 'Approval_number', '5013.', '授信交易对手信息', '银行自定义。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('立项批文', 'Project_approval', 'Project_approval', '5014.', '授信交易对手信息', '批文名称，可银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('规划许可证编号', 'Plan_permit_number', 'Plan_permit_number', '5015.', '授信交易对手信息', '银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('建设用地许可证编号', 'Construction_land_permit_number', 'Construction_land_permit_number', '5016.', '授信交易对手信息', '银行自定义。',
       null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('环评许可证编号', 'Environmental_assessment_permit_number', 'Environmental_assessment_permit_number', '5017.',
       '授信交易对手信息', '银行自定义。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('施工许可证编号', 'Builder''s_permit_number', 'Builder''s_permit_number', '5018.', '授信交易对手信息', '银行自定义。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('其他许可证', 'Other_permit_', 'Other_permit_', '5019.', '授信交易对手信息', '银行自定义。', null, null, 60, '<=', null, null, null,
       null, null, null, 1)
     ,('其他许可证编号', 'Other_permit_number', 'Other_permit_number', '5020.', '授信交易对手信息', '银行自定义。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('票据号码', 'Bill_number', 'Bill_number', '5021.', '授信交易对手信息', '票据号码。', null, null, 60, '<=', null, null, null, null,
       null, null, 1)
     ,('出票人编号', 'Drawer_number', 'Drawer_number', '5022.', '授信交易对手信息', '出票人客户编号。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('付款行代码', 'Paying_bank_number', 'Paying_bank_number', '5023.', '授信交易对手信息', '付款行银行机构代码。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('票据类型', 'Bill_type', 'Bill_type', '5024.', '授信交易对手信息', '银行承兑汇票，商业承兑汇票。', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('出票人账号', 'Drawer_account', 'Drawer_account', '5025.', '授信交易对手信息', '出票人账号。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('保函业务品种', 'Guarantee_business_type', 'Guarantee_business_type', '5026.', '授信交易对手信息',
       '融资性保函，借款偿还保函，租金偿还保函，透支归还保函，关税保付保函，补偿贸易保函，付款保函，其他融资性保函，非融资性保函，投标保函，_履约保函，预付款保函，承包工程保函，质量维修保函，海事保函，补偿贸易保函，诉讼保函，留置金保函，加工装配业务进口保函，其他非融资性保函。',
       null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('贸易融资品种', 'Trade_financing_(TF)_type', 'Trade_financing_(TF)_type', '5027.', '授信交易对手信息',
       '出口合同打包贷款，出口信用证打包贷款，出口信用证押汇，出口信用证押汇（离岸），出口信用证贴现，出口信用证贴现（离岸），出口托收押汇，出口托收押汇（OTS），出口托收贴现，出口托收贴现（OTS），出口商业发票融资，福费廷，福费廷（离岸），货到付款押汇，进口信用证押汇，进口代收押汇，提货担保，提货担保（OTS），备用信用证，备用信用证（OTS），进口信用证，进口信用证（OTS），保理，保兑仓，进口代付，打包贷款，议付/卖方融资，买方融资，国内保理，发票融资，商品融资，其他。',
       null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('银行国际业务编号', 'International_business_number', 'International_business_number', '5028.', '授信交易对手信息',
       '国结系统产生或根据一定的含义手工编写的业务编号。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('商业发票号码', 'Invoice_number', 'Invoice_number', '5029.', '授信交易对手信息', '业务对应的保函信用证等的号码。', null, null, 200, '<=',
       null, null, null, null, null, null, 1)
     ,('商业发票种类', 'Invoice_type', 'Invoice_type', '5030.', '授信交易对手信息',
       '银行自定义，例如：商业发票，详细发票，证实发票，收妥发票，厂商发票，形式发票，样品发票，领事发票，寄售发票，海关发票', null, null, 60, '<=', null, null, null, null, null,
       null, 1)
     ,('福费廷种类', 'Forfaiting_type', 'Forfaiting_type', '5031.', '授信交易对手信息', '自营，转卖。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('信用证编号', 'LC_number', 'LC_number', '5032.', '授信交易对手信息', '信用证编号。', null, null, 30, '<=', null, null, null, null,
       null, null, 1)
     ,('信用证期限类型', 'LC_term_type', 'LC_term_type', '5033.', '授信交易对手信息', '即期信用证，远期信用证，假远期信用证。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('协议类型', 'Agreement_type', 'Agreement_type', '5034.', '授信交易对手信息', '中文描述或中文字典，银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('代理参贷标志', 'Agent_loan_sign', 'Agent_loan_sign', '5035.', '授信交易对手信息', '中文描述或中文字典，银行自定义。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('协议状态', 'Agreement_state', 'Agreement_state', '5036.', '授信交易对手信息', '中文描述或中文字典，银行自定义。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('手续费方式', 'Way_of_submit_commission', 'Way_of_submit_commission', '5037.', '授信交易对手信息', '中文描述或中文字典，银行自定义。', null,
       null, 60, '<=', null, null, null, null, null, null, 1)
     ,('贷款期限', 'Loan_term', 'Loan_term', '5038.', '授信交易对手信息', '实际到期日减去起始日，按天表示。', null, null, 20, '=', null, null, null,
       null, null, null, 1)
     ,('展期次数', 'Times_of_loan_extension', 'Times_of_loan_extension', '5039.', '授信交易对手信息', '贷款展期次数，未展期为0。', null, null,
       4, '<=', null, null, null, null, null, null, 1)
     ,('期数', 'Number_of_terms', 'Number_of_terms', '5040.', '授信交易对手信息', '期数。', null, null, 4, '<=', null, null, null,
       null, null, null, 1)
     ,('贷款状态', 'Loan_state', 'Loan_state', '5041.', '授信交易对手信息', '中文字典或中文描述，银行自定义。', null, null, 100, '<=', null, null,
       null, null, null, null, 1)
     ,('贷款类型', 'Loan_type', 'Loan_type', '5042.', '授信交易对手信息', '贷款，贴现，贸易融资，垫款，法人账户透支，其他。', null, null, 100, '<=', null,
       null, null, null, null, null, 1)
     ,('还款方式', 'Repayment_way', 'Repayment_way', '5043.', '授信交易对手信息', '按月，按季，按半年，按年，利随本清，分期付息一次还本，其他。', null, null, 40,
       '<=', null, null, null, null, null, null, 1)
     ,('还款渠道', 'Repay_channel', 'Repay_channel', '5044.', '授信交易对手信息', '中文字典或中文描述，银行自定义。', null, null, 100, '<=', null,
       null, null, null, null, null, 1)
     ,('担保类型', 'Guarantee_type', 'Guarantee_type', '5045.', '授信交易对手信息', '担保合同的担保方式。抵押，质押，单人保证，多人保证，多人联保，多人分保。其中：
单人保证是指（一个或多个）保证人分别签订一份保证合同为借款人作担保，每份保证合同确定每个人应承担的实际担保金额。借款人被担保的金额为上述保证合同金额的合计数。
多人保证指多个保证人分别为一个借款人签订独立的保证合同，每个保证人都承担相同的保证合同中签订的总担保金额。
多人联保是指多人共同签订一份保证合同为借款人作担保，并且规定每个保证人都承担相同的保证合同中签订的总担保金额。
多人分保是指多人共同签订一份保证合同为借款人作担保', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('担保合同类型', 'Guarantee_contract_type', 'Guarantee_contract_type', '5046.', '授信交易对手信息', '一般担保合同，最高额担保合同。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('担保状态', 'Guarantee_state', 'Guarantee_state', '5047.', '授信交易对手信息', '正常，解除，其他。', null, null, null, null, null,
       null, null, null, null, null, 1)
     ,('保证人类别', 'Guarantor_type', 'Guarantor_type', '5048.', '授信交易对手信息', '对公，对私。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('担保合同状态', 'Guarantee_contract_state', 'Guarantee_contract_state', '5049.', '授信交易对手信息', '未签合同，已签合同，已失效。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('担保物品顺序', 'Guarantee_goods_number', 'Guarantee_goods_number', '5050.', '授信交易对手信息', '既求偿权顺序，中文字典或中文描述，银行自定义。',
       null, null, 1000, '<=', null, null, null, null, null, null, 1)
     ,('质或抵押物编号', 'Pledge_or_collateral_number', 'Pledge_or_collateral_number', '5051.', '授信交易对手信息',
       '因信贷业务而成为质或抵押物的编号。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('质或抵押物名称', 'Pledge_or_collateral_name', 'Pledge_or_collateral_name', '5052.', '授信交易对手信息', '因信贷业务而成为质或抵押物的名称。',
       null, null, 1000, '<=', null, null, null, null, null, null, 1)
     ,('质或抵押物类型', 'Pledge_or_collateral_type', 'Pledge_or_collateral_type', '5053.', '授信交易对手信息',
       '填报该宗押品的类型。押品分类见《押品分类编码表》。例如，以国债质押的，押品类型应填报为国债。保证人不填报该项指标。', null, null, 300, '<=', null, null, null, null, null,
       null, 1)
     ,('质押票证账号', 'Impawn_bill_account', 'Impawn_bill_account', '5054.', '授信交易对手信息', '质押票证账号。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('质押票证类型', 'Impawn_bill_type', 'Impawn_bill_type', '5055.', '授信交易对手信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('质押票证号码', 'Impawn_bill_number', 'Impawn_bill_number', '5056.', '授信交易对手信息', '质押票证号码。', null, null, 300, '<=',
       null, null, null, null, null, null, 1)
     ,('保险单号', 'Insurance_policy_number', 'Insurance_policy_number', '5057.', '授信交易对手信息', '该物品保险单号。', null, null, 300,
       '<=', null, null, null, null, null, null, 1)
     ,('权证登记号码', 'Prop_certification_register_number', 'Prop_certification_register_number', '5058.', '授信交易对手信息',
       '银行自定义。', null, null, 300, '<=', null, null, null, null, null, null, 1)
     ,('委托账号类型', 'Type_of_entrust_account', 'Type_of_entrust_account', '5059.', '授信交易对手信息', '委托基金，委托存款，其他。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('登记机构', 'Register_organization', 'Register_organization', '5060.', '授信交易对手信息', '抵质押物的登记机关，如工商所、公证处等机构。', null,
       null, 200, '<=', null, null, null, null, null, null, 1)
     ,('是否国家限制行业', 'Limited_industry', 'Limited_industry', '5061.', '授信交易对手信息',
       '根据国家发改委发布的《产业结构调整指导目录》判断该笔贷款实际投向是否属于国家限制行业。《产业结构调整指导目录》包括鼓励、限制、淘汰三个类别，属于后两类视为国家限制行业；对于流动资金贷款、贴现、垫款等无法区分实际投向的贷款，按照客户主营业务判断。银行可以通过国家发改委官方网站下载该目录的最新版本，今后如遇更新则按照新版本执行。是，否标志。',
       null, null, 4, '<=', null, null, null, null, null, null, 1)
     ,('贷款投向地区', 'Loan_investment_area', 'Loan_investment_area', '5062.', '授信交易对手信息',
       '境内地区参照《GB/T_2260_中华人民共和国行政区划代码》填写国内行政区划名称，精确到地市级；境外地区参照《GB/T_2659-2000_世界各国和地区名称》填写国名或地区名称。', null, null, 200,
       '<=', null, null, null, null, null, null, 1)
     ,('表外业务品种', 'External_business_category', 'External_business_category', '5063.', '授信交易对手信息',
       '银行自定义。例如：信用证，承兑汇票，保函，承诺，委托贷款，他行代办等等。', null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('卡号', 'Card_number_', 'Card_number_', '6001.', '卡片信息', '卡号，可以是借记卡号，贷记卡号等。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('借记卡产品名称', 'Debit_card_name', 'Debit_card_name', '6002.', '卡片信息', '借记卡产品名称，中文字典或中文描述，银行自定义。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('卡片状态', 'Card_state', 'Card_state', '6003.', '卡片信息', '正常，冻结，注销，未激活，睡眠，其他。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('存折类型', 'Passbook_type', 'Passbook_type', '6004.', '卡片信息', '普通存折，存单，一本通，大额定期存单，其他。', null, null, 20, '<=', null,
       null, null, null, null, null, 1)
     ,('存折状态', 'Passbook_state', 'Passbook_state', '6005.', '卡片信息', '正常，冻结，注销，睡眠，未激活，其他。', null, null, 30, '<=', null,
       null, null, null, null, null, 1)
     ,('卡片名称', 'Card_name', 'Card_name', '6006.', '卡片信息', '信用卡片种类名称。', null, null, 60, '<=', null, null, null, null,
       null, null, 1)
     ,('卡片级别', 'Card_level', 'Card_level', '6007.', '卡片信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null, null,
       null, null, null, 1)
     ,('账户状态', 'Account_state', 'Account_state', '6008.', '卡片信息', '未启用，正常，冻结，注销，作废，挂失，其他', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('担保说明', 'Guarantee_illustration', 'Guarantee_illustration', '6009.', '卡片信息', '中文字典或中文描述，银行自定义。', null, null, 400,
       '<=', null, null, null, null, null, null, 1)
     ,('欠款归还次序', 'Payment_order', 'Payment_order', '6010.', '卡片信息', '只适用于支取类交易，在存款交易时判断还款次序。费用入账，透支结息入账，取现/转账支取，消费入账。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('分期付款标志', 'Installment_flag', 'Installment_flag', '6011.', '卡片信息', '未分期，被分期，子分期入账。', null, null, 15, '<=', null,
       null, null, null, null, null, 1)
     ,('工作站性质', 'Workstation_type', 'Workstation_type', '6012.', '卡片信息', '柜员工作站，ATM，VTM，多媒体自助终端，自动补登折机，POS。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('工作站编号', 'Workstation_number', 'Workstation_number', '6013.', '卡片信息', '工作站编号。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('记录状态', 'Record_state', 'Record_state', '6014.', '卡片信息', '正常，删除。', null, null, null, null, null, null, null,
       null, null, null, 1)
     ,('授信协议号', 'Credit_agreement_number', 'Credit_agreement_number', '7001.', '信贷管理信息',
       '填报银行授予客户授信额度的授信号码（或授信合同号码），该号码唯一标识该笔授信。若银行对该客户有多笔授信，应逐笔填列。“未纳入授信业务”栏的授信号码按“WNRSXYW”填报。', null, null, 60, '<=',
       null, null, null, null, null, null, 1)
     ,('授信种类', 'Credit_type', 'Credit_type', '7002.', '信贷管理信息', '单一法人授信，集团客户授信，供应链融资，个人客户授信，同业客户授信，其他。', null, null, 30,
       '<=', null, null, null, null, null, null, 1)
     ,('有效状态', 'Validity_status', 'Validity_status', '7004.', '信贷管理信息', '有效，无效。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('决策单意见', 'Decision', 'Decision', '7005.', '信贷管理信息', '银行自定义。', null, null, 2000, '<=', null, null, null, null,
       null, null, 1)
     ,('最终审批人', 'Final_approver', 'Final_approver', '7006.', '信贷管理信息', '审批人工号或姓名。', null, null, 30, '<=', null, null,
       null, null, null, null, 1)
     ,('贷款核销编号', 'Write_off_number', 'Write_off_number', '7007.', '信贷管理信息', '贷款核销编号。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('备注', 'Remark', 'Remark', '7008.', '信贷管理信息', '银行自定义。', null, null, 200, '<=', null, null, null, null, null, null,
       1)
     ,('贷款展期编号', 'Number_of_loan_extension', 'Number_of_loan_extension', '7009.', '信贷管理信息', '贷款展期编号。', null, null, 60,
       '<=', null, null, null, null, null, null, 1)
     ,('信贷交易类型', 'Credit_trading_type', 'Credit_trading_type', '7010.', '信贷管理信息', '买断，卖断，买入返售，卖出回购。', null, null, 12,
       '<=', null, null, null, null, null, null, 1)
     ,('交易资产类型', 'Trading_asset_type', 'Trading_asset_type', '7011.', '信贷管理信息', '贷款，票据，其他。', null, null, 30, '<=', null,
       null, null, null, null, null, 1)
     ,('变动方式', 'Variation_way', 'Variation_way', '7012.', '信贷管理信息', '人工，自动。', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('发生类型', 'Happen_type', 'Happen_type', '7013.', '信贷管理信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null, null,
       null, null, null, null, 1)
     ,('业务品种', 'Business_type', 'Business_type', '7014.', '信贷管理信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('检查地点', 'Examination_address', 'Examination_address', '7015.', '信贷管理信息', '检查地点，中文描述，银行自定义。', null, null, 400,
       '<=', null, null, null, null, null, null, 1)
     ,('检查内容', 'Examination_content', 'Examination_content', '7016.', '信贷管理信息', '检查内容，中文描述，银行自定义。', null, null, 400,
       '<=', null, null, null, null, null, null, 1)
     ,('项目资金总体评价', 'Evaluation_of_project_capital', 'Evaluation_of_project_capital', '7017.', '信贷管理信息', '银行自定义。', null,
       null, 400, '<=', null, null, null, null, null, null, 1)
     ,('项目建设情况评价', 'Evaluation_of_construction', 'Evaluation_of_construction', '7018.', '信贷管理信息', '银行自定义。', null, null,
       400, '<=', null, null, null, null, null, null, 1)
     ,('项目销售情况', 'Marketing_condition', 'Marketing_condition', '7019.', '信贷管理信息', '银行自定义。', null, null, 400, '<=', null,
       null, null, null, null, null, 1)
     ,('协议名称', 'Agreement_name', 'Agreement_name', '7020.', '信贷管理信息', '银行自定义。', null, null, 400, '<=', null, null, null,
       null, null, null, 1)
     ,('变动原因', 'Happen_reason', 'Happen_reason', '7021.', '信贷管理信息', '中文字典或中文描述，银行自定义。', null, null, 60, '<=', null,
       null, null, null, null, null, 1)
     ,('期限类型', 'Term_type', 'Term_type', '8001.', '资产负债及涉农统计', '天，周，旬，月，季，半年，年。', null, null, 6, '<=', null, null, null,
       null, null, null, 1)
     ,('客户类型', 'Customer_type', 'Customer_type', '009001', '客户风险统计相关指标',
       '集团客户，单一法人客户，同业客户。同业客户的范围与银监会非现场监管统计一致。银行对企业分公司等非法人机构授信的，视同单一法人客户填报。', null, null, 12, '<=', null, null, null,
       null, null, null, 1)
     ,('账户类型', 'Account_type', 'Account_type', '009017', '客户风险统计相关指标', '银行账户，交易账户。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('风险预警信号', 'Risk_warning_signal', 'Risk_warning_signal', '009022', '客户风险统计相关指标',
       '银行机构对集团客户的风险状况作出独立的职业判断，并填报风险类别代码。同一集团涉及多项预警的，应将多个代码一并填报。集团风险预警代码、信号及预警事项见《集团风险预警代码及预警信号对照表》。', null, null, 200,
       '<=', null, null, null, null, null, null, 1)
     ,('行政区划代码', 'District_code', 'District_code', '009024', '客户风险统计相关指标',
       '与个人住址或法人注册地对应的行政区划代码，按照《GB/T_2260_中华人民共和国行政区划代码》的6位编码填报。集团母公司为境外企业的，填报为“999999”。', null, null, 20, '<=', null,
       null, null, null, null, null, 1)
     ,('主要担保类型', 'Main_guarantee_type', 'Main_guarantee_type', '009037', '客户风险统计相关指标', '质押，抵押，保证，信用。', null, null, null,
       null, null, null, null, null, null, null, 1)
     ,('金融工具编号', 'Instrument_Code', 'Instrument_Code', '10001.', '资金与理财业务',
       '金融产品在中登公司记录的正确编号，包括但不限于标准化或非标准化金融产品。如果不是标准产品，则由银行自定义。', null, null, 60, '<=', null, null, null, null, null,
       null, 1)
     ,('金融工具名称', 'Instrument', 'Instrument', '10002.', '资金与理财业务', '金融产品名称，包括但不限于标准化或非标准化金融产品。如果不是标准产品，则由银行自定义。', null,
       null, 60, '<=', null, null, null, null, null, null, 1)
     ,('资产类型', 'Asset_type', 'Asset_type', '10003.', '资金与理财业务',
       '现金及银行存款，货币市场工具，债券，理财直接融资工具，新增可投资资产（信贷资产流转项目、其他新增），非标准化债权类资产，权益类投资，金融衍生品，QDII，商品类资产，另类资产（艺术品、知识产权等），公募基金，私募基金。',
       null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('资金交易类型', 'Trade_type', 'Trade_type', '10004.', '资金与理财业务', '自营，代客。', null, null, null, null, null, null, null,
       null, null, null, 1)
     ,('资金交易子类', 'Trade_sub-type', 'Trade_sub-type', '10005.', '资金与理财业务',
       '买入，远期买入，远期卖出，卖出，外汇买卖，期权创设，同业借款，质押式正回购，质押式逆回购，买断式正回购，买断式逆回购，拆入，拆出，外汇互换，货币互换，利率互换支付固定利率，利率互换支付浮动利率，利率远期支付固定利率，利率远期支付浮动利率，承销，分销买入，分销卖出，同业代付，同业存入，同业存出，协议存入，协议存出，债券借贷－借入，债券借贷－借出，现金支付，现金收取，交易终止，其他（银行自定义）。',
       null, null, 60, '<=', null, null, null, null, null, null, 1)
     ,('国别代码', 'Country_code', 'Country_code', '10006.', '资金与理财业务', '《GB/T_2659_世界各国和地区名称代码》定义的两字符代码，如CN，US。', null,
       null, null, null, null, null, null, null, null, null, 1)
     ,('息票类型', 'Coupon_type', 'Coupon_type', '10007.', '资金与理财业务', '零息，定息，浮息。', null, null, null, null, null, null, null,
       null, null, null, 1)
     ,('交易状态', 'Trade_status', 'Trade_status', '10008.', '资金与理财业务', '部分成交，成交确认，部分撤单，撤单，交易执行中，交易终止。', null, null, 20,
       '<=', null, null, null, null, null, null, 1)
     ,('交易编号', 'Trade_id', 'Trade_id', '10009.', '资金与理财业务', '识别交易的唯一编号，可以是合同号、成交编号或者其他自定义的编号。', null, null, 40, '<=',
       null, null, null, null, null, null, 1)
     ,('利率类型', 'Interest_type', 'Interest_type', '10010.', '资金与理财业务', '固定，浮动。', null, null, null, null, null, null,
       null, null, null, null, 1)
     ,('产品代码', 'Product_code', 'Product_code', '10011.', '资金与理财业务', '产品的唯一编号', null, null, 30, '<=', null, null, null,
       null, null, null, 1)
     ,('汇率', 'FX_Rate', 'FX_Rate', '10012.', '资金与理财业务', '外汇汇率，以当天央行（外管局）公布汇率为准。', null, null, null, null, 6, 10, null,
       null, null, null, 1)
     ,('买卖标志', 'Buy_or_sell', 'Buy_or_sell', '10013.', '资金与理财业务', '买入，卖出。', null, null, null, null, null, null, null,
       null, null, null, 1)
     ,('即远期标志', 'Spot/forward_flag', 'Spot/forward_flag', '10014.', '资金与理财业务', '即期，远期。', null, null, null, null, null,
       null, null, null, null, null, 1)
     ,('评级', 'Rating', 'Rating', '10015.', '资金与理财业务', '填报外部评级机构的评级结果。多家机构给予不同评级的，填报最低评级结果。', null, null, 20, '<=', null,
       null, null, null, null, null, 1)
     ,('期限', 'Term', 'Term', '10017.', '资金与理财业务', '约定的期限，适用于债券等业务。', null, null, 30, '<=', null, null, null, null, null,
       null, 1)
     ,('系统名', 'System_name', 'System_name', '10018.', '资金与理财业务', '信息系统名称', null, null, 100, '<=', null, null, null,
       null, null, null, 1)
     ,('产品登记编码', 'Product_registration_code', 'Product_registration_code', '10019.', '资金与理财业务',
       '登记机构赋予理财产品的标识码，该码具有唯一性。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('行内标识码', 'Product_inner_code', 'Product_inner_code', '10020.', '资金与理财业务', '发行机构在申报登记时赋予理财产品的代码，该代码在发行机构内部具有唯一性。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('产品品牌', 'Product_brand', 'Product_brand', '10021.', '资金与理财业务', '理财产品的标记，用以和其他竞争产品相区别的名称，具有自我宣传的作用。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('资金投向地区', 'Domestic/foreign_investing_flag', 'Domestic/foreign_investing_flag', '10022.', '资金与理财业务',
       '境内，境外，境内和境外。', null, null, 15, '<=', null, null, null, null, null, null, 1)
     ,('投资者类型', 'Investor_type', 'Investor_type', '10023.', '资金与理财业务', '私人银行专属，机构专属，个人，银行同业。', null, null, 30, '<=',
       null, null, null, null, null, null, 1)
     ,('理财产品收益特征', 'Financing_product_reward_characteristics', 'Financing_product_reward_characteristics', '10024.',
       '资金与理财业务', '保证收益类，保本浮动收益类，非保本浮动收益类。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('理财产品风险等级', 'Financing_product_risk_level', 'Financing_product_risk_level', '10025.', '资金与理财业务',
       '一级，二级，三级，四级，五级。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('申购赎回标志', 'Subscription/redemption_flag', 'Subscription/redemption_flag', '10026.', '资金与理财业务', '申购，赎回。', null,
       null, null, null, null, null, null, null, null, null, 1)
     ,('理财业务服务模式', 'Financing_service_mode', 'Financing_service_mode', '10027.', '资金与理财业务', '综合理财服务，理财顾问服务，其他。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('产品运作模式', 'Product_operation_mode', 'Product_operation_mode', '10028.', '资金与理财业务',
       '封闭式净值型，封闭式非净值型，开放式净值型，开放式非净值型。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('会计核算方式', 'On/off_sheet_flag', 'On/off_sheet_flag', '10029.', '资金与理财业务', '表内，表外。', null, null, null, null, null,
       null, null, null, null, null, 1)
     ,('产品资产配置方式', 'Product_asset_management', 'Product_asset_management', '10030.', '资金与理财业务', '单一资产配置，资产组合配置，资产池配置。',
       null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('产品管理模式', 'Product_manager_type', 'Product_manager_type', '10031.', '资金与理财业务', 'SPV，银行，资产管理公司，其他机构。', null, null,
       30, '<=', null, null, null, null, null, null, 1)
     ,('产品定价方式', 'Product_pricing_method', 'Product_pricing_method', '10032.', '资金与理财业务', '公允价值定价，成本法定价，综合定价。', null,
       null, 30, '<=', null, null, null, null, null, null, 1)
     ,('投资类型', 'Investment_type', 'Investment_type', '10033.', '资金与理财业务',
       '结构性理财产品，货币市场工具类，债券类，非标准化债权类，基金股票类，股权类，另类投资类，混合类，代客境外理财产品。', null, null, 30, '<=', null, null, null, null, null,
       null, 1)
     ,('合作模式', 'Cooperation_mode', 'Cooperation_mode', '10034.', '资金与理财业务', '独立运作，银信，银保，银基，银证，混合类，其他。', null, null, 30,
       '<=', null, null, null, null, null, null, 1)
     ,('投资资产种类及比例', 'Investment_structure', 'Investment_structure', '10035.', '资金与理财业务', '银行自定义。例如：现金、存款、回购，占比5%', null,
       null, 2000, '<=', null, null, null, null, null, null, 1)
     ,('投资者风险偏好', 'Investor_risk_appetite', 'Investor_risk_appetite', '10036.', '资金与理财业务', '保守型，稳健型，平衡型，成长型，进取型。', null,
       null, null, null, null, null, null, null, null, null, 1)
     ,('产品销售区域', 'Product_sales_territory', 'Product_sales_territory', '10037.', '资金与理财业务', '填写我国省市自治区名称中的一个或多个。', null,
       null, 2000, '<=', null, null, null, null, null, null, 1)
     ,('产品增信机构类型', 'Organization_type_to_enhance_product_credit', 'Organization_type_to_enhance_product_credit',
       '10038.', '资金与理财业务', '广义政府，非金融性公司，金融性公司，住户部门，国外部门。', null, null, 30, '<=', null, null, null, null, null, null, 1)
     ,('产品增信形式', 'Product_credit_enhancement_class', 'Product_credit_enhancement_class', '10039.', '资金与理财业务',
       '内部增级，外部增级，内外增级。', null, null, null, null, null, null, null, null, null, null, 1)
     ,('到账日', 'Days_of_settlement', 'Days_of_settlement', '10040.', '资金与理财业务', 'T+N（N为数字）', null, null, 4, '<=', null,
       null, null, null, null, null, 1)
     ,('基准利率', 'Benchmark_Interest_rate', 'Benchmark_Interest_rate', '10041.', '资金与理财业务', '百分比为单位，即1/100，一般为年利。', null,
       null, null, null, 6, 10, null, null, null, null, 1)
     ,('成交价格', 'Distal_Interest_rate', 'Distal_Interest_rate', '10042.', '资金与理财业务', '数字加单位表示，如10万元或1.5%。', null, null,
       100, '<=', null, null, null, null, null, null, 1)
     ,('增信方式', 'Measures_of_credit_enhancement', 'Measures_of_credit_enhancement', '10043.', '资金与理财业务',
       '银行自定义。例如：保证担保，抵押，存单质押，保证金质押，股权质押，其他权利质押，银行保函，银行远期购买，银行担保，银行承兑，其他。', null, null, 30, '<=', null, null, null,
       null, null, null, 1);
insert into assets_standard_preset_standard (standard_name_cn, standard_name, standard_name_abbreviation,
                                             standard_number, catalog, business_definition, custom_attribute,
                                             data_type_id, data_length, data_length_operator, post_precision,
                                             pre_precision, nullable, repeatable, default_value, value_range,
                                             template_id)
values ('统一社会信用代码', 'Unified_Social_Credit_Identifier', 'USCI', '1218', '参与方', '按照GB_32100—2015规定，赋予每一个法人和其他组织在全国范围内唯一的，终身不变的18
位法定身份识别码。',
        '{"1":{"IMIX域名":"PartySubID(JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件_“SubGrp”描述机构实体详细信息，统一社会信用代码则由“SubGrp”组件中的Type域和ID域组合表示)"}}',
        null, null, null, null, null, null, null, null, null, 2)
     ,('法人机构识别编码', 'Legal_Entity_Identifier', 'Legal_Entity_Identifier', '1217', '参与方',
       '法人机构识别编码是按照ISO17442:2012规定，为法人机构分配的由20位数字和字母组成的唯一编码，可用于标识参与国际金融交易的法人机构，简称LEI编码。',
       '{"1":{"IMIX域名":"_PartySubID_(JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，法人机构识别编码则由“SubGrp”组件中的Type域和ID域组合表示)"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('21_位机构代码', 'CFETS_Institution_Code', 'CFETS_Institution_Code', '0506', '参与方',
       '中国外汇交易中心暨全国银行间同业拆借中心给会员机构编制的21位编码。',
       '{"1":{"IMIX域名":"_PartyID或者PartyDetailID或者NestedPartyID（JR/T_0066一般以“Party”组件描述"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('组织机构代码', 'Organization_Code', 'Organization_Code', '1220', '参与方', '按照GB_11714—1997规定，赋予每一个组织在全国范围内唯一的，始终不变的9位识别标识
码，已被整合到统一社会信用代码中，作为统一社会信用代码的第9位至第17位主体标识码，该代码在
系统中仍使用，暂且保留，并建立与统一社会信用代码的映射关系。', '{"1":{"IMIX域名":"PartyID（JR/T_0066一般以“Party”组件描述机构实体，组织机构代码以“Party”组件中的ID域表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('机构中文全称', 'Institution_Chinese_Full_Name', 'Institution_Chinese_Full_Name', '0507', '参与方', null,
       '{"1":{"IMIX域名":"PartySubID或者NestedPartySubID或者LegPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，机构中文全称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('机构英文全称', 'Institution_English_Full_Name', 'Institution_English_Full_Name', '0508', '参与方', '会员机构的英文全称。',
       '{"1":{"IMIX域名":"PartySubID或者NestedPartySubID或者LegPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，机构英文全称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('机构中文简称', 'Institution_Chinese_Short_Name', 'Institution_Chinese_Short_Name', '0509', '参与方', '会员机构的中文简称。',
       '{"1":{"IMIX域名":"PartySubID或者NestedPartySubID或者LegPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，机构中文简称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('机构英文简称', 'Institution_EnglishShort_Name', 'Institution_EnglishShort_Name', '0510', '参与方', '会员机构的英文简称。',
       '{"1":{"IMIX域名":"PartySubID或者NestedPartySubID或者LegPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，机构英文简称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('清算币种', 'Clearing_Currency', 'Clearing_Currency', '0553', '参与方', '按照GB/T12406规定，交易双方进行清算或交割时约定使用的清算货币代码。',
       '{"1":{"IMIX域名":"LegSettlCurrency或者AccountCurrency或者SettlCurrency或者Currency或者LegCurrency或者NDFCurrency"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('是否清算行清算', 'Clearing_ModeFlag', 'Clearing_ModeFlag', '0554', '参与方', '会员机构是否通过清算机构进行清算。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('清算行', 'Clearing_Bank', 'Clearing_Bank', '0555', '参与方', '会员机构的清算银行（代理行）名称。',
       '{"1":{"IMIX域名":"PartySubID或者SettlPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，清算行由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('托管账户名称', 'Deposit_AccountName', 'Deposit_AccountName', '0567', '参与方', '会员机构在托管机构所开立的账户的名称。',
       '{"1":{"IMIX域名":"PartySubID或者SettlPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，托管账户名称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('托管账号', 'Deposit_Account_Number', 'Deposit_Account_Number', '0568', '参与方', '会员机构在托管机构的编号。',
       '{"1":{"IMIX域名":"PartySubID或者SettlPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，托管账号由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('托管机构名称', 'Deposit_Institution_Name', 'Deposit_Institution_Name', '0569', '参与方',
       '中华人民共和国境内的金融机构或投资人托管债券的第三方机构的机构名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，托管机构名称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('用户密码', 'User_Password', 'User_Password', '0585', '参与方', '用户的系统登录密码。',
       '{"1":{"IMIX域名":"Password或者NewPassword"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('成员类型', 'Member_Type', 'Member_Type', '0511', '参与方', '会员机构所属的机构类型。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('成员大类', 'Member_Grand_Type', 'Member_Grand_Type', '0512', '参与方', '会员机构在平台中所属的大类名称。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('中外资类别', 'Capital_Type', 'Capital_Type', '0513', '参与方', '会员机构的注册资本类型。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('法人代表', 'Representative_Name', 'Representative_Name', '0518', '参与方', '会员机构的法定代表人指定的代表企业法人行为的自然人。',
       '{"1":{"IMIX域名":"PartySubID或者ContactInfoID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，法人代表则由“SubGrp”组件中的Type域和ID域组合表示；或者以“Party”下的子组件“ContactInfoGrp”表示机构用户联系方式详细信息，法人代表则由“ContactInfoGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('机构状态', 'Institution_Status', 'Institution_Status', '0520', '参与方', '会员机构在系统中所处的状态。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('终止日', 'End_Date', 'End_Date', '0522', '参与方', '特定业务、数据或功能在系统中不可用的日期。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('USBKEY证书代码', 'USBKEY_Certificate_Code', 'USBKEY_Certificate_Code', '0525', '参与方',
       'USBKEY证书代码是USBKEY唯一的编码。USBKEY是一种USB接口的硬件设备，内置单片机或智能卡芯片，有一定的存储空间，可存储用户的私钥以及数字证书，利用USBKEY内置的公钥算法实现对用户身份的认证。',
       '{"1":{"IMIX域名":"ApplUniqueKey"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('业务类型', 'Business_Type', 'Business_Type', '0527', '参与方', '依据一定维度对业务的划分，包括本币、外汇、信息、增值、其他。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('联系人姓名', 'Contact_Person_Name', 'Contact_Person_Name', '0528', '参与方', '会员机构联系人的姓名。',
       '{"1":{"IMIX域名":"PartySubID或者ContactInfoID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，联系人姓名则由“SubGrp”组件中的Type域和ID域组合表示；或者以“Party”下的子组件“ContactInfoGrp”表示机构用户联系方式详细信息，联系人姓名则由“ContactInfoGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('部门', 'Department', 'Department', '0529', '参与方', '会员机构联系人所在的部门名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，部门则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('部门地址', 'Department_Address', 'Department_Address', '0530', '参与方', '会员机构联系人所在部门的联系地址。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，部门地址则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('联系人类型', 'Contact_Person_Type', 'Contact_Person_Type', '0532', '参与方', '会员机构联系人在系统中的分类。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('联系人属性', 'Contact_Person_Attribute', 'Contact_Person_Attribute', '0533', '参与方',
       '一个联系人可有多个联系人属性，但前提是该机构拥有多个机构身份，且在多个机构身份下都维护了这个联系人。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('机构身份名称', 'Identity_of_Institution', 'Identity_of_Institution', '0534', '参与方', '会员机构在银行间市场上的身份名称。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('机构身份状态', 'Identity_Status_of_Institution', 'Identity_Status_of_Institution', '0536', '参与方',
       '用于标识机构身份在系统内所处的状态，决定机构身份是否可使用。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('退市日期', 'Quit_Date', 'Quit_Date', '0537', '参与方', '会员机构退出银行间市场的日期，即在系统中机构身份状态变为禁用的日期。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('退市原因', 'Quit_Reason', 'Quit_Reason', '0538', '参与方', '会员机构退出银行间市场的原因。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('退市备注', 'Quit_Remark', 'Quit_Remark', '0539', '参与方', '会员机构退出银行间市场的其他情况说明。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('成立日期', 'Establish_Date', 'Establish_Date', '0541', '参与方', '会员机构或发行人注册成立的日期。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('是否上市', 'Listed_Company_Flag', 'Listed_Company_Flag', '0542', '参与方', '会员机构或发行机构是否是上市公司。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('发行人状态', 'Issuer_Status', 'Issuer_Status', '0543', '参与方', '发行人在系统中所处的状态。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('是否结算代理行', 'Settlement_Bank_Flag', 'Settlement_Bank_Flag', '0546', '参与方',
       '用于标识金融机构是否为结算代理行。结算代理行是根据与参与者签订的结算服务协议，负责对清算结果进行结算的银行业金融机构。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('交易账户代码', 'Trading_Account_Code', 'Trading_Account_Code', '1223', '参与方', '机构交易账户在系统中的唯一编码。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('交易账户名称', 'Trading_Account_Name', 'Trading_Account_Name', '1224', '参与方', '机构交易账户在系统中的名称。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('交易账户状态', 'Trading_Account_Status', 'Trading_Account_Status', '0549', '参与方', '机构交易账户在系统中所处的状态。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('清算账户代码', 'Clearing_Account_Code', 'Clearing_Account_Code', '1225', '参与方', '机构清算账户在系统中的唯一编码。',
       '{"1":{"IMIX域名":"SettlPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，清算账户代码则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('清算账户名称', 'Clearing_Account_Name', 'Clearing_Account_Name', '1226', '参与方', '会员机构进行资金清算的账户名称。',
       '{"1":{"IMIX域名":"SettlPartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，清算账户名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('清算账户状态', 'Clearing_Account_Status', 'Clearing_Account_Status', '0552', '参与方', '机构清算账户在系统中所处的状态。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('账户名称', 'Account_Name', 'Account_Name', '0557', '参与方', '会员机构在清算银行（代理行）的账户名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，账户名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('发起行行号', 'Initiator_Bank_Code', 'Initiator_Bank_Code', '0560', '参与方', '发起行在中国人民银行大额实时支付系统中的开户行行号。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('会员当地人行账号', 'Local_PBOC_Account_Number', 'Local_PBOC_Account_Number', '0561', '参与方', '会员机构在当地中国人民银行所开立的账户的账号。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('清算行支付系统行号', 'Clearing_Bank_Payment_System_Code', 'Clearing_Bank_Payment_System_Code', '0562', '参与方',
       '会员机构的清算银行（代理行）在中国人民银行大额实时支付系统的开户行行号。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，清算行支付系统行号则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('支付系统行号', 'Payment_System_Code', 'Payment_System_Code', '0563', '参与方', '会员机构在中国人民银行大额实时支付系统中的开户行行号。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，支付系统行号则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('资金开户行名称', 'Capital_Bank_Name', 'Capital_Bank_Name', '0564', '参与方', '会员机构用于资金结算的账户的开户行名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，资金开户行名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('资金账号', 'Capital_Account_Number', 'Capital_Account_Number', '0565', '参与方', '会员机构用于资金结算的账户的账号。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，资金账号则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('资金账户名称', 'Capital_Account_Name', 'Capital_Account_Name', '0566', '参与方', '会员机构用于资金结算的账户的户名。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，资金账户名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('业务关系类型', 'Business_Relationship_Type', 'Business_Relationship_Type', '0574', '参与方', '会员机构之间的所属业务关系在系统中的分类。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('操作关系类型', 'Operation_Relationship_Type', 'Operation_Relationship_Type', '0575', '参与方', '一家机构可对另一家或多家机构进行操作的类型。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('主机构', 'Master_Institution', 'Master_Institution', '0576', '参与方', '机构关系中的主导机构。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述主机构实体，以“Party”下的子组件“SubGrp”描述主机构实体详细信息，主机构名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('关联机构', 'Relevant_Institution', 'Relevant_Institution', '0577', '参与方', '机构关系中的从属机构。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('权限名称', 'Authority_Name', 'Authority_Name', '0578', '参与方',
       '权限在系统中的名称，如Trading权限、Contribution权限、Trading_Model权限、特殊币种参考价报价权限等。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('权限类型', 'Authority_Type', 'Authority_Type', '1209', '参与方', '系统针对不同权限所做的分类。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('权限状态', 'Authority_Status', 'Authority_Status', '0579', '参与方', '会员机构及其用户的权限在系统中所处的状态。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('机构权限终止日', 'Authority_EndDate', 'Authority_EndDate', '0580', '参与方', '会员机构权限在系统中失效的日期。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('机构角色类型', 'Institution_Role_Type', 'Institution_Role_Type', '0581', '参与方', '会员机构在银行间市场上进行交易的角色类型。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('机构角色中文名称', 'Institution_Role_Chinese_Name', 'Institution_Role_Chinese_Name', '1222', '参与方', '会员机构的机构角色中文名称。',
       '{"1":{"IMIX域名":"PartyRole"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('用户姓名', 'User_Name', 'User_Name', '0183', '参与方', '用户在系统中的姓名。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('用户身份证号码', 'User_ID_Number', 'User_ID_Number', '0582', '参与方', '用户的身份证号码。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，用户身份证号码则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('用户状态', 'User_Status', 'User_Status', '0584', '参与方', '用户在系统中所处的状态。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('用户地址', 'User_Address', 'User_Address', '0586', '参与方', '用户的地址信息。',
       '{"1":{"IMIX域名":"PartySubID或者ContactInfoID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，用户地址则由“SubGrp”组件中的Type域和ID域组合表示；或者以“Party”下的子组件“ContactInfoGrp”描述机构用户联系方式详细信息，用户地址则由“ContactInfoGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('角色名称', 'Role_Name', 'Role_Name', '0588', '参与方', '用户角色在系统中的名称。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('角色状态', 'Role_Status', 'Role_Status', '0589', '参与方', '用户角色在系统中所处的状态。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('基金净值总额', 'Fund_Total_Net_Amount', 'Fund_Total_Net_Amount', '0310', '参与方',
       '基金公司的用户向中国外汇交易中心暨全国银行间同业拆借中心提交本机构的基金净值。基金净值总额的计算公式为：基金净值总额=基金资产总额-基金负债总额及各项费用。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('接收用户', 'Feed_User_ID', 'Feed_User_ID', '0591', '参与方', '会员机构中接收订阅信息的用户。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('接收密码', 'Feed_Password', 'Feed_Password', '0592', '参与方', '会员机构用户接收订阅信息时所用的密码。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('订阅连接方式', 'Subscription_Connection_Mode', 'Subscription_Connection_Mode', '0593', '参与方',
       '会员机构从中国外汇交易中心暨全国银行间同业拆借中心系统获取订阅信息的连接方法。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('最大连接数', 'Max_ConCurrent_Connection', 'Max_ConCurrent_Connection', '0594', '参与方',
       '会员机构接入中国外汇交易中心暨全国银行间同业拆借中心系统获取订阅信息的最大用户数。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('应计额', 'Accrued_Amount', 'Accrued_Amount', '0889', '参与方', '依照系统中设置的各费率值计算得出的总费用。',
       '{"1":{"IMIX域名":"MiscFeeAmt或者NetMiscFeeAmt或者CommissionAmt或者NetCommissionAmt"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('优惠金额', 'Discount_Amount', 'Discount_Amount', '0890', '参与方', '针对不同交易量、终端数等进行的优惠计算。',
       '{"1":{"IMIX域名":"CommissionPrimeAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('应缴额', 'Payable_Amount', 'Payable_Amount', '0891', '参与方', '扣除优惠金额后，会员机构实际应缴的金额。',
       '{"1":{"IMIX域名":"NetCommissionAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('计费日期', 'Fee_Calculate_Date', 'Fee_Calculate_Date', '0892', '参与方', '计算会员机构不同类型费用的日期。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('成交日期', 'Transaction_Date', 'Transaction_Date', '0335', '参与方', '一笔交易达成成交时的日期。', '{"1":{"IMIX域名":"TradeDate"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('累积优惠', 'Accumulative_Discount', 'Accumulative_Discount', '0893', '参与方', '依照不同优惠费率、特殊费率计算出的累积优惠金额。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('千元封顶优惠', 'Cap_Discount_of_One_Thousand_Yuan', 'Cap_Discount_of_One_Thousand_Yuan', '0894', '参与方',
       '一笔交易手续费超过1000元时按1000元进行收取。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('交易终端数量', 'Number_of_Transaction_Terminals', 'Number_of_Transaction_Terminals', '0895', '参与方',
       '普通会员机构接入中国外汇交易中心暨全国银行间同业拆借中心系统的终端数目。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('做市商终端数量', 'Number_of_Market_Maker_Terminals', 'Number_of_Market_Maker_Terminals', '0896', '参与方',
       '做市商机构接入中国外汇交易中心暨全国银行间同业拆借中心系统的终端数目。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('交易终端费用', 'Transaction_Terminals_Fee', 'Transaction_Terminals_Fee', '0897', '参与方',
       '计费周期内会员机构接入中国外汇交易中心暨全国银行间同业拆借中心系统的终端费用。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('做市商终端费用', 'Market_Maker_Terminals_Fee', 'Market_Maker_Terminals_Fee', '0898', '参与方',
       '计费周期内做市商机构接入中国外汇交易中心暨全国银行间同业拆借中心系统的终端费用。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('浮动终端费用', 'Floating_Terminals_Fee', 'Floating_Terminals_Fee', '0899', '参与方',
       '在该年预收终端费已经存在的前提下，当某会员该年的终端数发生变化或者某会员该年的做市商身份发生改变时，计算出的需补缴或退费的终端费（正数表示要补缴，负数表示要退费），即为浮动终端费用。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('发行机构', 'Issuer', 'Issuer', '0913', '参与方', '发行人在系统中的名称。', '{"1":{"IMIX域名":"Issuer或者UnderlyingIssuer"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('用户ID', 'User_ID', 'User_ID', '1115', '参与方', '用户登录系统的唯一ID。', '{"1":{"IMIX域名":"Username"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('发行人编号', 'Issuer_Number', 'Issuer_Number', '1116', '参与方', '发行人在系统内的编号。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('中间行名称', 'Intermediary_Bank_Name', 'Intermediary_Bank_Name', '1117', '参与方', '资金结算、划拨或周转的中间金融机构的名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，中间行名称则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('中间行账号', 'Intermediary_Bank_Account', 'Intermediary_Bank_Account', '1118', '参与方', '参与方在中间金融机构的账号。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，中间行账号则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('资金开户行BIC_Code', 'CapitalBank_BIC_Code', 'CapitalBank_BIC_Code', '1119', '参与方',
       '即资金开户行的银行识别代码。银行识别代码（BIC）是按照GB/T_16711—1996规定，由一连串八位或十一位字符构成，用于在SWIFT电文中区分金融交易中的不同金融机构。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，资金开户行BIC_Code则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('中间行BIC_Code', 'Intermediary_Bank_BIC_Code', 'Intermediary_Bank_BIC_Code', '1120', '参与方',
       '即中间行的银行识别代码。银行识别代码（BIC）是按照GB/T_16711—1996规定，由一连串八位或十一位字符构成，用于在SWIFT电文中区分金融交易中的不同金融机构。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，中间行BIC_Code则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('收款行BIC_Code', 'Beneficiary_Bank_BIC_Code', 'Beneficiary_Bank_BIC_Code', '1121', '参与方',
       '即收款行的银行识别代码。银行识别代码（BIC）是按照GB/T_16711—1996规定，由一连串八位或十一位字符构成，用于在SWIFT电文中区分金融交易中的不同金融机构。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，收款行BIC_Code则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('用户类型', 'User_Type', 'User_Type', '1127', '参与方', '用户类型包括中国外汇交易中心暨全国银行间同业拆借中心场务用户、机构非交易员用户和机构交易员用户。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('交易员ID', 'Trader_ID', 'Trader_ID', '1138', '参与方', '会员机构的交易员在系统中的唯一ID。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，交易员ID则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('行权用户代码', 'Exercise_User_Code', 'Exercise_User_Code', '1143', '参与方', '行权用户登录系统的唯一代码。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('证书密码', 'Certificate_Password', 'Certificate_Password', '1157', '参与方', '会员机构安全证书的密码。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('发行人账号', 'Issuer_Account', 'Issuer_Account', '1167', '参与方',
       '用于描述当发行途径为“中国外汇交易中心暨全国银行间同业拆借中心发行”时，填写的中国外汇交易中心暨全国银行间同业拆借中心的相关账号信息。',
       '{"1":{"IMIX域名":"PartyDetailAltSubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，发行人账号则由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('市场名称', 'Market_Name', 'Market_Name', '0595', '产品', '市场的名称。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('交易产品名称', 'Product_Name', 'Product_Name', '0596', '产品', '交易产品的名称。',
       '{"1":{"IMIX域名":"SecurityType或者MarketIndicator"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易产品代码', 'Product_Code', 'Product_Code', '0597', '产品', '新增交易产品时系统生成的唯一编码。',
       '{"1":{"IMIX域名":"SecurityID或者LegSecurityID或者UnderlyingSecurityID"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('标准产品名称', 'Standardized_Product_Name', 'Standardized_Product_Name', '0598', '产品', '标准产品的名称。',
       '{"1":{"IMIX域名":"Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('标准产品代码', 'Standardized_Product_Code', 'Standardized_Product_Code', '0035', '产品', '新增标准产品时系统生成的唯一编码。',
       '{"1":{"IMIX域名":"SecurityID或者LegSecurityID或者UnderlyingSecurityID"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('最高成交价格', 'Highest_Price', 'Highest_Price', '0599', '产品', '交易平台中某产品在一定交易时段内交易达成的最高价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高成"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('最低成交价格', 'Lowest_Price', 'Lowest_Price', '0600', '产品', '交易平台中某产品在一定交易时段内交易达成的最低价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件的Type域和Px域组合表示最低成交价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘成交价格', 'Opening_Price', 'Opening_Price', '0601', '产品', '交易平台中某产品在开盘时第一笔交易达成的价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示盘成交价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新成交价格', 'Latest_Price', 'Latest_Price', '0602', '产品', '交易平台中某产品最新一笔交易达成的价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”中的Type域和Px域组合表示最新成交价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘价格', 'Previous_Closing_Price', 'Previous_Closing_Price', '0603', '产品', '交易平台中某产品前一交易日最后一笔交易达成的价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权价', 'Weighted_Price', 'Weighted_Price', '0604', '产品',
       '在特定时间段内，每笔成交价格与成交量的乘积之和除以成交量之和所得出的价格。对于债券交易，成交量指券面总额；对于回购和拆借交易，成交量指成交金额。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均价格', 'Previous_Weighted_Average_Price', 'Previous_Weighted_Average_Price', '0605', '产品', '前一交易日的成交价格加权平均。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均价格', 'Weighted_Average_Price', 'Weighted_Average_Price', '0606', '产品', '某一时段内的成交价格加权平均。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('涨跌点数', 'Price_Change_Point', 'Price_Change_Point', '0607', '产品',
       '某一交易品种最新价与前一交易日收盘价格或当日开盘成交价格之间的差额。具体公式有如下两种：a）本币：涨跌点数=最新成交价格-前收盘价格；b）外汇：涨跌点数=最新成交价格-开盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示涨跌点数）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('涨跌幅', 'Price_Change_Ratio', 'Price_Change_Ratio', '0608', '产品',
       '某一交易品种涨跌与前一交易日收盘价格或当日开盘成交价格之间的百分比。具体公式有如下两种：a）本币：涨跌幅=（最新成交价格-前收盘价格）÷前收盘价格×100%；b）外汇：涨跌幅=（最新成交价格-开盘成交价格）÷开盘成交价格×100%。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示涨跌幅）"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('收盘成交价格', 'Closing_Price', 'Closing_Price', '0610', '产品', '交易平台中某产品在收盘时最后一笔交易达成的价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘成交价格）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新拆借利率', 'Latest_Offered_Rate', 'Latest_Offered_Rate', '0611', '产品', '特指同业拆借产品的最新成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘拆借利率', 'Opening_Offered_Rate', 'Opening_Offered_Rate', '0612', '产品', '特指同业拆借产品的开盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘拆借利率', 'Closing_Offered_Rate', 'Closing_Offered_Rate', '0613', '产品', '特指同业拆借产品的收盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均拆借利率', 'Weighted_Average_Offered_Rate', 'Weighted_Average_Offered_Rate', '0614', '产品', '特指同业拆借产品的加权平均价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘拆借利率', 'Previous_Closing_Offered_Rate', 'Previous_Closing_Offered_Rate', '0615', '产品', '特指同业拆借产品的前收盘价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均拆借利率', 'Previous_Weighted_Average_Offered_Rate', 'Previous_Weighted_Average_Offered_Rate', '0616', '产品',
       '特指同业拆借产品的前加权平均价格。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均拆借利率）"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('最高拆借利率', 'Highest_Offered_Rate', 'Highest_Offered_Rate', '0617', '产品', '特指同业拆借产品的最高成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低拆借利率', 'Lowest_Offered_Rate', 'Lowest_Offered_Rate', '0618', '产品', '特指同业拆借产品的最低成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低拆借利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新回购利率', 'Latest_Repo_Rate', 'Latest_Repo_Rate', '0619', '产品', '特指回购市场产品的最新成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘回购利率', 'Opening_Repo_Rate', 'Opening_Repo_Rate', '0620', '产品', '特指回购市场产品的开盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘回购利率', 'Closing_Repo_Rate', 'Closing_Repo_Rate', '0621', '产品', '特指回购市场产品的收盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均回购利率', 'Weighted_Average_Repo_Rate', 'Weighted_Average_Repo_Rate', '0622', '产品', '特指回购市场产品的加权平均价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘回购利率', 'Previous_Closing_Repo_Rate', 'Previous_Closing_Repo_Rate', '0623', '产品', '特指回购市场产品的前收盘价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均回购利率', 'Previous_Weighted_Average_Repo_Rate', 'Previous_Weighted_Average_Repo_Rate', '0624', '产品',
       '特指回购市场产品的前加权平均价格。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均回购利率）"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('最高回购利率', 'Highest_Repo_Rate', 'Highest_Repo_Rate', '0625', '产品', '特指回购市场产品的最高成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低回购利率', 'Lowest_Repo_Rate', 'Lowest_Repo_Rate', '0626', '产品', '特指回购市场产品的最低成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低回购利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新净价', 'Latest_Net_Price', 'Latest_Net_Price', '0076', '产品', '当日该债券最新一笔交易的净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新收益率', 'Latest_Yield', 'Latest_Yield', '0079', '产品', '当日该债券最新一笔交易的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最高净价', 'Highest_Net_Price', 'Highest_Net_Price', '0021', '产品', '当日一定交易时段内债券交易达成的最高净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低净价', 'Lowest_Net_Price', 'Lowest_Net_Price', '0092', '产品', '当日一定交易时段内债券交易达成的最低净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均净价', 'Previous_Weighted_Average_Net_Price', 'Previous_Weighted_Average_Net_Price', '0627', '产品',
       '前一交易日债券交易的加权平均净价。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均净价）"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('前加权平均收益率', 'Previous_Weighted_Average_Yield', 'Previous_Weighted_Average_Yield', '0250', '产品',
       '前一交易日债券交易的加权平均收益率。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均收益率）"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('前收盘利率', 'Previous_Closing_Rate', 'Previous_Closing_Rate', '0628', '产品', '前一交易日的收盘成交利率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均利率', 'Previous_Weighted_Average_Rate', 'Previous_Weighted_Average_Rate', '0629', '产品', '前一交易日的加权平均利率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘固定利率', 'Opening_Fixing_Rate', 'Opening_Fixing_Rate', '0630', '产品', '特指远期利率协议产品和利率互换产品的开盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘固定利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新固定利率', 'Latest_Fixing_Rate', 'Latest_Fixing_Rate', '0631', '产品', '特指远期利率协议产品和利率互换产品的最新成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新远期固定利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘固定利率', 'Closing_Fixing_Rate', 'Closing_Fixing_Rate', '0052', '产品', '特指远期利率协议产品和利率互换产品的收盘成交价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘固定利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均固定利率', 'Weighted_Average_Fixing_Rate', 'Weighted_Average_Fixing_Rate', '0632', '产品',
       '特指远期利率协议产品和利率互换产品的加权平均价格。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均固定利率）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('买报价', 'Bid_Quote_Price', 'Bid_Quote_Price', '0633', '产品', '买方向的报价。',
       '{"1":{"IMIX域名":"MDEntryPx或者YieldPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示买报价，或者以“Curve”组件中的Type域和Px域组合表示买报价）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('卖报价', 'Ask_Quote_Price', 'Ask_Quote_Price', '0634', '产品', '卖方向的报价。',
       '{"1":{"IMIX域名":"MDEntryPx或者YieldPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示卖报价，或者以“Curve”组件中的Type域和Px域组合表示卖报价）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('参考价名称', 'Reference_Price_Name', 'Reference_Price_Name', '0609', '产品', '参考价的名称。',
       '{"1":{"IMIX域名":"BenchmarkCurveName或者LegBenchmarkCurveName"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('参考价数值', 'Reference_Price_Value', 'Reference_Price_Value', '0639', '产品', '参考价的取值。',
       '{"1":{"IMIX域名":"BenchmarkPrice或者NestedBenchmarkPrice"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('回购利率', 'Repo_Rate', 'Repo_Rate', '0394', '产品', '根据首期资金支付额和到期资金支付额计算出的利率，为借入资金所付出的额外金额年化后的年利率。',
       '{"1":{"IMIX域名":"Price或者LegPrice或者LastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('拆借利率', 'Offered_Rate', 'Offered_Rate', '0359', '产品', '金融机构之间相互融通短期资金的利率。',
       '{"1":{"IMIX域名":"Price或者LegPrice或者LastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('清算方式名称', 'Clearing_Method_Name', 'Clearing_Method_Name', '0640', '产品', '清算方式的名称。',
       '{"1":{"IMIX域名":"ClearingMethod或者LegClearingMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('清算速度', 'Clearing_Speed', 'Clearing_Speed', '0641', '产品', '从达成交易到实际清算的时间间隔。',
       '{"1":{"IMIX域名":"SettlType或者LegSettlType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易方向', 'Direction', 'Direction', '0285', '产品', '交易的方向。如：外汇即期的买入、卖出，质押式回购的正回购、逆回购等。',
       '{"1":{"IMIX域名":"Side或者LegSide"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准货币交易方向', 'Base_Direction', 'Base_Direction', '0642', '产品', '基准货币的交易方向。', '{"1":{"IMIX域名":"Side或者LegSide"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('非基准货币交易方向', 'Term_Direction', 'Term_Direction', '0643', '产品', '非基准货币的交易方向。', '{"1":{"IMIX域名":"Side或者LegSide"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('计息基准', 'Interest_Basis', 'Interest_Basis', '0644', '产品', '计算利息时计算天数的规则。',
       '{"1":{"IMIX域名":"LegDayCount或者DayCount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('计息方式', 'Interest_Method', 'Interest_Method', '0179', '产品', '计算利息的方式。',
       '{"1":{"IMIX域名":"InterestAccrualMethod或者LegInterestAccrualMethod"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('固定利率', 'Fixed_Interest_Rate', 'Fixed_Interest_Rate', '0395', '产品', '约定的计算固定利率支付方应支付的固定金额所依据的利率水平，在借贷期内利率不作调整。',
       '{"1":{"IMIX域名":"Price或者LegPrice或者LegLastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('计息天数调整', 'Interest_Days_Adjustment', 'Interest_Days_Adjustment', '0646', '产品', '支付日调整后的计息天数调整规则。',
       '{"1":{"IMIX域名":"InterestAccuralDaysAdjustment或者LegInterestAccuralDaysAdjustment"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('利差', 'Spreads', 'Spreads', '0214', '产品', '又称点差，在浮动利率基础上加、减的基点数。',
       '{"1":{"IMIX域名":"Spread或者LegBenchmarkSpread"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('名义本金', 'Notional_Principal', 'Notional_Principal', '0647', '产品',
       '交易双方在协议中所确定的合约规模，又称名义金额。利率互换、远期利率协议、信用风险缓释凭证等衍生品交易的名义本金金额，一般用来计算交易双方未来应收应付所依据的金额。',
       '{"1":{"IMIX域名":"IOIQty或者LastQty或者OrderQty或者LegIOIQty或者LegOrderQty或者GrossTradeAmt"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('期限', 'Tenor/Period', 'Tenor/Period', '0648', '产品', '交易所跨时间长度，或在计费系统进行计费时针对特定市场进行的期限划分。',
       '{"1":{"IMIX域名":"TradeLimitDays或者SettlType或者LegSettlType"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('回购期限', 'Repo_Term', 'Repo_Term', '0447', '产品', '质押式回购、买断式回购中交易所跨的时间长度。', '{"1":{"IMIX域名":"TradeLimitDays"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('起息日', 'Value_Date', 'Value_Date', '0649', '产品',
       '开始计算资金利息的日期，或交易双方履行资金交割与结算的日期，在外汇市场，一般情况下，起息日与结算日（Settlement_Date）、交割日（Delivery_Date）相同。',
       '{"1":{"IMIX域名":"ValueDate或者SettlDate或者StartDate或者LegSettlDate或者DeliveryDate"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('首次利率确定日', 'First_Fixing_Date', 'First_Fixing_Date', '0130', '产品', '交易中首次确定利率的日期。',
       '{"1":{"IMIX域名":"LegInterestAccrualDate或者InterestFixDate或者InterestAccrualDate"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('首期定期支付日', 'First_Regular_Payment_Date', 'First_Regular_Payment_Date', '0129', '产品',
       '若存在前端残段，首期定期支付日为前端残段之后首个计息期的支付日；若不存在前端残段，首期定期支付日则为首个计息期的支付日。', '{"1":{"IMIX域名":"LegCouponPaymentDate"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('期初本金交换日', 'Beginning_Principal_Effective_Date', 'Beginning_Principal_Effective_Date', '0650', '产品',
       '又称首期起息日。指第一个付息周期或付息残段（外汇期权）的起息日。', '{"1":{"IMIX域名":"IniExDate"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('首期起息日', 'First_Effective_Date', 'First_Effective_Date', '0651', '产品', '首次进行利息计算的日期。',
       '{"1":{"IMIX域名":"FirstPeriodStartDate或者SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('支付日', 'Payment_Date', 'Payment_Date', '0652', '产品', '交易一方进行支付的日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate或者PaymentDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('支付日调整', 'Payment_Date_Adjustment', 'Payment_Date_Adjustment', '0653', '产品', '支付日遇到节假日的调整规则，适用营业日准则。',
       '{"1":{"IMIX域名":"CouponPaymentDateReset或者LegCouponPaymentDateReset或者SettlDateAdjustment"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('支付周期', 'Payment_Period', 'Payment_Period', '0654', '产品',
       '交易双方用以推算支付日的固定时间间隔，在推算支付日时，若支付周期为季、半年、年，则等同于三个月、六个月、十二个月。',
       '{"1":{"IMIX域名":"LegCouponPaymentFrequency或者CouponPaymentFrequency"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('重置频率', 'Reset_Frequency', 'Reset_Frequency', '0111', '产品',
       '以天、周、两周、月、季、半年、年为周期，来推算重置日，其中天指每个营业日。在计算重置日时，若重置频率为季、半年、年，则等同于三个月、六个月、十二个月。',
       '{"1":{"IMIX域名":"LegInterestAccrualResetFrequency或者InterestAccrualResetFrequency"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('券面总额', 'Nominal_Volume', 'Nominal_Volume', '0223', '产品', '交易债券的总面额。券面总额的计算公式为：券面总额=债券数量×单张债券面值。',
       '{"1":{"IMIX域名":"IOIQty或者LastQty或者OrderQty或者LegIOIQty或者LegOrderQty或者LegLastQty"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('首期交易净价', '1st_Net_Price', '1st_Net_Price', '0655', '产品', '首期结算时逆回购方对回购债券支付的债券净价。',
       '{"1":{"IMIX域名":"UnderlyingPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首期收益率', '1st_Yield', '1st_Yield', '0656', '产品', '债券首次净价对应的到期收益率。',
       '{"1":{"IMIX域名":"StipulationValue或者LegStipulationValue或者UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示首期收益率）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('首期应计利息', '1st_Accrued_Interest', '1st_Accrued_Interest', '0657', '产品', '首次结算时的每百元债券应计利息。',
       '{"1":{"IMIX域名":"UnderlyingAccruedInterestAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期交易净价', 'Net_Price_to_Maturity', 'Net_Price_to_Maturity', '0658', '产品', '到期结算时正回购方对回购债券支付的债券净价。',
       '{"1":{"IMIX域名":"UnderlyingPx2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期收益率', 'Yield_to_Maturity（YTM）', 'Yield_to_Maturity（YTM）', '0440', '产品',
       '债券持有到全部付息结束后的回报率，以到期交易全价买入债券并持有至到期的收益率。',
       '{"1":{"IMIX域名":"StipulationValue或者LegStipulationValue或者UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示到期收益率）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('到期应计利息', 'Accrued_Interest_to_Maturity', 'Accrued_Interest_to_Maturity', '0659', '产品',
       '上次付息日（或起息日）至到期结算日为止（不含到期结算日）累积的按百元面值计算的债券发行人应付给债券持有人的利息。', '{"1":{"IMIX域名":"UnderlyingAccruedInterestAmt2"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('首期全价', '1st_Dirty_Price', '1st_Dirty_Price', '0660', '产品', '首次结算时的净价与应计利息之和。',
       '{"1":{"IMIX域名":"UnderlyingDirtyPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首期资金结算额', '1st_Settlement_Amount', '1st_Settlement_Amount', '0661', '产品',
       '在一笔交易中，指交易双方约定的逆回购方在首期结算日向正回购方支付的资金额。', '{"1":{"IMIX域名":"SettlCurrAmt或者LegSettlCurrAmt"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('结算方式名称', 'Settlement_Method_Name', 'Settlement_Method_Name', '0662', '产品', '结算方式在系统中的名称。',
       '{"1":{"IMIX域名":"DeliveryTypeOption或者LegDeliveryType或者DeliveryType"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('首期结算方式', '1st_Settlement_Method', '1st_Settlement_Method', '0663', '产品', '首次结算时的券款清算/结算安排规则。',
       '{"1":{"IMIX域名":"DeliveryTypeOption或者LegDeliveryType或者DeliveryType"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('到期结算方式', 'Settlement_Method_to_Maturity', 'Settlement_Method_to_Maturity', '0233', '产品', '到期结算时的券款清算/结算安排规则。',
       '{"1":{"IMIX域名":"DeliveryType2或者LegDeliveryType2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期全价', 'All-in_Price_to_Maturity', 'All-in_Price_to_Maturity', '0664', '产品', '到期结算时的净价与应计利息之和。',
       '{"1":{"IMIX域名":"DirtyPrice2或者UnderlyingDirtyPrice2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期资金结算额', 'Capital_Settlement_Amount_to_Maturity', 'Capital_Settlement_Amount_to_Maturity', '0665', '产品',
       '在一笔交易中，指交易双方约定的正回购方在到期结算日向逆回购方支付的资金额。', '{"1":{"IMIX域名":"SettlCurrAmt2或者LegSettlCurrAmt2"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('结算日', 'Settlement_Date', 'Settlement_Date', '0168', '产品', '又称交割日。由交易双方约定的交割资金的日期。',
       '{"1":{"IMIX域名":"SettlDate或者LegSettlDate或者DeliveryDate"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('首期结算日', '1st_Settlement_Date', '1st_Settlement_Date', '0666', '产品',
       '在回购交易中，交易双方约定的逆回购方将资金划至正回购方指定的资金账户，且正回购方在相关回购债券上完成质押登记或将相关回购债券转让给逆回购方的日期；在人民币拆借、外币拆借中，交易双方约定的拆出方将资金划至拆入方指定的资金账户的日期；在债券借贷产品中，交易双方约定的融入方将资金划至融出方指定的资金账户的日期。',
       '{"1":{"IMIX域名":"SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期结算日', 'Settlement_Date_to_Maturity', 'Settlement_Date_to_Maturity', '0226', '产品',
       '在一笔交易中，交易双方约定的正回购方将资金划至逆回购方指定的资金账户，且逆回购方解除相关回购债券的质押登记或向正回购方返还回购债券的日期；在人民币拆借、外币拆借中，交易双方约定的拆入方将资金划至拆出方指定的资金账户的日期；在债券借贷产品中，交易双方约定的融出方将资金划至融入方指定的资金账户的日期。',
       '{"1":{"IMIX域名":"SettlDate2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首次交割日', 'First_Delivery_Date', 'First_Delivery_Date', '0667', '产品',
       '根据不同场景，具体有以下两种解释：a）_开始计息的日期，其计算公式为：首次交割日=成交日+清算速度（遇节假日顺延到下一交易日）；b）_标的债券从债券融出方向债券融入方过户、质押债券冻结的日期。',
       '{"1":{"IMIX域名":"SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期交割日', 'Delivery_Date_to_Maturity', 'Delivery_Date_to_Maturity', '0668', '产品',
       '根据不同场景，具体有以下两种解释：a）_到期清算的日期，其计算公式为：到期交割日=起息日+回购期限（遇节假日顺延到下一交易日）；b）_标的债券从债券融入方向债券融出方过户、债券融入方向债券融出方支付借贷费用且质押债券解押的日期，其计算公式为：到期交割日=首次结算日+借贷期限（遇节假日顺延到下一工作日）。',
       '{"1":{"IMIX域名":"SettlDate2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('实际占款天数', 'Actual_Cash_Holding_Days', 'Actual_Cash_Holding_Days', '0315', '产品',
       '资金融入方实际持有资金的天数。实际占款天数的计算公式为：实际占款天数=到期结算日-首次结算日。', '{"1":{"IMIX域名":"CashHoldingDays"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('拆借金额', 'Lending_Amount', 'Lending_Amount', '0669', '产品', '拆入/拆出的资金总额。',
       '{"1":{"IMIX域名":"IOIQty或者LastQty或者OrderQty或者LegIOIQty"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('应计利息', 'Accrued_Interest', 'Accrued_Interest', '0330', '产品', '从上一付息日（或起息日）到结算日之间累计的按百元面值计算的债券发行人应付给债券持有人的利息。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('到期还款金额', 'Maturity_Amount', 'Maturity_Amount', '0670', '产品', '还款日拆入方还给拆出方的总金额，等于成交金额与利息之和。',
       '{"1":{"IMIX域名":"SettlCurrAmt2或者LegSettlCurrAmt2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期还款日', 'Maturity_Payment_Date', 'Maturity_Payment_Date', '0671', '产品',
       '拆借合约中约定的借入方返还借出方的日期。到期还款日的计算公式为：到期还款日=起息日+拆借期限（遇节假日顺延到下一交易日），是到期清算的日期。', '{"1":{"IMIX域名":"SettlDate2"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('交易货币', 'Dealt_Currency', 'Dealt_Currency', '0273', '产品', '按照GB/T_12406规定，外汇交易时作为交易标的的货币代码。',
       '{"1":{"IMIX域名":"Currency或者LegCurrency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('对应货币', 'Contra_Currency', 'Contra_Currency', '0672', '产品', '按照GB/T_12406规定，一个货币对中与交易货币相对应的货币代码。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('交易货币金额', 'Dealt_Amount', 'Dealt_Amount', '0458', '产品', '以交易货币表示的金额。', '{"1":{"IMIX域名":"LastQty或者LegLastQty"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('对应货币金额', 'Contra_Amount', 'Contra_Amount', '0673', '产品', '以对应货币表示的金额。',
       '{"1":{"IMIX域名":"CalculatedCcyLastQty或者LegCalculatedCcyLastQty"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('即期汇率', 'Spot_Exchange_Rate', 'Spot_Exchange_Rate', '0674', '产品', '银行间外汇市场两种货币在即期交易中互相兑换的价格。',
       '{"1":{"IMIX域名":"LastSpotRate或者LegLastSpotRate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('即期起息日', 'Spot_Value_Date', 'Spot_Value_Date', '0675', '产品', '即期交易双方履行资金划拨真正执行生效的日期。',
       '{"1":{"IMIX域名":"SpotDate或者LegSpotDate或者SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('近端基准货币金额', 'Near-Leg_Base_Amount', 'Near-Leg_Base_Amount', '0676', '产品', '近端基准货币计量的交易量。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('近端汇率', 'Near-Leg_Exchange_Rate', 'Near-Leg_Exchange_Rate', '0677', '产品', '交易双方约定的第一次交割货币所使用的汇率。',
       '{"1":{"IMIX域名":"LegLastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('近端掉期点', 'Near-Leg_Swap_Point', 'Near-Leg_Swap_Point', '0678', '产品', '近端掉期全价与即期价格之间的点差。',
       '{"1":{"IMIX域名":"LegLastForwardPoints或者LastForwardPoints"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('近端非基准货币金额', 'Near-Leg_Term_Amount', 'Near-Leg_Term_Amount', '0679', '产品', '近端非基准货币计量的交易量。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('近端折算率', 'Near-Leg_Conversion_Proportion', 'Near-Leg_Conversion_Proportion', '0680', '产品',
       '近端基准货币或非基准货币对美元的折算率。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('近端折美元金额', 'Near-Leg_Risk_Amount', 'Near-Leg_Risk_Amount', '0681', '产品', '近端美元计量的交易量。',
       '{"1":{"IMIX域名":"LegRiskOrderQty或者RiskLastQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('近端期限', 'Near-Leg_Term', 'Near-Leg_Term', '0682', '产品', '掉期交易近端所跨时间长度。', '{"1":{"IMIX域名":"LegSettlType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('近端起息日', 'Near-Leg_Value_Date', 'Near-Leg_Value_Date', '0683', '产品', '掉期中第一次货币交割的日期。',
       '{"1":{"IMIX域名":"LegSettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('远端期限', 'Far-Leg_Term', 'Far-Leg_Term', '0684', '产品', '掉期交易远端所跨时间长度。', '{"1":{"IMIX域名":"LegSettlType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('远端起息日', 'Far-Leg_Value_Date', 'Far-Leg_Value_Date', '0685', '产品', '掉期中第二次货币交割的日期。',
       '{"1":{"IMIX域名":"LegSettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('远端基准货币金额', 'Far-Leg_Base_Amount', 'Far-Leg_Base_Amount', '0686', '产品', '远端基准货币计量的交易量。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('远端汇率', 'Far-Leg_Exchange_Rate', 'Far-Leg_Exchange_Rate', '0687', '产品', '交易双方约定的第二次交割货币所使用的汇率。',
       '{"1":{"IMIX域名":"LegLastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('远端掉期点', 'Far-Leg_Swap_Point', 'Far-Leg_Swap_Point', '0688', '产品', '远端掉期全价与即期价格之间的点差。',
       '{"1":{"IMIX域名":"LegLastForwardPoints或者LastForwardPoints"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('远期全价', 'Forward_All-in_Rate', 'Forward_All-in_Rate', '0689', '产品',
       '交易双方约定的在远期起息日基准货币交换非基准货币的价格。远期全价的计算公式为：远期全价=即期汇率+远期点。', '{"1":{"IMIX域名":"LegLastPx或者LastPx"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('掉期全价', 'Swap_All-in_Rate', 'Swap_All-in_Rate', '0690', '产品',
       '交易双方约定的在起息日基准货币交换非基准货币的价格。包括近端掉期全价和远端掉期全价。掉期全价的计算公式为：掉期全价=即期汇率+相应期限掉期点。', '{"1":{"IMIX域名":"LegLastPx"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('远端非基准货币金额', 'Far-Leg_Term_Amount', 'Far-Leg_Term_Amount', '0691', '产品', '远端非基准货币计量的交易量。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('远端折算率', 'Far-Leg_Conversion_Proportion', 'Far-Leg_Conversion_Proportion', '0692', '产品', '远端基准货币或非基准货币对美元的折算率。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('远端折美元金额', 'Far-Leg_Risk_Amount', 'Far-Leg_Risk_Amount', '0693', '产品', '远端美元计量的交易量。',
       '{"1":{"IMIX域名":"LegRiskOrderQty或者RiskLastQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易品种', 'Instrument', 'Instrument', '0461', '产品', '可交易的产品种类。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('本金交换形式', 'Principal_Exchange_Form', 'Principal_Exchange_Form', '0694', '产品', '货币掉期本金交换的形式。',
       '{"1":{"IMIX域名":"NotionalExchangeType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('残段', 'Stub', 'Stub', '0695', '产品', '包括付息残段和计息残段，如无特别约定，残段指付息残段。', '{"1":{"IMIX域名":"StubIndicator"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('适用利率', 'Applicable_Interest_Rate', 'Applicable_Interest_Rate', '0697', '产品', '在定息周期或计息残段计算利息时使用的利率。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('利率期限', 'Interest_Term', 'Interest_Term', '0698', '产品', '1st_leg或2nd_leg付款的利率期限，仅对浮动利率有效。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('期差合约利率', 'Spread_Interest_Rate', 'Spread_Interest_Rate', '0699', '产品', '期差合约交易中利息与合约金额的比值。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('定息规则', 'Fixing_Rule', 'Fixing_Rule', '0700', '产品', '确定定价日与起息日关系的规则，属于定价日规则的一部分。',
       '{"1":{"IMIX域名":"LegInterestFixDateAdjustment"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('定息周期', 'Fixing_Frequency', 'Fixing_Frequency', '0701', '产品',
       '又称利率重置周期。货币掉期交易中每隔一段固定的期限就会重新确定用于计算利息支付的浮动利率，该期限即定息周期。利率重置频率隐含的期限即利率重置周期，定息频率隐含的期限即定息周期。',
       '{"1":{"IMIX域名":"LegInterestAccrualResetFrequency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('付息周期', 'Payment_Frequency', 'Payment_Frequency', '0443', '产品',
       '货币掉期交易中交易双方每隔一段固定的期限会向对方支付换入货币计算的利息金额，该期限即为付息周期，也可定义为付息频率隐含的期限。',
       '{"1":{"IMIX域名":"CouponPaymentFrequency或者LegCouponPaymentFrequency"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('折美元率', 'Conversion_Proportion', 'Conversion_Proportion', '0702', '产品',
       '又称折算率、美元折算率。基准货币或非基准货币对美元的折算率。具体有以下两种解释：a）对于含美元的货币对：1）若交易货币为美元，折算率=1；2）若交易货币为非美元且为基准货币，折算率=该货币对汇率；3）若交易货币为非美元且为非基准货币，折算率=1÷该货币对汇率。b）对于不含美元的货币对：1）若交易货币为基准货币，折算率=（交易货币÷USD_买入价+交易货币÷USD_卖出价）÷2；2）若交易货币为非基准货币，折算率=1÷[（USD÷交易货币买入价+USD÷交易货币卖出价）÷2]。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('日期调整规则', 'Date_Adjustment_Rule', 'Date_Adjustment_Rule', '0703', '产品', '基准利率类型对应的日期调整规则。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('付息假日', 'Payment_Holiday', 'Payment_Holiday', '0704', '产品', '基准利率类型对应的付息假日。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('交易类型', 'Trading_Type', 'Trading_Type', '0288', '产品', '依据期权所赋予的权利不同区分的类别。', '{"1":{"IMIX域名":"PutOrCall"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('行权方式', 'Exercise_Method', 'Exercise_Method', '0705', '产品', '依据期权行权时间不同区分的类别。',
       '{"1":{"IMIX域名":"DerivativeExerciseStyle"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('期权类型', 'Option_Type', 'Option_Type', '0706', '产品', '根据不同划分方式，划分出的期权类型。', '{"1":{"IMIX域名":"OptPayoutType"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('行权交易基准货币交易方向', 'Exercise_Trading_Base_Direction', 'Exercise_Trading_Base_Direction', '0707', '产品',
       '期权交易行权时，基准货币的交易方向。', '{"1":{"IMIX域名":"Side"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('行权交易非基准货币交易方向', 'Exercise_Trading_Term_Direction', 'Exercise_Trading_Term_Direction', '0708', '产品',
       '期权交易行权时，非基准货币的交易方向。', '{"1":{"IMIX域名":"Side"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准货币名义本金', 'Base_Currency_Notional_Principal', 'Base_Currency_Notional_Principal', '0709', '产品',
       '期权交易行权时，基准货币计量的名义本金金额。', '{"1":{"IMIX域名":"OrderQty或者IOIQty"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('非基准货币名义本金', 'Term_Currency_Notional_Principal', 'Term_Currency_Notional_Principal', '0710', '产品',
       '期权交易行权时，非基准货币计量的名义本金金额。', '{"1":{"IMIX域名":"OrderQty或者IOIQty"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('行权日', 'Exercise_Date', 'Exercise_Date', '0711', '产品', '期权买方选择是否行权的日期或含权债行使权利的日期。',
       '{"1":{"IMIX域名":"EventDate或者MaturityDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('行权价格', 'Strike_Price/Exercise_Price', 'Strike_Price/Exercise_Price', '0712', '产品',
       '交易双方约定在未来某一日期进行外汇交易的汇率，或含权债行使权利时交易的价格。', '{"1":{"IMIX域名":"StrikePrice或者EventPx"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('折美元金额', 'Risk_Amount', 'Risk_Amount', '0348', '产品', '外汇交易按成交时的美元市场汇率折算成的美元金额，通常用作交易量统计的基准。',
       '{"1":{"IMIX域名":"RiskLastQty或者LegRiskOrderQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('即期参考汇率', 'Spot_Benchmark', 'Spot_Benchmark', '0713', '产品', '用以试算期权费和期权各项风险指标的即期参考汇率。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('期权费支付日', 'Premium_Date', 'Premium_Date', '0714', '产品', '交易双方约定的期权买方向期权卖方支付期权费的日期，通常为该货币对的即期起息日。',
       '{"1":{"IMIX域名":"PaymentDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交割日', 'Delivery_Date', 'Delivery_Date', '0715', '产品', '由交易双方约定的交割资金的日期。',
       '{"1":{"IMIX域名":"DeliveryDate或者SettlDate或者EndDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('期权费', 'Option_Premium', 'Option_Premium', '0716', '产品', '期权买方购买期权所支付的费用，即期权价格（Option_Price）。',
       '{"1":{"IMIX域名":"OptPremiumAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('期权费类型', 'Premium_Type', 'Premium_Type', '0717', '产品', '双方约定的期权费率的报价表示方式，包括非基准货币百分比（Term%）和基点（Pips）。',
       '{"1":{"IMIX域名":"OptPremiumBasis"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('期权费率', 'Premium_Rate', 'Premium_Rate', '0718', '产品', '双方约定的用以计算期权费金额的比率，可约定选择不同的期权费类型进行报价。',
       '{"1":{"IMIX域名":"OptPremiumValue"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('行权截止时间', 'Exercise_Cut_Off_Time', 'Exercise_Cut_Off_Time', '0719', '产品',
       '交易双方约定的在到期日行权的最晚时点，一般不应超过到期日当天的15:00。', '{"1":{"IMIX域名":"ExpireTime"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('行权状态', 'Exercise_Status', 'Exercise_Status', '0720', '产品', '期权买方发出行权通知后的期权行权状态。',
       '{"1":{"IMIX域名":"DerivativeExerciseStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交割方式', 'Delivery_Method', 'Delivery_Method', '0721', '产品', '交易双方在期权交易达成时约定的期权买方行权后在交割日进行资金清算的方式。',
       '{"1":{"IMIX域名":"OptSettlAmtType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('行权日中间价', 'Central_Parity_Rate_on_Exercise_Date', 'Central_Parity_Rate_on_Exercise_Date', '0722', '产品',
       '行权日的人民币外汇中间价。', '{"1":{"IMIX域名":"StrikeDayPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('轧差金额', 'Netting_Amount', 'Netting_Amount', '0723', '产品', '差额交割方式下，约定的执行价格与当日中间价进行轧差得出的差额。',
       '{"1":{"IMIX域名":"SettlCurrAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('Delta', 'Delta', 'Delta', '0724', '产品', '外汇即期价格单位变动带来外汇期权价格的绝对变动值，是用以衡量外汇期权风险状况的重要指标，通常用来衡量头寸的风险。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('Gamma', 'Gamma', 'Gamma', '0725', '产品', '外汇即期价格单位变动带来外汇期权Delta值的绝对变动值，反映即期价格对delta的影响程度。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('Vega', 'Vega', 'Vega', '0726', '产品', '外汇即期价格波动率单位变动带来外汇期权价格的绝对变动值，衡量波动率对期权价格的影响幅度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('Theta', 'Theta', 'Theta', '0727', '产品', '外汇期权到期时间单位变动带来外汇期权价格的绝对变动值，衡量时间变化对期权价格的影响幅度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('Rho', 'Rho', 'Rho', '0728', '产品', '利率变化对期权价格的影响。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('隐含波动率', 'Implied_Volatility', 'Implied_Volatility', '0729', '产品',
       '汇率在一段时间内变动的程度，是衡量期权价格波动幅度的指标，一般采用标准方差计算，是外汇期权报价的标的，以百分比表示。', '{"1":{"IMIX域名":"Volatility"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('本国货币利率', 'Domestic_Rate', 'Domestic_Rate', '0730', '产品', '在计算Delta的值时，需要用到的人民币利率。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('外国货币利率', 'Foreign_Rate', 'Foreign_Rate', '0731', '产品', '用以计算Delta头寸的美元利率。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('外汇期权结算货币', 'Option_Settlement_Currency', 'Option_Settlement_Currency', '0732', '产品', '结算时使用的币种，期权交易中限定为人民币。',
       '{"1":{"IMIX域名":"StrikeCurrency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准货币金额', 'Base_Currency_Amount', 'Base_Currency_Amount', '0453', '产品', '以基准货币表示的金额。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('非基准货币金额', 'Term_Currency_Amount', 'Term_Currency_Amount', '0733', '产品', '以非基准货币表示的金额。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('远期汇率', 'Forward_Exchange_Rate', 'Forward_Exchange_Rate', '0734', '产品', '银行间外汇市场上，交易双方约定的在未来某一日期两种货币互相兑换的价格。',
       '{"1":{"IMIX域名":"LastPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('远期点', 'Forward_Point', 'Forward_Point', '0735', '产品', '远期汇率减去即期汇率的基点数。', '{"1":{"IMIX域名":"LastForwardPoints"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('远期起息日', 'Forward_Value_Date', 'Forward_Value_Date', '0736', '产品', '远期交易双方履行资金划拨真正执行生效的日期。',
       '{"1":{"IMIX域名":"SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('轧差清算远期定价日', 'Netting-Settled_Forward_Fixed_Date', 'Netting-Settled_Forward_Fixed_Date', '0737', '产品',
       '外汇远期轧差清算交易中确定轧差使用的即期汇率的日期。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('待偿期', 'Term_to_Maturity（TTM）', 'Term_to_Maturity（TTM）', '0738', '产品',
       '债券的剩余存续期，即当前日期至债券到期日之间的期限。待偿期的计算公式为：待偿期=', '{"1":{"IMIX域名":"TermToMaturity"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('债券主体评级', 'Credit_Rating', 'Credit_Rating', '1210', '产品', '发债主体的信用评级。', '{"1":{"IMIX域名":"CreditRating"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('净价', 'Net_Price', 'Net_Price', '0219', '产品', '扣除按债券票面利率计算的应计利息后的债券价格。',
       '{"1":{"IMIX域名":"UnderlyingPx或者LegPrice或者Price或者LastPx"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('前收盘净价', 'Previous_Closing_Net_Price', 'Previous_Closing_Net_Price', '0246', '产品', '前一工作日该债券最后一笔交易的净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘全价', 'Previous_Closing_Dirty_Price', 'Previous_Closing_Dirty_Price', '0247', '产品', '前一工作日该债券最后一笔交易的全价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘全价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘加权平均净价', 'Previous_Closing_Weighted_Average_Net_Price', 'Previous_Closing_Weighted_Average_Net_Price',
       '0224', '产品', '前一工作日该债券最后一笔交易前一分钟所有交易的成交量加权平均价（含最后一笔交易）。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘加权平均净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘净价', 'Opening_Net_Price', 'Opening_Net_Price', '0331', '产品',
       '当日该债券第一笔交易的净价。债券的开盘价通过集合竞价方式产生，不能产生开盘价的，以连续竞价方式产生。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘全价', 'Opening_Dirty_Price', 'Opening_Dirty_Price', '0332', '产品',
       '当日该债券第一笔交易的全价。债券的开盘价通过集合竞价方式产生，不能产生开盘价的，以连续竞价方式产生。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘全价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘净价', 'Closing_Net_Price', 'Closing_Net_Price', '0739', '产品', '当日该债券最后一笔交易的净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘加权平均净价', 'Closing_Weighted_Average_Net_Price', 'Closing_Weighted_Average_Net_Price', '0740', '产品',
       '当日该债券最后一笔交易前一分钟所有交易的成交量加权平均价（含最后一笔交易）。当日无成交的，应以前收盘加权平均净价为当日收盘加权平均净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘加权平均净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均净价', 'Weighted_Average_Net_Price', 'Weighted_Average_Net_Price', '0741', '产品', '用数量作为权数进行加权平均计算的净价价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均全价', 'Weighted_Average_Dirty_Price', 'Weighted_Average_Dirty_Price', '1219', '产品', '用数量作为权数进行加权平均计算的全价价格。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均全价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('行权收益率', 'Exercise_Yield', 'Exercise_Yield', '0742', '产品', '含权债券的内嵌选择权被行使时的收益率。',
       '{"1":{"IMIX域名":"StipulationValue或者LegStipulationValue或者UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示行权收益率）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('应计利息总额', 'Total_Accrued_Interest', 'Total_Accrued_Interest', '0320', '产品',
       '债券应计利息的总和。应计利息总额的计算公式为：应计利息总额=应计利息×券面总额÷100。',
       '{"1":{"IMIX域名":"AccruedInterestTotalAmt或者LegAccruedInterestTotalAmt"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('全价', 'All_Price', 'All_Price', '0221', '产品', '未来现金流的现值之和，等于净价与应计利息之和。全价的计算公式为：全价=净价+应计利息。',
       '{"1":{"IMIX域名":"UnderlyingDirtyPrice或者DirtyPrice或者LegDirtyPrice"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('结算金额', 'Settlement_Amount', 'Settlement_Amount', '0169', '产品',
       '交易双方约定的在结算日交易一方应向另一方支付或收取的结算货币金额。远期交易结算时买方向卖方支付的资金额。结算金额的计算公式为：结算金额=（远期交易净价+结算日应计利息）×标的债券券面总额÷100。',
       '{"1":{"IMIX域名":"SettlCurrAmt或者LegSettlCurrAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易金额', 'Transaction_Amount', 'Transaction_Amount', '0274', '产品',
       '又称货币金额。在涉及超过一种货币的交易中，交易双方就某种货币约定的金额。根据本币市场和外汇市场划分，具体有以下两种解释：a）_本币市场中，现券买卖为净价金额，资产支持证券为净价金额，债券远期为净价金额，买断式回购为首次净价金额，债券借贷为标的券券面总额，质押式回购为首次结算金额，信用拆借为首次结算金额，利率互换为名义本金，远期利率协议为名义本金；b）_外汇市场中，分为基准货币金额、非基准货币金额、交易货币金额、对应货币金额、折美元金额。除非交易双方另有约定，交易金额指基准货币金额。',
       '{"1":{"IMIX域名":"LegTradeCashAmt或者TradeCashAmt或者OrderQty或者IOIQty或者LastQty或者LegOrderQty"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('凭证价格', 'Voucher_Price', 'Voucher_Price', '1211', '产品', '信用风险缓释凭证的价格。', '{"1":{"IMIX域名":"Price"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('预期收益率', 'Expected_Yield', 'Expected_Yield', '0743', '产品', '预期收益率也称为期望收益率，是指如果没有意外事件发生时根据已知信息所预测能得到的收益率。',
       '{"1":{"IMIX域名":"StipulationValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示预期收益率）"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('合约期限', 'Contract_Term', 'Contract_Term', '0445', '产品', '合约生效日至到期日的天数。',
       '{"1":{"IMIX域名":"TradeLimitDays或者SettlType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('利率确定日', 'Interest_Rate_Fixing_Date', 'Interest_Rate_Fixing_Date', '0235', '产品',
       '根据交易双方约定的方式确定某个重置日参考利率水平的日期。除另有约定，利率确定日适用上一营业日准则。',
       '{"1":{"IMIX域名":"LegInterestAccrualDate或者InterestFixDate或者InterestAccrualDate"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('贴现利率', 'Discount_Rate', 'Discount_Rate', '0355', '产品', '远期利率协议将期末现金流贴现至期初采用的利率。',
       '{"1":{"IMIX域名":"StipulationValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示贴现利率）"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('远期期限', 'Forward_Term', 'Forward_Term', '0744', '产品', '远期合同交割日期与当日之间的期限。', '{"1":{"IMIX域名":"TradeFwdDays"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('借贷期限', 'Lending_Term', 'Lending_Term', '0466', '产品', '债券借入/借出的理论期限。', '{"1":{"IMIX域名":"TradeLimitDays"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('标的债券券面总额', 'Total_Face_Value', 'Total_Face_Value', '1212', '产品', '借入/借出的债券的券面总额。',
       '{"1":{"IMIX域名":"UnderlyingQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('借贷费率', 'Lending_Rate', 'Lending_Rate', '0745', '产品', '以年利率行使标识的债券借贷成本，债券借贷交易以借贷费率报价。',
       '{"1":{"IMIX域名":"Price"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('借贷费用', 'Lending_Fee', 'Lending_Fee', '0746', '产品', '到期时债券融入方向融出方支付的费用。',
       '{"1":{"IMIX域名":"MiscFeeAmt（JR/T_0066一般以“MiscFee”组件中的Type域和Amt域组合表示借贷费用）"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('争议解决方式', 'Disputes_Settlement_Method', 'Disputes_Settlement_Method', '0264', '产品',
       '交易双方约定在发生争议情况下的解决方式，可选择仲裁或者诉讼。', '{"1":{"IMIX域名":"DisputeSettlementMethod"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('质押债券置换安排', 'Replacement_Option_of_Collateralized_Bonds', 'Replacement_Option_of_Collateralized_Bonds', '0747',
       '产品', '交易双方约定在借贷期限内是否可置换质押债券，可选择是或者否。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('实际占券天数', 'Actual_Security_Holding_Days', 'Actual_Security_Holding_Days', '0316', '产品',
       '债券融入方实际持有标的债券天数。实际占券天数的计算公式为：实际占券天数=到期结算日-首次结算日。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('质押债券数目', 'Pledge_Coupon_Number', 'Pledge_Coupon_Number', '0748', '产品', '质押式回购交易或债券借贷交易达成过程中，双方约定的质押债券的只数。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('折算比例', 'Conversion_Proportion', 'Conversion_Proportion', '0749', '产品', '实际融入金额占质押债券券面总额的百分比。',
       '{"1":{"IMIX域名":"UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示折算比例）"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('远期净价', 'Forward_Net_Price', 'Forward_Net_Price', '0750', '产品', '交易双方在成交日约定、在结算日进行交割的标的债券净价。',
       '{"1":{"IMIX域名":"UnderlyingPx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('远期到期收益率', 'Forward_Maturity_Yield', 'Forward_Maturity_Yield', '0751', '产品', '交易双方在成交日约定的标的债券在结算日的到期收益率。',
       '{"1":{"IMIX域名":"UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示远期到期收益率）"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('质押券种类', 'Pledged_Coupon_Type', 'Pledged_Coupon_Type', '0752', '产品', '质押式回购交易达成过程中，双方约定的质押债券的种类。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('每百元本金额', 'Principal_Amount_Per_100_Yuan', 'Principal_Amount_Per_100_Yuan', '0024', '产品',
       '每百元待清偿的本金金额，该金额随着资产支持证券的逐期偿付而递减。', '{"1":{"IMIX域名":"Principal"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('本金额', 'Principal', 'Principal', '1213', '产品', '资产支持证券依据交易量算出的剩余本金总额，为每百元本金额与券面总额之积。',
       '{"1":{"IMIX域名":"LegTotalPrincipal或者TotalPrincipal"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('拆借币种', 'Lending_Currency', 'Lending_Currency', '0753', '产品', '金融机构进行外币头寸余额拆借的外币币种。',
       '{"1":{"IMIX域名":"Currency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('到期结算金额', 'Settlement_Amount_to_Maturity', 'Settlement_Amount_to_Maturity', '0228', '产品', '交易到期时资金交割的金额。',
       '{"1":{"IMIX域名":"LegSettlCurrAmt2或者SettlCurrAmt2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('标准期限', 'Tenor/Fixed_Period', 'Tenor/Fixed_Period', '0754', '产品', '起息日与该货币对即期交易起息日时间差为固定时间段的期限。',
       '{"1":{"IMIX域名":"SettlType或者LegSettlType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('补充条款', 'Supplementary_Terms', 'Supplementary_Terms', '0756', '产品', '询价过程中，交易员可选择在报价输入窗口的补充条款字段输入补充信息。',
       '{"1":{"IMIX域名":"Text"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('收益率', 'Yield', 'Yield', '0757', '产品',
       '投资的回报率，一般以年度百分比表达，根据当时市场价格、面值、息票利率以及距离到期日时间计算。对公司而言，收益率指净利润占使用的平均资本的百分比。',
       '{"1":{"IMIX域名":"StipulationValue或者LegStipulationValue或者UnderlyingStipValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示收益率）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('前收盘收益率', 'Previous_Closing_Yield', 'Previous_Closing_Yield', '0248', '产品', '前一工作日该债券最后一笔交易的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘收益率', 'Opening_Yield', 'Opening_Yield', '0329', '产品', '当日该债券第一笔交易的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘收益率', 'Closing_Yield', 'Closing_Yield', '0054', '产品', '当日该债券最后一笔交易的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均收益率', 'Weighted_Average_Yield', 'Weighted_Average_Yield', '0241', '产品', '当日该债券所有交易收益率的加权平均。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('可供出售余额', 'Available-for-Sale_Balance', 'Available-for-Sale_Balance', '0758', '产品', '机构持有可供出售债券的余额。',
       '{"1":{"IMIX域名":"LegLeaveQty或者LeavesTotalQty或者LeavesQty"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('清算货币', 'Clearing_Currency', 'Clearing_Currency', '0759', '产品', '外汇NDF中用于轧差清算的货币。',
       '{"1":{"IMIX域名":"NDFCurrency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('做市商类型', 'Market_Maker_Type', 'Market_Maker_Type', '0201', '产品', '标识机构是否为做市商机构。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('结算日调整', 'Settlement_Date_Adjustment', 'Settlement_Date_Adjustment', '0165', '产品', '原定结算日遇法定节假日后作出的提前或延迟的变动。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('成交量标志', 'Trade_Volume_Flag', 'Trade_Volume_Flag', '1111', '产品',
       '根据交易金额0-1M,1-3M,3-5M,5-10M,10-15M,15-20M,20-30M,30-40M,40-50M,50M设置不同标志位（0~9）。',
       '{"1":{"IMIX域名":"TradeVolumeFlag"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('初始交换标志位', 'Initial_Exchange_Flag', 'Initial_Exchange_Flag', '1112', '产品', '标志利率互换是否存在初始交换。',
       '{"1":{"IMIX域名":"IniExReqIndicator"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('名义本金重设量', 'Notional_Reset_Principal', 'Notional_Reset_Principal', '0391', '产品', '名义本金的变化数量。',
       '{"1":{"IMIX域名":"OrdQtyResetAmount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('名义本金重设比率', 'Notional_Principal_Reset_Percentage', 'Notional_Principal_Reset_Percentage', '0384', '产品',
       '名义本金的变化比率。', '{"1":{"IMIX域名":"OrdQtyResetPercentage"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('名义本金重设要求', 'Notional_Principal_Reset_Required', 'Notional_Principal_Reset_Required', '0390', '产品',
       '名义本金在合约期间是否变化。', '{"1":{"IMIX域名":"OrdQtyResetRequired"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('名义本金重设类型', 'Notional_Principal_Reset_Type', 'Notional_Principal_Reset_Type', '0385', '产品', '名义本金是递增变化还是递减变化。',
       '{"1":{"IMIX域名":"OrdQtyResetType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('名义本金重设频率', 'Notional_Principal_Reset_Frequency', 'Notional_Principal_Reset_Frequency', '0388', '产品',
       '名义本金的变化频率。', '{"1":{"IMIX域名":"OrdQtyResetFrequency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('最高限价', 'Highest_Limit', 'Highest_Limit', '0017', '产品', '在市场行情中当日最高的限价报价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高限价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低限价', 'Lowest_Limit', 'Lowest_Limit', '0096', '产品', '在市场行情中当日最低的限价报价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低限价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最高收益率', 'Highest_Yield', 'Highest_Yield', '0016', '产品', '在市场行情中当日最高的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低收益率', 'Lowest_Yield', 'Lowest_Yield', '0095', '产品', '在市场行情中当日最低的收益率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低收益率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最高利差', 'Highest_Spread', 'Highest_Spread', '0022', '产品', '在市场行情中当日最高的利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最高利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最低利差', 'Lowest_Spread', 'Lowest_Spread', '0089', '产品', '在市场行情中当日最低的利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最低利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最新利差', 'Latest_Spread', 'Latest_Spread', '0081', '产品', '最新一笔交易的利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示最新利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘利率', 'Closing_Interest_Rate', 'Closing_Interest_Rate', '0049', '产品', '当日收盘前最后一笔交易的利率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前收盘利差', 'Previous_Closing_Spread', 'Previous_Closing_Spread', '0245', '产品', '上个交易日的收盘利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前收盘利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('收盘利差', 'Closing_Spread', 'Closing_Spread', '0050', '产品', '当日收盘前最后一笔交易的利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示收盘利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('开盘利差', 'Opening_Spread', 'Opening_Spread', '0328', '产品', '当前交易日第一笔交易的利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示开盘利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均利差', 'Previous_Weighted_Average_Spread', 'Previous_Weighted_Average_Spread', '0225', '产品', '上个交易日的加权平均利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均利差', 'Weighted_Average_Spread', 'Weighted_Average_Spread', '0242', '产品', '以数量为权重计算的平均利差。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均利差）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('前加权平均远期净价', 'Previous_Weighted_Average_Forward_Net_Price', 'Previous_Weighted_Average_Forward_Net_Price',
       '0249', '产品', '上个交易日的加权平均远期净价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示前加权平均远期净价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('加权平均远期净价', 'Weighted_Average_Forward_Net_Price', 'Weighted_Average_Forward_Net_Price', '0244', '产品',
       '以数量为权重计算的平均远期净价。', '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示加权平均远期净价）"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('支付频率', 'Coupon_Payment_Frequency', 'Coupon_Payment_Frequency', '0058', '产品', '支付利息的频率。',
       '{"1":{"IMIX域名":"LegCouponPaymentFrequency或者CouponPaymentFrequency"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('中间价', 'Central_Parity_Rate', 'Central_Parity_Rate', '0259', '产品',
       '由中国人民银行授权中国外汇交易中心暨全国银行间同业拆借中心于每个工作日上午9时15分对外公布的、作为当日银行间即期外汇市场人民币对美元、欧元、日元等货币对的汇率中间价。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示中间价）"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('基准曲线名称', 'Benchmark_Curve_Name', 'Benchmark_Curve_Name', '0393', '产品', '浮动利率基准曲线的名称。',
       '{"1":{"IMIX域名":"BenchmarkCurveName或者NestedBenchmarkCurveName"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('参考价日期', 'Reference_Price_Date', 'Reference_Price_Date', '1128', '产品', '用于记录某参考价相关信息的日期。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('报价日期', 'Quote_Date', 'Quote_Date', '1129', '产品', '某笔报价成功报入系统时服务器记录的日期。', '{"1":{"IMIX域名":"QuoteTime"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('质押券券面总额', 'Pledged_Bonds_Nominal_Volume', 'Pledged_Bonds_Nominal_Volume', '1145', '产品',
       '质押债券的总面额。券面总额的计算公式为：券面总额=债券数量×单张债券面值。', '{"1":{"IMIX域名":"UnderlyingQty"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('个性化合约结算金额', 'Individual_Contracts_Settlement_Amount', 'Individual_Contracts_Settlement_Amount', '1148', '产品',
       '个性化合约交易双方约定的在结算日交易一方应向另一方支付或收取的结算货币金额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('首次支付开始日期', 'First_Payment_Starting_Date', 'First_Payment_Starting_Date', '1149', '产品', '首次进行利息计算的日期。',
       '{"1":{"IMIX域名":"FirstPeriodStartDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首次支付结束日期', 'First_Payment_Ending_Date', 'First_Payment_Ending_Date', '1150', '产品',
       '在不同交易产品中，具体有以下三种解释：a）_在回购交易中，表示交易双方约定的逆回购方将资金划至正回购方指定的资金账户，且正回购方在相关回购债券上完成质押登记或将相关回购债券转让给逆回购方的日期；b）_在人民币拆借中，表示交易双方约定的拆出方将资金划至拆入方指定的资金账户的日期；c）_在债券借贷产品中，表示交易双方约定的融入方将资金划至融出方指定的资金账户的日期。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('点差', 'Pips', 'Pips', '1151', '产品', '又称基点价差，在浮动利率基础上加、减的基点数。', '{"1":{"IMIX域名":"Spread"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('支付金额', 'Payment_Amount', 'Payment_Amount', '1152', '产品', '交易双方约定的在结算日交易一方应向另一方支付或收取的结算货币金额。',
       '{"1":{"IMIX域名":"SettlCurrAmt或者LegSettlCurrAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('合约代码', 'Contract_Code', 'Contract_Code', '1197', '产品', '用于记录特定产品的合约的唯一编码标识，如标准债券远期产品中的合约代码“BFG3_1406”。',
       '{"1":{"IMIX域名":"SecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易模式名称', 'Trading_Mode_Name', 'Trading_Mode_Name', '0760', '事件', '交易模式的名称。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('交易方式名称', 'Trading_Method_Name', 'Trading_Method_Name', '0761', '事件', '交易方式的名称。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('订单类型名称', 'Order_Type_Name', 'Order_Type_Name', '0762', '事件', '订单类型的名称。', '{"1":{"IMIX域名":"OrdType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('订单编号', 'Order_ID', 'Order_ID', '0118', '事件', '交易员提交新建的订单时，系统遵循一定的规则编制的唯一代码。', '{"1":{"IMIX域名":"OrderID"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('订单创建时间', 'Order_Creation_Time', 'Order_Creation_Time', '0763', '事件', '交易员完成新建订单相关要素填写并保存至交易平台的时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('订单激活时间', 'Order_Activation_Time', 'Order_Activation_Time', '0764', '事件', '交易员激活“冻结”状态的订单使其进入订单簿进行撮合的时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('订单失效时间', 'Order_Invalid_Time', 'Order_Invalid_Time', '0765', '事件',
       '在订单中设置的能被撮合或达成交易的最晚订单时间，超过有效时间后自动失效。默认为系统收盘时间。格式为：日期+时间（分钟）。', '{"1":{"IMIX域名":"ExpireTime"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('订单结束时间', 'Order_End_Time', 'Order_End_Time', '0766', '事件', '用于记录订单结束时的时间，包括失效撤销或成交时的时间。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('止损监控方向', 'Stop_Loss_Monitor_Direction', 'Stop_Loss_Monitor_Direction', '0767', '事件',
       '用户指定的止损价格的监控方向，适用于止损市价订单。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('止损触发价格', 'Stop_Loss_Trigger_Price', 'Stop_Loss_Trigger_Price', '0768', '事件',
       '止损市价订单设定的止损价格，当监控方向的市场报价达到或超过该止损价格时，订单在此时被激活，与市场最优价成交。适用于止损市价订单。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('已成交量', 'Deal_Amount', 'Deal_Amount', '0769', '事件', '指令驱动中已经达成交易的订单量。',
       '{"1":{"IMIX域名":"LastQty或者GrossTradeAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('订单总量', 'Order_Total_Amount', 'Order_Total_Amount', '0770', '事件', '指令驱动中订单成功提交至订单簿时的订单总量。',
       '{"1":{"IMIX域名":"LastQty或者GrossTradeAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('订单数量', 'Order_Total_Quantity', 'Order_Total_Quantity', '0771', '事件', '指令驱动中订单成功提交至订单簿时的订单个数。',
       '{"1":{"IMIX域名":"NumberOfOrders"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('剩余量', 'Surplus', 'Surplus', '0772', '事件', '指令驱动交易模式下剩余未达成交易的订单总量。',
       '{"1":{"IMIX域名":"LeavesQty或者LeavesTotalQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('报价编号', 'Quote_ID', 'Quote_ID', '0358', '事件', '交易员提交报价时，系统遵循一定的规则编制的唯一代码。', '{"1":{"IMIX域名":"QuoteID"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('报价时间', 'Quote_Time', 'Quote_Time', '0361', '事件', '报价驱动模式下，报价被发送的时间。', '{"1":{"IMIX域名":"QuoteTime"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('报价撤销时间', 'Quote_Withdraw_Time', 'Quote_Withdraw_Time', '0773', '事件', '报价驱动模式下，报价被撤销的时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('报价持续有效时间', 'Quote_Valid_Time', 'Quote_Valid_Time', '0363', '事件', '报价成功提交后至报价失效为止，报价有效的时间段。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('报价截止时间', 'Quote_Deadline', 'Quote_Deadline', '0774', '事件', '报价失效时间点。', '{"1":{"IMIX域名":"ValidUntilTime"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('报价状态', 'Quote_Status', 'Quote_Status', '0356', '事件', '报价所处的状态。手工报价分为有效和无效；查询历史报价时，无效报价状态需区分为已撤销和已超时。',
       '{"1":{"IMIX域名":"QuoteStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('是否匿名', 'Anonymous_Indicator', 'Anonymous_Indicator', '0243', '事件', '用于标识该笔报价是否匿名发送。',
       '{"1":{"IMIX域名":"AnonymousIndicator"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('是否自动回价', 'Auto_Price_Indicator', 'Auto_Price_Indicator', '0775', '事件',
       '用于标识在报价驱动模式下，当询价量小于等于报价方所设置的流动性限额时，是否可由系统自动回价。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('请求编号', 'Quote_Request_ID', 'Quote_Request_ID', '0776', '事件', '发起方新建询价单即生成询价请求编号。',
       '{"1":{"IMIX域名":"QuoteReqID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('MRFQ编号', 'MRFQ_ID', 'MRFQ_ID', '0777', '事件', 'MRFQ指批量请求报价，一笔MRFQ业务中的多条请求对应同一个MRFQ编号。',
       '{"1":{"IMIX域名":"MRFQId"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('询价请求发送时间', 'Quote_Request_Sending_Time', 'Quote_Request_Sending_Time', '0778', '事件', '发起方发送询价请求的时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('询价请求有效持续时间', 'Quote_Request_Valid_Time', 'Quote_Request_Valid_Time', '0779', '事件',
       '发起方的询价请求发送成功后至询价请求失效为止，询价请求有效的时间段。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('询价请求截止时间', 'Quote_Request_Deadline', 'Quote_Request_Deadline', '0780', '事件', '询价请求失效时间点。',
       '{"1":{"IMIX域名":"ValidUntilTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('回价有效持续时间', 'Counter-Offer_Valid_Time', 'Counter-Offer_Valid_Time', '0781', '事件', '回价方回复的价格有效时间。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('回价截止时间', 'Price_Deadline', 'Price_Deadline', '0782', '事件', '回价方回复的价格的有效最晚时间点。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('交易状态', 'Trading_Status', 'Trading_Status', '0783', '事件', '交易进行的状态。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('限价订单类型', 'Limit_Order_Type', 'Limit_Order_Type', '0784', '事件', '限价订单的不同分类。', '{"1":{"IMIX域名":"OrdType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('成交编号', 'Deal_ID', 'Deal_ID', '0341', '事件', '成交确认后生成的成交记录号，记录成交单的唯一标识符。', '{"1":{"IMIX域名":"ExecID"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('成交时间', 'Deal_Time', 'Deal_Time', '0334', '事件', '交易双方达成交易的具体时间（以北京时间表示）。',
       '{"1":{"IMIX域名":"TradeTime或者TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('成交状态', 'Deal_Status', 'Deal_Status', '0344', '事件', '一笔交易在交易平台中所处的状态。', '{"1":{"IMIX域名":"DealTransType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('成交量', 'Traded_Quantity', 'Traded_Quantity', '0340', '事件', '某一交易品种从开盘到当前时间为止的总成交量，对债券来说是面值总额，对回购和拆借来说是成交金额。',
       '{"1":{"IMIX域名":"GrossTradeAmt或者LastQty或者TradeCashAmt"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('成交金额', 'Traded_Amount', 'Traded_Amount', '0343', '事件', '用于描述债券交易中成交的总金额。',
       '{"1":{"IMIX域名":"GrossTradeAmt或者LastQty或者TradeCashAmt"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('清算状态', 'Clearing_Status', 'Clearing_Status', '0785', '事件', '用于标识成交交易是否已清算。',
       '{"1":{"IMIX域名":"ClearingStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('报价拍卖状态', 'Quote_Auction_Status', 'Quote_Auction_Status', '0786', '事件', '报价拍卖过程中的状态。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('申购途径', 'Subscription_Approach', 'Subscription_Approach', '0787', '事件', '依据申购路径的不同对申购进行的划分，包括正常投标、应急投标。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('申购时间', 'Subscription_Time', 'Subscription_Time', '0788', '事件', '记录申购的时间。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('招标状态', 'Tendering_Status', 'Tendering_Status', '0789', '事件', '招标过程中的状态。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('招标拍卖类型名称', 'Tendering_Auction_Type_Name', 'Tendering_Auction_Type_Name', '0790', '事件', '用于表示招标类型的名称。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('投标价位', 'Tender_Price', 'Tender_Price', '0791', '事件',
       '根据价格标位下限、价格标位上限和招标价位表投标步长计算得出，各投标价位取招标价位表中在价位上下限范围内（包括价位上限、价位下限）的价位。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('投标状态', 'Tender_Status', 'Tender_Status', '0792', '事件', '投标过程中的状态。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('投标途径', 'Tender_Approach', 'Tender_Approach', '0793', '事件', '依据投标路径的不同对投标进行的划分，包括正常投标、应急投标。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('投标时间', 'Tender_Time', 'Tender_Time', '0794', '事件', '用于记录投标时间。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('投标意向名称', 'Tender_Intention_Name', 'Tender_Intention_Name', '0795', '事件', '投标意向类型的名称。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('投标量', 'Tender_Quantity', 'Tender_Quantity', '0796', '事件', '投标数量。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('交易确认号', 'Trade_Confirmation_ID', 'Trade_Confirmation_ID', '0797', '事件', '交易确认时系统产生的唯一编号。',
       '{"1":{"IMIX域名":"ConfirmID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易确认状态', 'Trade_Confirmation_Status', 'Trade_Confirmation_Status', '0798', '事件', '用于记录确认状态。',
       '{"1":{"IMIX域名":"ConfirmStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易确认时间', 'Trade_Confirmation_Time', 'Trade_Confirmation_Time', '0799', '事件', '用于记录确认的时间信息。',
       '{"1":{"IMIX域名":"CnfmTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('备案状态', 'Recorded_Deal_Status', 'Recorded_Deal_Status', '0800', '事件', '用于记录交易是否已备案。',
       '{"1":{"IMIX域名":"RecordedDealStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('起息日变更确认状态', 'Confirmation_Status_of_Value_Date_Change', 'Confirmation_Status_of_Value_Date_Change', '0801',
       '事件', '用于记录起息日变更是否已确认。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('起息日变更确认时间', 'Confirmation_Time_of_Value_Date_Change', 'Confirmation_Time_of_Value_Date_Change', '0802', '事件',
       '用于记录起息日变更的确认时间。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('确认类型', 'Confirmation_Type', 'Confirmation_Type', '0803', '事件', '用于区分该笔交易是起息日变更确认或交易确认。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('冲销编号', 'Writeoff_ID', 'Writeoff_ID', '0804', '事件', '交易进入冲销流程时系统生成的唯一编号。', '{"1":{"IMIX域名":"WriteOffID"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('申请日期', 'Application_Date', 'Application_Date', '0805', '事件', '用于记录多边冲销的申请日期。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('清算退出日期', 'Clearing_Quit_Date', 'Clearing_Quit_Date', '0806', '事件', '用于记录多边冲销的清算退出日期。',
       '{"1":{"IMIX域名":"WithDrawDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('清算方式变更业务类型', 'Clearing_Method_Change_Business_Type', 'Clearing_Method_Change_Business_Type', '0807', '事件',
       '用于记录清算方式变更选择的业务类型。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('清算变更申请日期', 'Clearing_Method_Change_Application_Date', 'Clearing_Method_Change_Application_Date', '0809', '事件',
       '清算方式变更的变更申请日期。', '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('变更日期', 'Change_Date', 'Change_Date', '0810', '事件', '清算方式变更的日期。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('清算机构处理状态', 'Clearing_Institution_Process_Status', 'Clearing_Institution_Process_Status', '0811', '事件',
       '清算机构对清算方式变更的处理状态。', '{"1":{"IMIX域名":"ProcessingStatus"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('提前终止编号', 'Early_Termination_ID', 'Early_Termination_ID', '0812', '事件', '用于记录提前终止的唯一编号。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('提前终止日', 'Early_Termination_Date', 'Early_Termination_Date', '0813', '事件', '提前终止申请得到确认的日期。',
       '{"1":{"IMIX域名":"WithDrawDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('终止金额结算日', 'Terminate_Amount_Settlement_Date', 'Terminate_Amount_Settlement_Date', '0814', '事件', '提前终止日的下一交易日。',
       '{"1":{"IMIX域名":"WithDrawAmtSettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('清算变更申请状态', 'Clearing_Method_Change_Submit_Status', 'Clearing_Method_Change_Submit_Status', '0815', '事件',
       '清算变更的申请状态。具体状态的含义如下：a）_已提交：指本方提交的清算方式变更；b）_已收到：指对方发送的清算方式变更；c）_已申请：指双方确认的清算方式变更；d）_已撤销：如果成交原先状态为“已提交”，则拒绝/撤销后本方和对手方状态变为“已撤销”；e）_已拒绝：如果成交原先状态为“已收到”，则拒绝/撤销后本方和对手方状态变为“已拒绝”；f）_已变更：如果原先成交状态为“已提交”，则修改后本方状态变为“已变更”。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('撤销申请时间', 'Withdraw_Application_Time', 'Withdraw_Application_Time', '0816', '事件', '撤销提前终止申请的时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('合约估值', 'Valuation', 'Valuation', '0817', '事件', '依据一定规则对一笔合约进行的价值估计。', '{"1":{"IMIX域名":"OriAgreementValue"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('剩余名义本金', 'Remaining_Notional_Principal', 'Remaining_Notional_Principal', '0818', '事件',
       '对于部分终止的合约，本次提前终止后的剩余名义本金。', '{"1":{"IMIX域名":"LeavesTotalQty"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('提前终止来源', 'Early_Termination_Source', 'Early_Termination_Source', '0819', '事件', '提前终止申请的来源系统。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('终止名义本金', 'Termination_Notional_Principal', 'Termination_Notional_Principal', '0820', '事件', '需要终止清算的名义本金额。',
       '{"1":{"IMIX域名":"WriteOffQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('终止付款方应付金额', 'Amount_Due_of_Termination_Payer', 'Amount_Due_of_Termination_Payer', '0821', '事件',
       '提前终止申请中付款方应当支付的金额。', '{"1":{"IMIX域名":"WithDrawAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止申请业务类型', 'Early_Termination_Business_Type', 'Early_Termination_Business_Type', '1125', '事件', '提前终止申请业务的分类。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止申请日期', 'Early_Termination_Application_Date', 'Early_Termination_Application_Date', '0822', '事件',
       '提前终止的申请日期。', '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止比例', 'Early_Termination_Ratio', 'Early_Termination_Ratio', '0823', '事件', '提前终止的名义本金额占总名义本金额的比例。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止申请方确认状态', 'Early_Termination_Applicant_Confirmation_Status',
       'Early_Termination_Applicant_Confirmation_Status', '0824', '事件', '提前终止申请方的确认状态。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('提前终止申请方确认时间', 'Early_Termination_Applicant_Confirmation_Time', 'Early_Termination_Applicant_Confirmation_Time',
       '0825', '事件', '提前终止申请方的确认时间。', '{"1":{"IMIX域名":"CnfmTime"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('提前终止申请对手方确认时间', 'Early_Termination_Apply_Counterparty_Confirmation_Time',
       'Early_Termination_Apply_Counterparty_Confirmation_Time', '1147', '事件', '提前终止申请对手方确认的时间。',
       '{"1":{"IMIX域名":"CnfmTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止清算机构处理状态', 'Clearing_Institution_Process_Status_of_Early_Termination',
       'Clearing_Institution_Process_Status_of_Early_Termination', '0826', '事件', '清算机构对提前终止申请的处理状态。',
       '{"1":{"IMIX域名":"ProcessingStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止清算机构反馈时间', 'Clearing_Institution_Process_Feedback_Time_of_Early_Termination',
       'Clearing_Institution_Process_Feedback_Time_of_Early_Termination', '0827', '事件', '清算机构对提前终止申请的反馈时间。',
       '{"1":{"IMIX域名":"TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前终止状态', 'Early_Termination_Status', 'Early_Termination_Status', '0828', '事件', '提前终止的状态。',
       '{"1":{"IMIX域名":"WithDrawRespStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('原成交状态', 'Original_Deal_Status', 'Original_Deal_Status', '0829', '事件', '终止或撤销交易前的成交状态。',
       '{"1":{"IMIX域名":"ExecType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('终止后成交状态', 'Deal_Status_after_Termination', 'Deal_Status_after_Termination', '0830', '事件', '终止后的成交状态。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('提交日期', 'Submit_Date', 'Submit_Date', '0832', '事件', '个性化合约的提交日期。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('提交时间', 'Submit_Time', 'Submit_Time', '0833', '事件', '个性化合约的提交时间。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('固定利率支付方支付金额', 'Payers_of_Fixed_Pay_Amount', 'Payers_of_Fixed_Pay_Amount', '0834', '事件', '个性化合约固定利率支付方的支付金额。',
       '{"1":{"IMIX域名":"LegSettlCurrAmt2"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('浮动利率支付方支付金额', 'Payers_of_Floating_Pay_Amount', 'Payers_of_Floating_Pay_Amount', '0835', '事件',
       '个性化合约浮动利率支付方的支付金额。', '{"1":{"IMIX域名":"LegSettlCurrAmt2"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('个性化合约结算金额提交方式', 'Personalized_Contract_Settlement_Amount_Submit_Method',
       'Personalized_Contract_Settlement_Amount_Submit_Method', '0836', '事件', '个性化合约结算金额的提交方式。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('定息日', 'Fixing_Date', 'Fixing_Date', '0837', '事件', '对应货币利率的定息日。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('支付类型', 'Payment_Type', 'Payment_Type', '0838', '事件', '会员机构进行资金支付时的不同类型。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('定息期天数', 'Fixed_Rate_Period_Days', 'Fixed_Rate_Period_Days', '0839', '事件', '定息期天数为计息期结束日减去计息期首日，算头不算尾。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('付息周期天数', 'Coupon_Payment_Period_Days', 'Coupon_Payment_Period_Days', '0840', '事件',
       '交易双方每隔一段固定的期限会向对方支付换入货币计算的利息金额，该期限即为付息周期。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('付息日期', 'Coupon_Payment_Date', 'Coupon_Payment_Date', '0841', '事件', '支付利息的具体日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate或者LegCouponPaymentDate或者UnderlyingCouponPaymentDate"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('首次支付日期', 'First_Payment_Date', 'First_Payment_Date', '0842', '事件', '首次支付的日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate或者LegCouponPaymentDate"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('平均利率', 'Average_Interest_Rate', 'Average_Interest_Rate', '0843', '事件', '一定支付周期内支付利率的平均值。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('支付周期应付利息', 'Payable_Interest_of_Payment_Cycle', 'Payable_Interest_of_Payment_Cycle', '0844', '事件', '支付周期的应付利息。',
       '{"1":{"IMIX域名":"AccruedInterestRate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('支付期本金金额', 'Capital_of_Pay_Period', 'Capital_of_Pay_Period', '0845', '事件', '支付周期内的本金金额。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('核对状态', 'Verification_Status', 'Verification_Status', '0846', '事件', '计算代理的核对状态。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('核对结果', 'Verification_Result', 'Verification_Result', '0847', '事件', '计算代理的核对结果。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('异议金额', 'Dissent_Amount', 'Dissent_Amount', '0848', '事件', '双方核对中出现不一致的金额。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('重置期首日', 'Reset_Period_on_the_First_Date', 'Reset_Period_on_the_First_Date', '0849', '事件', '重置利率的第一天。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('重置期结束日', 'Reset_Period_End_Date', 'Reset_Period_End_Date', '0850', '事件', '结束重置利率的日期。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('重置期天数', 'Reset_Period_Days', 'Reset_Period_Days', '0851', '事件', '重置期天数为重置期结束日减去重置期首日，算头不算尾。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('重置日确定日期', 'Determined_Date_of_the_Reset_Date', 'Determined_Date_of_the_Reset_Date', '0852', '事件', '确定利率重置的日期。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('重置利率', 'Reset_Interest_Rate', 'Reset_Interest_Rate', '0853', '事件', '重置后计算利息的利率。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('重置期当期本金', 'Current_Capital_on_Reset_Period', 'Current_Capital_on_Reset_Period', '0854', '事件', '利率重置期间的本金金额。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('重置期当期利息', 'Current_Interest_on_Reset_Period', 'Current_Interest_on_Reset_Period', '0855', '事件', '利率重置期间的利息。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('残段结束日', 'Stub_End_Date', 'Stub_End_Date', '0030', '事件', '利率互换中不完整计息期的结束日期。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('前后端残段标识', 'Stub_Indicator', 'Stub_Indicator', '0251', '事件', '标注利率互换交易是否存在前端或后端残段。',
       '{"1":{"IMIX域名":"StubIndicator"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('残段利息', 'Stub_Interest_Amount', 'Stub_Interest_Amount', '0033', '事件', '利率互换中不完整计息期的利息。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('残段支付日', 'Stub_Interest_Payment_Date', 'Stub_Interest_Payment_Date', '0031', '事件', '利率互换中不完整计息期利息的支付日。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('残段起始日', 'Stub_Start_Date', 'Stub_Start_Date', '0029', '事件', '利率互换中不完整计息期的起始日期。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('交谈历史记录数', 'Negotiation_Count', 'Negotiation_Count', '0275', '事件', '交易过程中交谈历史记录数。',
       '{"1":{"IMIX域名":"NegotiationCount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('意向报价会话类型', 'Indicative_Transaction_Type', 'Indicative_Transaction_Type', '0338', '事件', '对意向报价进行的操作的类型。',
       '{"1":{"IMIX域名":"IOITransType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('场次日期', 'Deal_Date', 'Deal_Date', '0438', '事件', '24小时交易中当前场次开市的日期。', '{"1":{"IMIX域名":"DateConfirmed"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('发送范围类型', 'Routing_Type', 'Routing_Type', '0386', '事件', '标注报价的发送范围是全部交易成员还是部分成员。',
       '{"1":{"IMIX域名":"RoutingType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('冲销方式', 'Writeoff_Method', 'Writeoff_Method', '1114', '事件', '会员机构资金冲销的方法。', '{"1":{"IMIX域名":"WriteOffMethod"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('申购状态', 'Subscription_Status', 'Subscription_Status', '1124', '事件', '用于表示申购的状态，分为未申购和已申购。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('订单状态', 'Order_Status', 'Order_Status', '0178', '事件', '交易员创建的订单在不同阶段所处的状态。', '{"1":{"IMIX域名":"OrdStatus"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('回价持续有效时间', 'Price_Sustained_Effective_Time', 'Price_Sustained_Effective_Time', '1140', '事件',
       '回价方回复价格的持续时间，回价有效的时间段。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('折算率', 'Conversion_Rate', 'Conversion_Rate', '1141', '事件', '基准货币或非基准货币对美元的折算率。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('非标准交易补充信息', 'Non_Standard_Transaction_Supplementary_Information',
       'Non_Standard_Transaction_Supplementary_Information', '1142', '事件', '货币掉期产品交易中，交易发起方可填写的补充协议。',
       '{"1":{"IMIX域名":"Text"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('原清算状态', 'Original_Clearing_Status', 'Original_Clearing_Status', '1146', '事件', '用于标识变更前的成交交易是否已清算。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('成交方式', 'Deal_Method', 'Deal_Method', '1216', '事件', '标识买卖双方达成交易的方式。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('本方异议金额', 'Party_Dissent_Amount', 'Party_Dissent_Amount', '1153', '事件', '双方核对中出现的本方不一致的金额。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('对手方异议金额', 'Counterparty_Dissent_Amount', 'Counterparty_Dissent_Amount', '1154', '事件', '双方核对中出现的对手方不一致的金额。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('重置期ID', 'Reset_Period_ID', 'Reset_Period_ID', '1156', '事件', '用于描述一笔交易中不同重置期生成的编号，用来标识各重置期内的现金流明细。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('利差上限', 'Spread_Upper_Limit', 'Spread_Upper_Limit', '1192', '事件', '系统设置的能输入的最大利差值，超过此利差值，系统给出相应提示信息。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('利差下限', 'Spread_Lower_Limit', 'Spread_Lower_Limit', '1193', '事件', '系统设置的能输入的最小利差值，低于此利差值，系统给出相应提示信息。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('结算状态', 'Settlement_Status', 'Settlement_Status', '1195', '事件', '用于标识一笔交易（包含备案交易）的结算信息的不同情况。',
       '{"1":{"IMIX域名":"SettlementStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('备案方式', 'Recorded_Deal_Method', 'Recorded_Deal_Method', '1196', '事件', '用于记录备案信息上传至系统的方式。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('合约价格', 'Contract_Price', 'Contract_Price', '1198', '事件', '用于记录特定产品的合约价格信息。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('盘中参考价', 'Intraday_Reference_Price', 'Intraday_Reference_Price', '1199', '事件', '与报价点差限制结合，作为用户进行有效报价的依据。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示盘中参考价）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('标准债券远期交割方式', 'Standard_Bond_Forward_Delivery_Method', 'Standard_Bond_Forward_Delivery_Method', '1200', '事件',
       '用于描述标准债券远期成交的交割方法。', '{"1":{"IMIX域名":"DeliveryForm"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('合约名称', 'Contract_Name', 'Contract_Name', '1201', '事件', '用于描述特定产品中合约标的的名称，如标准债券远期产品中的“3年期国债远期合约”。',
       '{"1":{"IMIX域名":"Symbol或者SecurityID_或者LegSecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('转换因子', 'Conversion_Factor', 'Conversion_Factor', '1202', '事件', '以合约对应虚拟债券的票面利率作为到期收益率，计算出的单位面值可交割债券的到期交割日净价。',
       '{"1":{"IMIX域名":"Factor"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('每日结算利率', 'Daily_Settlement_Rate', 'Daily_Settlement_Rate', '1203', '事件', '根据一定规则计算出的各合约的每日结算利率。',
       '{"1":{"IMIX域名":"MDEntryPx（JR/T_0066一般以“MarketData”组件中的Type域和Px域组合表示每日结算利率）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('到期结算利率', 'Settlement_Rate_to_Maturity', 'Settlement_Rate_to_Maturity', '1204', '事件', '根据一定规则计算出的各合约的到期结算利率。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('生效日', 'Effective_Date', 'Effective_Date', '0521', '公共数据', '某项业务、数据或功能在系统中可使用的日期。',
       '{"1":{"IMIX域名":"StartDate或者TransactTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('备注', 'Remark', 'Remark', '0303', '公共数据', '关于其他情况的说明。', '{"1":{"IMIX域名":"Text"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('参考利率/基准利率名称', 'Reference_Rate/Benchmark_Interest_Rate', 'Reference_Rate/Benchmark_Interest_Rate', '0374',
       '公共数据', '市场上具有普遍参照作用的利率，其他利率水平或金融资产价格均可根据这一基准利率水平来确定，交易双方约定用来确定浮动利率水平的利率指标。',
       '{"1":{"IMIX域名":"BenchmarkCurveName或者LegBenchmarkCurveName"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('到期日', 'Maturity_Date', 'Maturity_Date', '0232', '公共数据',
       '不同业务场景下到期日含义不同，具体如下：a）_证券本金偿还结束日或票据、存单等交易标的到期偿付日；b）_一笔衍生产品交易结束的日期；c）_货币掉期中指期末本金交换日和最后一次利息交换日；d）_期权中指期权买方选择是否行权的日期。',
       '{"1":{"IMIX域名":"MaturityDate或者EndDate或者SettlDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('计算方法', 'Calculation_Method', 'Calculation_Method', '0177', '公共数据', '即利息分配方式。债券或其他证券利息或收益率的计算规则。',
       '{"1":{"IMIX域名":"InterstAllocationMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('计算机构', 'Calculation_Agency', 'Calculation_Agency', '0645', '公共数据', '就一笔交易而言，交易双方约定的负责对支付义务进行具体计算的机构。',
       '{"1":{"IMIX域名":"CalculateAgency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易工具类型', 'Transaction_Tools_Type', 'Transaction_Tools_Type', '0900', '公共数据', '用于交易的核心标的物，一般为金融资产。',
       '{"1":{"IMIX域名":"ProductComplex"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('债券类型', 'Bond_Type', 'Bond_Type', '0203', '公共数据', '债券的细分种类。',
       '{"1":{"IMIX域名":"SecurityType或者UnderlyingSecurityType"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('债券代码', 'Bond_Code', 'Bond_Code', '0499', '公共数据', '债券流通托管机构公布的债券代码。',
       '{"1":{"IMIX域名":"SecurityID或者UnderlyingSecurityID或者LegSecurityID"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('债券名称', 'Bond_Name', 'Bond_Name', '0501', '公共数据', '债券的名称，在债券募集说明书或者流通要素公告中公布的债券名称。',
       '{"1":{"IMIX域名":"UnderlyingSymbol或者Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('债券简称', 'Bond_Short_Name', 'Bond_Short_Name', '0901', '公共数据', '债券的简称。', '{"1":{"IMIX域名":"Symbol"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('债券全称', 'Bond_Full_Name', 'Bond_Full_Name', '0902', '公共数据', '债券发行时的全称。', '{"1":{"IMIX域名":"FullSymbol"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('ISIN编码', 'ISIN_Code', 'ISIN_Code', '0903', '公共数据', '我国的ISIN编码，按照GB/T_21076—2017规定，ISIN编码为唯一地识别给定证券或其他金融工具的代码。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('货币网债券全称', 'Chinamoney_Bonds_Full_Name', 'Chinamoney_Bonds_Full_Name', '0904', '公共数据', '债券在货币网中展示的全称。',
       '{"1":{"IMIX域名":"FullSymbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('证券代码', 'Security_Code', 'Security_Code', '0905', '公共数据', '标识资产支持证券的唯一代码。', '{"1":{"IMIX域名":"SecurityID"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('证券名称', 'Security_Name', 'Security_Name', '0906', '公共数据', '资产支持证券的名称。',
       '{"1":{"IMIX域名":"Symbol或者MarginSymbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('凭证代码', 'Voucher_Code', 'Voucher_Code', '0908', '公共数据', '标识信用风险缓释凭证的唯一代码。', '{"1":{"IMIX域名":"SecurityID"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('凭证简称', 'Voucher_Short_Name', 'Voucher_Short_Name', '0909', '公共数据', '信用风险缓释凭证的简称。', '{"1":{"IMIX域名":"Symbol"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('凭证名称', 'Voucher_Name', 'Voucher_Name', '0910', '公共数据', '信用风险缓释凭证的名称。', '{"1":{"IMIX域名":"Symbol"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('货币对名称', 'Currency_Pair_Name', 'Currency_Pair_Name', '0123', '公共数据', '人民币对、外币对及贵金属货币对的名称。',
       '{"1":{"IMIX域名":"Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准货币', 'Base_Currency', 'Base_Currency', '0451', '公共数据', '货币代码，按照GB/T_12406规定，一个货币对中作为被计价标的的货币。',
       '{"1":{"IMIX域名":"Currency1"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('非基准货币', 'Term_Currency/Quote_Currency', 'Term_Currency/Quote_Currency', '0912', '公共数据',
       '货币代码，按照GB/T_12406规定，一个货币对中用于计量一个货币单位基准货币价格的货币，也称计价货币或相对货币。', '{"1":{"IMIX域名":"Currency2"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('发行量', 'Issue_Size', 'Issue_Size', '0382', '公共数据', '债券或其他证券的发行数量。', '{"1":{"IMIX域名":"IssueSize或者PosAmt"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('流通量', 'Circulation_Size', 'Circulation_Size', '0152', '公共数据', '债券或其他证券上市流通总量，如果有增发的情况，将更新。',
       '{"1":{"IMIX域名":"CirculationSize"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('当前流通总量', 'Current_Circulation_Total_Size', 'Current_Circulation_Total_Size', '0914', '公共数据',
       '债券或其他证券当前在市场上的流通总量。', '{"1":{"IMIX域名":"CirculationSize"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('面值', 'Face_Value', 'Face_Value', '0107', '公共数据',
       '债券的票面价值，是发行人对债券持有人在债券到期后应偿还的本金数额，也是企业向债券持有人按期支付利息的计算依据。债券的面值与债券实际的发行价格并不一定是一致的，发行价格大于面值称为溢价发行，等于面值称为平价发行，小于面值称为折价发行。',
       '{"1":{"IMIX域名":"FaceValue"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('发行价格', 'Issue_Price', 'Issue_Price', '0379', '公共数据',
       '债券、证券、存单等交易标的的出售价格或购买价格。发行价格不一定就是票面值，它可低于或高于票面值发行，按照债券发行价格与其票面值的关系，可分为平价发行、折价发行和溢价发行三种发行价格。',
       '{"1":{"IMIX域名":"IssuePx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('发行日期', 'Issue_Date', 'Issue_Date', '0376', '公共数据', '即发行起始日。债券或其他证券发行的日期，从该日期开始计算利息。',
       '{"1":{"IMIX域名":"IssueDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('上市交易日', 'Launch_Date', 'Launch_Date', '0256', '公共数据', '募集说明书中提到的债券在银行间市场的上市交易日。', '{"1":{"IMIX域名":"ListDate"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('摘牌日', 'Delisting_Date', 'Delisting_Date', '0915', '公共数据', '债券或其他证券在银行间市场的流通终止日。',
       '{"1":{"IMIX域名":"DelistDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易工具状态', 'Trading_Tools_Status', 'Trading_Tools_Status', '0916', '公共数据', '债券或其他证券在市场中所处的状态。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('债券期限', 'Bond_Term', 'Bond_Term', '0917', '公共数据', '在债券发行时就确定的债券还本的年限，债券的发行人到期应偿还本金。',
       '{"1":{"IMIX域名":"SecurityTerm或者SecurityTermString"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('托管机构', 'Custodian', 'Custodian', '0353', '公共数据', '为客户托管债券/证券的银行或者其他金融机构。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，托管机构由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('是否适用净额清算', 'Net_Settlement_Indicator', 'Net_Settlement_Indicator', '0918', '公共数据', '债券的交易是否可在清算机构进行净额清算。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('评级类型', 'Credit_Rating_Type', 'Credit_Rating_Type', '0919', '公共数据', '债券（证券、凭证）的评级分类。',
       '{"1":{"IMIX域名":"CreditRatingType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('主体评级', 'Subject_Rating', 'Subject_Rating', '0920', '公共数据', '以企业、经济主体为对象进行的信用评级，包含创设机构主体评级等。',
       '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('评级生效日', 'Rating_Effective_Date', 'Rating_Effective_Date', '0921', '公共数据', '信用评级的开始日期，适用于标的实体（主体、创设机构）和标的债务。',
       '{"1":{"IMIX域名":"CreditValidityFrom"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('评级截止日', 'Rating_Deadline', 'Rating_Deadline', '0922', '公共数据', '记录评级报告的截止日期，适用于标的实体（主体、创设机构）和标的债务。',
       '{"1":{"IMIX域名":"CreditValidityTo"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('评级公司/信用评级机构', 'Rating_Corporation/Credit_Rating_Institution', 'Rating_Corporation/Credit_Rating_Institution',
       '0923', '公共数据', '依法设立的从事信用评级业务的社会中介机构，由专门的经济、法律、财务专家组成的对证券发行人和证券信用进行等级评定的组织。',
       '{"1":{"IMIX域名":"CreditRatingAgency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('债项评级', 'Debt_Rating', 'Debt_Rating', '0924', '公共数据', '以企业或经济主体发行的有价债券或标的债务等为对象进行的信用评级。',
       '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('创设机构主体评级', 'Originators_Main_Rating', 'Originators_Main_Rating', '0925', '公共数据', '信用风险缓释凭证创设机构的信用评级。',
       '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('创设机构评级展望', 'Originators_Rating_Outlook', 'Originators_Rating_Outlook', '0926', '公共数据',
       '评级公司针对信用风险缓释凭证创设机构未来信用状况走向的预测。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('创设机构评级生效日', 'Originators_Rating_Effective_Date', 'Originators_Rating_Effective_Date', '0927', '公共数据',
       '信用风险缓释凭证创设机构信用评级的开始日期。', '{"1":{"IMIX域名":"CreditValidityFrom"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('创设机构评级截止日', 'Origitnators_Rating_Deadline', 'Origitnators_Rating_Deadline', '0928', '公共数据',
       '信用风险缓释凭证创设机构记录评级报告的截止日期。', '{"1":{"IMIX域名":"CreditValidityTo"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('创设机构评级公司', 'Originators_Rating_Corporation', 'Originators_Rating_Corporation', '0929', '公共数据',
       '对信用风险缓释凭证创设机构的资信进行等级评定的专业组织机构。', '{"1":{"IMIX域名":"CreditRatingAgency"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('标的实体主体评级', 'Underlying_Entity_Main_Rating', 'Underlying_Entity_Main_Rating', '0930', '公共数据',
       '信用风险缓释凭证债务相关机构的信用评级。', '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('标的实体评级展望', 'Underlying_Entity_Rating_Outlook', 'Underlying_Entity_Rating_Outlook', '0931', '公共数据',
       '评级公司针对信用风险缓释凭证债务机构未来信用状况走向的预测。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('标的实体评级生效日', 'Underlying_Entity_Rating_Effective_Date', 'Underlying_Entity_Rating_Effective_Date', '0932',
       '公共数据', '信用风险缓释凭证债务机构信用评级的开始日期。', '{"1":{"IMIX域名":"CreditValidityFrom"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('标的实体评级截止日', 'Underlying_Entity_Rating_Deadline', 'Underlying_Entity_Rating_Deadline', '0933', '公共数据',
       '信用风险缓释凭证债务机构记录评级报告的截止日期。', '{"1":{"IMIX域名":"CreditValidityTo"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('标的实体评级公司', 'Underlying_Entity_Rating_Corporation', 'Underlying_Entity_Rating_Corporation', '0934', '公共数据',
       '对信用风险缓释凭证债务机构的资信进行等级评定的专业组织机构。', '{"1":{"IMIX域名":"CreditRatingAgency"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('标的债务主体评级', 'Underlying_Debt_Main_Rating', 'Underlying_Debt_Main_Rating', '0935', '公共数据', '信用风险缓释凭证目标债务的信用评级。',
       '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('标的债务评级展望', 'Underlying_Debt_Rating_Outlook', 'Underlying_Debt_Rating_Outlook', '0936', '公共数据',
       '评级公司针对信用风险缓释凭证目标债务未来信用状况走向的预测。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('标的债务评级生效日', 'Underlying_Debt_Rating_Effective_Date', 'Underlying_Debt_Rating_Effective_Date', '0937', '公共数据',
       '信用风险缓释凭证目标债务信用评级的开始日期。', '{"1":{"IMIX域名":"CreditValidityFrom"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('标的债务评级截止日', 'Underlying_Debt_Rating_Deadline', 'Underlying_Debt_Rating_Deadline', '0938', '公共数据',
       '信用风险缓释凭证目标债务记录评级报告的截止日期。', '{"1":{"IMIX域名":"CreditValidityTo"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('标的债务评级公司', 'Underlying_Debt_Rating_Corporation', 'Underlying_Debt_Rating_Corporation', '0939', '公共数据',
       '对信用风险缓释凭证目标债务的资信进行等级评定的专业组织机构。', '{"1":{"IMIX域名":"CreditRatingAgency"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('息票类型', 'Coupon_Type', 'Coupon_Type', '0940', '公共数据', '债券付息方式分类。', '{"1":{"IMIX域名":"CouponRateType"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('付息频率', 'Coupon_Frequency', 'Coupon_Frequency', '0941', '公共数据', '该债券每年支付利息的次数。',
       '{"1":{"IMIX域名":"CouponPaymentFrequency或者LegCouponPaymentFrequency"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('首次付息日', 'First_Coupon_Payment_Date', 'First_Coupon_Payment_Date', '0942', '公共数据', '第一次支付利息的日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate或者CouponPaymentDate"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('票面利率', 'Coupon_Rate', 'Coupon_Rate', '0192', '公共数据',
       '债券利息与债券面值的比率，是发行人承诺以后一定时期支付给债券持有人报酬的计算标准。债券票面利率的确定主要受到银行利率、发行者的资信状况、偿还期限和利息计算方法以及当时资金市场上资金供求情况等因素的影响。',
       '{"1":{"IMIX域名":"CouponRate或者UnderlyingCouponRate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准利率参考日', 'Benchmark_Interest_Rate_Reference_Date', 'Benchmark_Interest_Rate_Reference_Date', '0943', '公共数据',
       '选取基准利率的日期。', '{"1":{"IMIX域名":"InterestFixDate或者LegInterestAccrualDate"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('基准利差', 'Benchmark_Spread_Rate', 'Benchmark_Spread_Rate', '0944', '公共数据',
       '用于浮动利率债，在基准利率基础上加上基准利差，用来确定浮动利率债的最终利率值。基准利差取值可正可负。', '{"1":{"IMIX域名":"Spread"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('首次基准利率', 'First_Benchmark_Rate', 'First_Benchmark_Rate', '0945', '公共数据', '发行机构首次添加的基准利率，用于计算首次利息支付。',
       '{"1":{"IMIX域名":"BenchmarkPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('当前基准利率', 'Current_Benchmark_Rate', 'Current_Benchmark_Rate', '0946', '公共数据', '当前计息周期内使用的基准利率。',
       '{"1":{"IMIX域名":"BenchmarkPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('参照基准的浮动利率', 'Reference_Benchmark_Floating_Rate', 'Reference_Benchmark_Floating_Rate', '0947', '公共数据',
       '资产支持证券参照基准利率的浮动利率。计算公式为：参照基准的浮动利率=当前基准利率+基本利差，当计算结果大于利率上限时取利率上限，当计算结果小于利率下限时取利率下限。',
       '{"1":{"IMIX域名":"BenchmarkPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('当前利率', 'Current_Interest_Rate', 'Current_Interest_Rate', '0948', '公共数据',
       '浮动债券当前的利率。计算公式为：“当前利率=基准利率值+基准利差”或“当前利率=首次基准利率+基准利差”，当计算结果大于利率上限时取利率上限，当计算结果小于利率下限时取利率下限。',
       '{"1":{"IMIX域名":"BenchmarkPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准利率确定日', 'Benchmark_Rate_Fixing_Date', 'Benchmark_Rate_Fixing_Date', '0949', '公共数据', '确定基准利率的日期。',
       '{"1":{"IMIX域名":"InterestAccrualDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准重置天数计算方法', 'Calculation_Method_of_Benchmark_Reset_Days', 'Calculation_Method_of_Benchmark_Reset_Days', '0950',
       '公共数据', '基准重置天数的计算方法。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('基准利率生效日', 'Benchmark_Rate_Effective_Date', 'Benchmark_Rate_Effective_Date', '0951', '公共数据', '基准利率开始生效的日期。',
       '{"1":{"IMIX域名":"BenchmarkEffectiveDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('基准利率类型', 'Benchmark_Rate_Type', 'Benchmark_Rate_Type', '0952', '公共数据', '中国人民银行公布的商业银行存贷款等业务的指导性利率类型。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('利率上限', 'Cap_Rate', 'Cap_Rate', '0213', '公共数据', '浮息债的最高票面利率。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('利率下限', 'Floor_Rate', 'Floor_Rate', '0212', '公共数据', '浮息债的最低票面利率。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('当前每百元本金', 'Current_Principal_Amount_Per_100_Yuan', 'Current_Principal_Amount_Per_100_Yuan', '0953', '公共数据',
       '当前利息支付期内每百元券面总额的本金。', '{"1":{"IMIX域名":"Principal"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('含权类型', 'Option-Embedded_Type', 'Option-Embedded_Type', '0954', '公共数据', '债券中所包含的不同权利的分类。相对于行权类型，静态描述含权信息。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('行权量', 'Exercise_Amount', 'Exercise_Amount', '0955', '公共数据', '发行人发行权证时所约定的，权证持有人向发行人购买或出售标的证券的数量。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('行权后利率/基准利差', 'Interest_Rate_after_Exercise/Benchmark_Interest_Rate_Spreads',
       'Interest_Rate_after_Exercise/Benchmark_Interest_Rate_Spreads', '0956', '公共数据',
       '根据行权类型行使选择权后债券的利率。若为固定收益债券，则对应行权后利率值；若为浮动利率债券，则对应基准利差值。', '{"1":{"IMIX域名":"Spread"}}', null, null, null, null,
       null, null, null, null, null, 2)
     ,('可转债类型', 'Conversion_Bond_Type', 'Conversion_Bond_Type', '0957', '公共数据', '可转换成其他证券的类型，包含部分转债和全部转债。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('转换比例', 'Conversion_Percentage', 'Conversion_Percentage', '0958', '公共数据',
       '转换比例不同场景下具有不同含义。具体包含以下三种解释：a）_约定的可转换比例；b）_赎回部分占面值的百分比；c）_一定面额可转换债券可转换成普通股票的股数。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('转换价格', 'Conversion_Price', 'Conversion_Price', '0102', '公共数据', '约定的转换价格或转换后的股票价格。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('转换日期', 'Conversion_Date', 'Conversion_Date', '0103', '公共数据', '可转债约定的转换为股票的日期。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('续发日期', 'Secondary_Date', 'Secondary_Date', '0959', '公共数据', '债券或其他证券再次发行的日期。', '{"1":{"IMIX域名":"ReissueDate"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('计划增发量', 'Planned_Reissuance_Quantity', 'Planned_Reissuance_Quantity', '0960', '公共数据', '债券或其他证券再次发行时的计划发行量。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('实际续发量', 'Actual_Secondary_Quantity', 'Actual_Secondary_Quantity', '0961', '公共数据', '债券或其他证券再次发行时的实际发行量。',
       '{"1":{"IMIX域名":"ReissueSize"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前还本日期', 'Prepayment_Date', 'Prepayment_Date', '0962', '公共数据', '债券提前还本的日期。',
       '{"1":{"IMIX域名":"RedemptionDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('提前还本金额', 'Prepayment_Amount', 'Prepayment_Amount', '0963', '公共数据', '债券提前还本的金额。',
       '{"1":{"IMIX域名":"RedemptionOfFaceValue"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('初始投资人数量', 'Number_of_Initial_Investors', 'Number_of_Initial_Investors', '0964', '公共数据', '定向工具发行的初始投资人数量。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('投资人范围', 'Investors_Range', 'Investors_Range', '0965', '公共数据', '定向工具的投资人范围。',
       '{"1":{"IMIX域名":"PartyDetailAltSubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，投资人范围由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('停牌起始日', 'Suspended_Start_Date', 'Suspended_Start_Date', '0198', '公共数据', '债券或其他证券暂停交易的起始日。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('停牌终止日', 'Suspended_End_Date', 'Suspended_End_Date', '0197', '公共数据', '债券或其他证券暂停交易的终止日。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('停牌原因', 'Suspended_Reason', 'Suspended_Reason', '0200', '公共数据', '债券或其他证券暂停交易的原因。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('摘牌日期（交易所）', 'Delisting_Date（Exchange）', 'Delisting_Date（Exchange）', '0966', '公共数据', '债券在交易所摘牌，停止进行交易的日期。',
       '{"1":{"IMIX域名":"DelistDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('发行人昵称', 'Issuer_Nickname', 'Issuer_Nickname', '0967', '公共数据', '集合类债券发行人的名称。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('发行人全称', 'Issuer_Full_Name', 'Issuer_Full_Name', '0968', '公共数据', '证券发行人经过相关权威部门审核准许使用的具有法律效力的名称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，发行人全称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('发行额度', 'Issue_Amount', 'Issue_Amount', '0969', '公共数据', '发行债券、证券、存单等交易标的的面值总额。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('发行类型', 'Issue_Type', 'Issue_Type', '0970', '公共数据', '预发行市场独有，类型包括新发、续发。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('计划发行量', 'Planned_Circulation', 'Planned_Circulation', '0971', '公共数据', '债券、证券、大额存单等交易标的正式招标之前计划发行的数量。',
       '{"1":{"IMIX域名":"IssueSizeForPlan"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('实际发行量', 'Actual_Circulation', 'Actual_Circulation', '0972', '公共数据', '债券正式招标之后实际发行的债券量。',
       '{"1":{"IMIX域名":"IssueSize"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首发价格', 'First_Starting_Price', 'First_Starting_Price', '0973', '公共数据', '发行类型为续发的债券新发时的价格。',
       '{"1":{"IMIX域名":"IssuePx"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('招标日', 'Tendering_Date', 'Tendering_Date', '0974', '公共数据', '债券发行过程中的招标日期。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示招标日）"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('缴款日', 'Payment_Date', 'Payment_Date', '0975', '公共数据', '债券发行过程中的机构缴款日期。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示缴款日）"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('上市流通日', 'Listing_Date', 'Listing_Date', '1214', '公共数据', '债券或其他证券正式发行后在市场上市交易的日期。',
       '{"1":{"IMIX域名":"ListDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('预发行开始日', 'Prerelease_Start_Date', 'Prerelease_Start_Date', '0976', '公共数据', '预发行债券的开始日期，为起息日后第一个工作日。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('预发行结束日', 'Prerelease_End_Date', 'Prerelease_End_Date', '0977', '公共数据', '预发行债券的结束日期，为起息日后第四个工作日。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('净卖出总限额', 'Total_Limit_Amount_of_Net_Sell', 'Total_Limit_Amount_of_Net_Sell', '0978', '公共数据',
       '净卖出总限额是对卖出减去买入的额度控制，当卖出减去买入超过该额度值就不能再卖出。净卖出总限额的计算公式为：净卖出总限额=发行量（或计划发行量）×净卖出总限额百分比，净卖出总限额百分比可人工配置。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('预期到期日', 'Expected_Maturity_Date', 'Expected_Maturity_Date', '0979', '公共数据', '按照计划向投资者偿付本金的日期。',
       '{"1":{"IMIX域名":"ExpectedMaturityDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('法定到期日', 'Legal_Maturity_Date', 'Legal_Maturity_Date', '0980', '公共数据', '应向投资者偿付本金的日期。',
       '{"1":{"IMIX域名":"LegalMaturityDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('实际到期日', 'Actual_Maturity_Date', 'Actual_Maturity_Date', '0317', '公共数据', '实际的证券到期日。',
       '{"1":{"IMIX域名":"ActualMaturityDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('证券期限', 'Security_Terms', 'Security_Terms', '0115', '公共数据', '发行日至预期到期日的期限，若无预期到期日，则为发行日至法定到期日的期限。',
       '{"1":{"IMIX域名":"SecurityTerm"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('初始每百元本金额', 'Initial_Principal_Amount_Per_100_Yuan', 'Initial_Principal_Amount_Per_100_Yuan', '0981', '公共数据',
       '资产支持证券发行时的票面金额。', '{"1":{"IMIX域名":"Principal"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('当前每百元本金额', 'Current_Principal_Amount_Per_100_Yuan', 'Current_Principal_Amount_Per_100_Yuan', '0982', '公共数据',
       '资产支持证券当前付息周期内的票面金额。', '{"1":{"IMIX域名":"Principal"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('下一每百元本金额', 'Next_Principal_Amount_Per_100_Yuan', 'Next_Principal_Amount_Per_100_Yuan', '0983', '公共数据',
       '下一周期的票面金额。', '{"1":{"IMIX域名":"Principal"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('资产支持证券当前流通总量', 'ABS_Current_Circulation_Size', 'ABS_Current_Circulation_Size', '0984', '公共数据',
       '资产支持证券当前的流通总量，资产支持证券当前流通总量的计算公式为：资产支持证券当前流通总量=当前每百元本金额×流通总量。', '{"1":{"IMIX域名":"CirculationSize"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('本金支付频率', 'Principal_Payment_Frequency', 'Principal_Payment_Frequency', '0010', '公共数据', '资产支持证券支付本金的时间周期。',
       '{"1":{"IMIX域名":"PrincipalPayFrequency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首次本金支付日', 'First_Coupon_Payment_Date', 'First_Coupon_Payment_Date', '1215', '公共数据',
       '资产支持证券第一次支付本金的日期。应满足以下三个条件：a）_晚于发行日期；b）_晚于上市交易日；c）_早于摘牌日。', '{"1":{"IMIX域名":"PaymentDate"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('当前资产池收益率', 'Current_Asset_Pool_Yield', 'Current_Asset_Pool_Yield', '0985', '公共数据', '资产支持证券当前阶段的资产池收益率。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('下一资产池收益率', 'Next_Asset_Pool_Yield', 'Next_Asset_Pool_Yield', '0986', '公共数据', '资产支持证券下一周期的资产池收益率。',
       '{"1":{"IMIX域名":"StipulationValue（JR/T_0066一般以“Stipulation”组件中的Type域和Value域组合表示下一资产池收益率）"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('标的实体', 'Underlying_Entity', 'Underlying_Entity', '0987', '公共数据', '与信用风险缓释凭证标的债务有关的实体。',
       '{"1":{"IMIX域名":"UnderlyingIssuer"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('标的债务', 'Underlying_Debt', 'Underlying_Debt', '0988', '公共数据', '信用风险缓释凭证的目标债务。',
       '{"1":{"IMIX域名":"UnderlyingSecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('标的债务流通总量', 'Underlying_Debt_Circulation_Size', 'Underlying_Debt_Circulation_Size', '0989', '公共数据',
       '标的债务的上市流通总数量。', '{"1":{"IMIX域名":"UnderlyingQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('名义本金总额', 'Notional_Principal_Amount', 'Notional_Principal_Amount', '0990', '公共数据',
       '在协议中所确定的债券或其他证券的发行规模，即要上市流通的资金数额。', '{"1":{"IMIX域名":"IssueSize"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('创设价格', 'Creation_Price', 'Creation_Price', '0991', '公共数据', '创设机构创设信用风险缓释凭证的价格。', '{"1":{"IMIX域名":"IssuePx"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('单位名义本金', 'Unit_Notional_Principal', 'Unit_Notional_Principal', '0992', '公共数据', '每一单位的名义本金额，创设价格对应的单位名义本金金额。',
       '{"1":{"IMIX域名":"FaceValue"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('凭证注销机制', 'Certificate_Revocation_Mechanism', 'Certificate_Revocation_Mechanism', '0993', '公共数据',
       '信用风险缓释凭证的注销机制。', '{"1":{"IMIX域名":"WithDrawIndic"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('创设日', 'Creation_Date', 'Creation_Date', '0994', '公共数据', '信用风险缓释凭证创设日期。', '{"1":{"IMIX域名":"IssueDate"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('流通日', 'Circulation_Date', 'Circulation_Date', '0995', '公共数据', '信用风险缓释凭证进行交易的日期。', '{"1":{"IMIX域名":"ListDate"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('登记确权日', 'Registration_Confirmation_Date', 'Registration_Confirmation_Date', '0996', '公共数据',
       '创设机构申请凭证初始登记，在托管机构登记确权的日期。', '{"1":{"IMIX域名":"DatedDate"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('收费方式', 'Charging_Method', 'Charging_Method', '0997', '公共数据', '依据不同的收费频率对收费方式进行的分类。',
       '{"1":{"IMIX域名":"FeeMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('首次付费日', 'First_Payment_Date', 'First_Payment_Date', '0998', '公共数据', '会员机构首次接入收费系统或其他计费平台的日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('信用事件', 'Credit_Event', 'Credit_Event', '0999', '公共数据', '交易双方在相关交易有效约定中就一笔信用衍生品交易约定的触发结算赔付的事件。',
       '{"1":{"IMIX域名":"EventType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('违约结算方式', 'Breach_Settlement_Method', 'Breach_Settlement_Method', '1000', '公共数据', '违约情况下的实物结算、现金结算或其他方式。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('货币对类型', 'Currency_Pair_Type', 'Currency_Pair_Type', '1001', '公共数据', '货币对的分类。',
       '{"1":{"IMIX域名":"CNYTradedIndic"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('货币名称', 'Currency_Name', 'Currency_Name', '1002', '公共数据',
       '按照GB/T_12406规定，货币名称有如下两种解释：a）_货币在系统中的名称；b）_一笔交易中涉及的币种，用以计算交易所占用的额度。', '{"1":{"IMIX域名":"Currency"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('货币类型名称', 'Currency_Type_Name', 'Currency_Type_Name', '1003', '公共数据', '货币分类的名称，如人民币、外币、贵金属。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('最小交易金额', 'Minimum_Transaction_Amount', 'Minimum_Transaction_Amount', '1004', '公共数据', '交易员可输入的交易金额的最小允许值。',
       '{"1":{"IMIX域名":"MinQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('最大交易金额', 'Maximum_Transaction_Amount', 'Maximum_Transaction_Amount', '1005', '公共数据', '交易员可输入的交易金额的最大允许值。',
       '{"1":{"IMIX域名":"MaxQty"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('价格波动区间', 'Price_Range', 'Price_Range', '1006', '公共数据', '交易价格相对于中间价的波动区间。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('每标位最低投标量', 'Lowest_Bid_Amount_Per_Standard_Bit', 'Lowest_Bid_Amount_Per_Standard_Bit', '1007', '公共数据',
       '同业存单招标发行时每标位所允许的最小投标数量。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('每标位最高投标量', 'Highest_Bid_Amount_Per_Standard_Bit', 'Highest_Bid_Amount_Per_Standard_Bit', '1008', '公共数据',
       '同业存单招标发行时每标位所允许的最大投标数量。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('最低标位', 'Lowest_Standard_Bit', 'Lowest_Standard_Bit', '1009', '公共数据', '同业存单招标发行时的最小标位。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('最高标位', 'Highest_Standard_Bit', 'Highest_Standard_Bit', '1010', '公共数据', '同业存单招标发行时的最大标位。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('最大投标标位数', 'Maximum_Bid_Marked', 'Maximum_Bid_Marked', '1011', '公共数据', '同业存单招标发行时所允许的最大标位的位数。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('最大投标标位差', 'Maximum_Bid_Marked_Difference', 'Maximum_Bid_Marked_Difference', '1012', '公共数据',
       '同业存单招标发行时所允许的最大的标位差，最大投标标位差的计算公式为：最大投标标位差=最高标位-最低标位。', null, null, null, null, null, null, null, null, null,
       null, 2)
     ,('最高投标量', 'Highest_Bid_Amount', 'Highest_Bid_Amount', '1013', '公共数据', '同业存单招标发行时系统所能允许会员机构进行的最大投标金额。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('连续投标限制', 'Continuous_Bid_Limit', 'Continuous_Bid_Limit', '1014', '公共数据', '限制投标人根据步长，在连续的标位上进行投标。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('投标步长', 'Tender_Step', 'Tender_Step', '1015', '公共数据', '投标人更新投标额时投标额每次变动的固定值。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('最低认购总量', 'Minimum_Subscription_Amount', 'Minimum_Subscription_Amount', '1016', '公共数据', '报价拍卖下投标人的最小认购金额。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('最高认购总量', 'Maximum_Subscription_Amount', 'Maximum_Subscription_Amount', '1017', '公共数据', '报价拍卖下投标人的最大认购金额。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('单笔最低认购量', 'Single_Minimum_Subscription_Amount', 'Single_Minimum_Subscription_Amount', '1018', '公共数据',
       '报价拍卖下投标人单笔交易的最小认购金额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('单笔最高认购量', 'Single_Maximum_Subscription_Amount', 'Single_Maximum_Subscription_Amount', '1019', '公共数据',
       '报价拍卖下投标人单笔交易的最大认购金额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单代码', 'Interbank_Certificates_of_Deposit_Code', 'Interbank_Certificates_of_Deposit_Code', '1020', '公共数据',
       '同业存单发行时系统生成的唯一编码。', '{"1":{"IMIX域名":"SecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单全称', 'Interbank_Certificates_of_Deposit_Full_Name', 'Interbank_Certificates_of_Deposit_Full_Name', '1021',
       '公共数据', '同业存单在系统中的全称。', '{"1":{"IMIX域名":"FullSymbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单简称', 'Interbank_Certificates_of_Deposit_Short_Name', 'Interbank_Certificates_of_Deposit_Short_Name', '1022',
       '公共数据', '同业存单在系统中的简称。', '{"1":{"IMIX域名":"Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('注册书编号', 'Registration_File_Number', 'Registration_File_Number', '1023', '公共数据', '发行人机构的注册书编号，用于识别发行人身份。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单发行人', 'Interbank_Certificates_of_Deposit_Issuer', 'Interbank_Certificates_of_Deposit_Issuer', '1024',
       '公共数据', '发行同业存单的机构在系统中的名称。',
       '{"1":{"IMIX域名":"PartyDetailAltSubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，同业存单发行人由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('主体评级机构', 'Main_Rating_Agency', 'Main_Rating_Agency', '1025', '公共数据', '对同业存单发行人进行等级评定的组织或机构。',
       '{"1":{"IMIX域名":"CreditRatingAgency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('主体评级等级', 'Main_Rating_Rank', 'Main_Rating_Rank', '1026', '公共数据', '针对同业存单、大额存单等交易标的发行人进行的具体信用等级评定。',
       '{"1":{"IMIX域名":"CreditRating"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单发行方式', 'Interbank_Certificates_of_Deposit_Distribution_Method',
       'Interbank_Certificates_of_Deposit_Distribution_Method', '1027', '公共数据', '同业存单发行的方式。',
       '{"1":{"IMIX域名":"IssueMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单招标方式', 'Interbank_Certificates_of_Deposit_Tender_Method', 'Interbank_Certificates_of_Deposit_Tender_Method',
       '1028', '公共数据', '同业存单招标发行时选择的招标方式。', '{"1":{"IMIX域名":"IssueMethod"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('招标标的', 'Tender_Underlying', 'Tender_Underlying', '1029', '公共数据', '进行单一价格招标时，单一价格的对象。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('同业存单计划发行量', 'Interbank_Certificates_of_Deposit_Planned_Circulation',
       'Interbank_Certificates_of_Deposit_Planned_Circulation', '1030', '公共数据', '同业存单计划发行的总金额。',
       '{"1":{"IMIX域名":"IssueSizeForPlan"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('最低发行量', 'Minimum_Circulation', 'Minimum_Circulation', '1031', '公共数据', '政策法规或系统所能允许的最小发行金额。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('同业存单息票类型', 'Interbank_Certificates_of_Deposit_Coupon_Type', 'Interbank_Certificates_of_Deposit_Coupon_Type',
       '1032', '公共数据', '同业存单计算利息的类型。', '{"1":{"IMIX域名":"CouponRateType"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('同业存单期限', 'Interbank_Certificates_of_Deposit_Term', 'Interbank_Certificates_of_Deposit_Term', '1033', '公共数据',
       '同业存单发行时所涵盖的期限。', '{"1":{"IMIX域名":"SecurityTerm"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单面值', 'Interbank_Certificates_of_Deposit_Face_Value', 'Interbank_Certificates_of_Deposit_Face_Value', '1034',
       '公共数据', '同业存单票面上标注的价格。', '{"1":{"IMIX域名":"FaceValue"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单发行价格', 'Interbank_Certificates_of_Deposit_Issue_Price', 'Interbank_Certificates_of_Deposit_Issue_Price',
       '1035', '公共数据', '同业存单发行的价格。', '{"1":{"IMIX域名":"IssuePx"}}', null, null, null, null, null, null, null, null, null,
       2)
     ,('同业存单基准利率', 'Interbank_Certificates_of_Deposit_Benchmark_Rate',
       'Interbank_Certificates_of_Deposit_Benchmark_Rate', '1036', '公共数据', '同业存单计息时所针对的基准利率。',
       '{"1":{"IMIX域名":"BenchmarkPrice"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单基准利率精度', 'Interbank_Certificates_of_Deposit_Benchmark_Rate_Precision',
       'Interbank_Certificates_of_Deposit_Benchmark_Rate_Precision', '1037', '公共数据',
       '用于同业存单中利差的换算单位。如利差为30，当精度设置为2时表示小数点往前移动2位，此时换算后的利率为0.30。', '{"1":{"IMIX域名":"DecimalPlaces"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('参考收益率', 'Reference_Yield', 'Reference_Yield', '1038', '公共数据',
       '据历史业绩得出的收益率的参考值，在一定程度上反映基金或债券等未来的成长方向，不能真正代表未来收益率。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('同业存单付息频率', 'Interbank_Certificates_of_Deposit_Coupon_Frequency',
       'Interbank_Certificates_of_Deposit_Coupon_Frequency', '1039', '公共数据', '同业存单支付利息的周期。',
       '{"1":{"IMIX域名":"CouponPaymentFrequency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单计息基准', 'Interbank_Certificates_of_Deposit_Interest_Basis',
       'Interbank_Certificates_of_Deposit_Interest_Basis', '1040', '公共数据', '同业存单计算利息时关于计息天数的处理规则。',
       '{"1":{"IMIX域名":"DayCount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单起息日', 'Interbank_Certificates_of_Deposit_Value_Date', 'Interbank_Certificates_of_Deposit_Value_Date',
       '1041', '公共数据', '同业存单开始计算利息的日期。', '{"1":{"IMIX域名":"SettlDate"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('同业存单首次付息日', 'Interbank_Certificates_of_Deposit_First_Coupon_Payment_Date',
       'Interbank_Certificates_of_Deposit_First_Coupon_Payment_Date', '1042', '公共数据', '同业存单首次支付利息的日期。',
       '{"1":{"IMIX域名":"CouponPaymentDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单到期日', 'Interbank_Certificates_of_Deposit_Maturity_Date', 'Interbank_Certificates_of_Deposit_Maturity_Date',
       '1043', '公共数据', '同业存单到期进行交割的日期。', '{"1":{"IMIX域名":"MaturityDate"}}', null, null, null, null, null, null, null,
       null, null, 2)
     ,('兑付日', 'Payment_Date', 'Payment_Date', '1044', '公共数据', '同业存单、大额存单等交易标的进行资金兑付的日期。',
       '{"1":{"IMIX域名":"PaymentDate"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('同业存单缴款日', 'Interbank_Certificates_of_Deposit_Payment_Date', 'Interbank_Certificates_of_Deposit_Payment_Date',
       '1045', '公共数据', '同业存单缴纳款项的日期。', '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示同业存单缴款日）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('发行开始时间', 'Issue_Start_Time', 'Issue_Start_Time', '1046', '公共数据', '同业存单开始发行的时间。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示发行开始时间）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('发行结束时间', 'Issue_End_Time', 'Issue_End_Time', '1047', '公共数据', '同业存单发行结束的时间。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示发行结束时间）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('同业存单状态', 'Interbank_Certificates_of_Deposit_Status', 'Interbank_Certificates_of_Deposit_Status', '1048', '公共数据',
       '同业存单在系统中所处的状态。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('投标倍数', 'Tender_Multiples', 'Tender_Multiples', '1049', '公共数据', '投标倍数的计算公式为：投标倍数=投标总量÷计划发行总量。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('债券状态', 'Bond_Status', 'Bond_Status', '1134', '公共数据', '用于描述债券基础信息在系统中所处的状态。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('行权类型', 'Exercise_Type', 'Exercise_Type', '1135', '公共数据', '债券中所包含的不同权利的分类。相对于含权类型，动态描述行权信息。',
       '{"1":{"IMIX域名":"EventType"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('债券父类型', 'Bond_Parent_Type', 'Bond_Parent_Type', '1137', '公共数据',
       '债券类型的分类，包含利率债、信用债、同业存单，其中利率债又包含国债、地方政府债券、政策性金融债和央行票据等不同类型的债券。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('质押券代码', 'Pledged_Bond_Code', 'Pledged_Bond_Code', '1144', '公共数据', '交易过程中质押的债券、资产支持证券等证券的代码。',
       '{"1":{"IMIX域名":"UnderlyingSecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('自律机制备案编码', 'Self_Regulatory_Mechanism_Code', 'Self_Regulatory_Mechanism_Code', '1159', '公共数据',
       '大额存单信息复核完成后，系统自动生成的唯一编码。', '{"1":{"IMIX域名":"SecurityID"}}', null, null, null, null, null, null, null, null,
       null, 2)
     ,('大额存单代码', 'CDs_Code', 'CDs_Code', '1160', '公共数据', '发行机构发行大额存单时制定的代码。', '{"1":{"IMIX域名":"DepositID"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('大额存单全称', 'CDs_Full_Name', 'CDs_Full_Name', '1161', '公共数据', '发行机构发行大额存单时指定的大额存单全称描述。',
       '{"1":{"IMIX域名":"FullSymbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单简称', 'CDs_Short_Name', 'CDs_Short_Name', '1162', '公共数据', '发行机构发行大额存单时指定的大额存单简称描述。',
       '{"1":{"IMIX域名":"Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('起存金额', 'Original_Deposit', 'Original_Deposit', '1163', '公共数据', '投资人认购大额存单的最低认购量。',
       '{"1":{"IMIX域名":"MinLotSize"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('发行途径', 'Issue_Approach', 'Issue_Approach', '1166', '公共数据', '大额存单等交易标的的发行路径。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('大额存单发行方式', 'CDs_Issue_Mode', 'CDs_Issue_Mode', '1168', '公共数据', '发行机构发行大额存单的具体方法。',
       '{"1":{"IMIX域名":"IssueMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('实际认购量', 'Actual_Subscription_Amount', 'Actual_Subscription_Amount', '1169', '公共数据', '发行机构发行的大额存单等交易标的被实际购买的金额。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('计息类型', 'Interest_Type', 'Interest_Type', '1170', '公共数据', '利息计算时使用的不同利息分类。', '{"1":{"IMIX域名":"CouponRateType"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单期限', 'CDs_Period', 'CDs_Period', '1171', '公共数据', '大额存单的发行期限，超过此期限，大额存单即到期。',
       '{"1":{"IMIX域名":"SecurityTerm"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单利率上限', 'CDs_Cap_Rate', 'CDs_Cap_Rate', '1172', '公共数据', '大额存单发行人支付的上限利率。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('大额存单利率下限', 'CDs_Floor_Rate', 'CDs_Floor_Rate', '1173', '公共数据', '大额存单发行人支付的下限利率。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('大额存单基准利率精度', 'CDs_Benchmark_Rate_Precision', 'CDs_Benchmark_Rate_Precision', '1174', '公共数据',
       '用于大额存单中利差的换算单位。如利差为30，当精度设置为2时表示小数点往前移动2位，此时换算后的利率为0.30。', '{"1":{"IMIX域名":"DecimalPlaces"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('大额存单付息频率', 'CDs_Coupon_Frequency', 'CDs_Coupon_Frequency', '1175', '公共数据', '用于描述大额存单进行利息支付的周期。',
       '{"1":{"IMIX域名":"CouponPaymentFrequency"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单发行开始时间', 'CDs_Issue_Start_Time', 'CDs_Issue_Start_Time', '1176', '公共数据', '发行机构发行大额存单的具体开始时间。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示大额存单发行开始时间）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('大额存单发行结束时间', 'CDs_Issue_End_Time', 'CDs_Issue_End_Time', '1177', '公共数据', '发行机构发行大额存单的具体结束时间。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和Date域组合表示大额存单发行结束时间）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('最小变动单位', 'Minimum_Changeable_Unit', 'Minimum_Changeable_Unit', '0085', '公共数据', '大额存单等交易标的进行报价等活动时最小的变动步长。',
       '{"1":{"IMIX域名":"MinTickSize"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('是否对外披露', 'Disclosure_Indicator', 'Disclosure_Indicator', '1178', '公共数据', '用于描述发行机构的大额存单等交易标的的发行要素等信息是否对外公开。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('提前赎回条件', 'Early_Redemption_Conditions', 'Early_Redemption_Conditions', '1179', '公共数据',
       '用于描述大额存单等交易标的进行提前赎回时的条件。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('提前支取条件', 'Early_Withdraw_Conditions', 'Early_Withdraw_Conditions', '1180', '公共数据', '用于描述大额存单等交易标的进行提前支取时的条件。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单发行状态', 'CDs_Issue_Status', 'CDs_Issue_Status', '1181', '公共数据', '用于描述大额存单发行成功前在系统中所处的状态。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('提交用户ID', 'Submit_User_ID', 'Submit_User_ID', '1182', '公共数据', '大额存单发行要素录入的机构用户登录名。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('复核用户ID', 'Review_User_ID', 'Review_User_ID', '标示符：1183', '公共数据', '大额存单发行要素复核的机构用户登录名。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('场务确认用户ID', 'MSC_Confirm_User_ID', 'MSC_Confirm_User_ID', '1184', '公共数据', '场务对存单信息进行确认的用户登录名。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('发行结果录入用户ID', 'Issue_Results_Entry_User_ID', 'Issue_Results_Entry_User_ID', '1185', '公共数据',
       '大额存单发行结果录入的机构用户登录名。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('发行结果复核用户ID', 'Issue_Results_Review_User_ID', 'Issue_Results_Review_User_ID', '1186', '公共数据',
       '大额存单发行结果录入信息复核的机构用户登录名。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('大额存单状态', 'CDs_Status', 'CDs_Status', '1187', '公共数据', '用于描述发行成功的大额存单在系统中所处的状态。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('流通范围', 'Circulation_Scope', 'Circulation_Scope', '1205', '公共数据',
       '用于描述存单交易流通的范围，包含公开发行、定向发行。具体内容如下：a）_公开发行的同业存单可进行交易流通，并可作为回购交易的标的物；b）_定向发行的同业存单只能在该只同业存单初始投资人范围内流通转让。',
       '{"1":{"IMIX域名":"TradePublishIndicator"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('期限标识', 'Period_Indicator', 'Period_Indicator', '1206', '公共数据', '用于描述存单发行时所指的期限。',
       '{"1":{"IMIX域名":"SecurityTerm"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('定向期限代码', 'Directional_Period_Code', 'Directional_Period_Code', '1207', '公共数据', '用于描述定向发行的存单期限的唯一标识。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('定向期限值', 'Directional_Period_Value', 'Directional_Period_Value', '1208', '公共数据',
       '用于记录定向发行的存单的具体期限值，依据存单的到期日进行推算得出。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('交易日', 'Trading_Date', 'Trading_Date', '0462', '条件',
       '根据不同应用场景，具体有以下两种业务解释：a）_交易双方达成一笔交易的日期，此时同“成交日期”；b）_各交易品种可在银行间外汇市场进行交易的日期。', '{"1":{"IMIX域名":"TradeDate"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('假日类型', 'Holiday_Type', 'Holiday_Type', '0856', '条件', '依据可执行业务的不同对假日进行的区分。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('假日日期', 'Holiday_Date', 'Holiday_Date', '0857', '条件', '具体的节假日日期。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('年度', 'Year', 'Year', '0858', '条件', '日期所属的年份。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('假日事件描述', 'Holiday_Description', 'Holiday_Description', '0859', '条件', '对于假日事件的简单描述。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('假日表名称', 'Calendar_Table_Name', 'Calendar_Table_Name', '0860', '条件', '交易假日表、清算假日表的名称。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('交易时段类型', 'Trading_Session_Type', 'Trading_Session_Type', '0861', '条件', '对交易时段的分类。',
       '{"1":{"IMIX域名":"TradSesStatus"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('市场可操作类型', 'Market_Available_Operation_Type', 'Market_Available_Operation_Type', '0862', '条件',
       '用于描述市场在不同的交易时段内能进行的操作类型。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('交易时段状态', 'Trading_Hour_Status', 'Trading_Hour_Status', '0863', '条件', '交易时段在系统中所处的状态。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('默认开始时间', 'Default_Start_Time', 'Default_Start_Time', '0864', '条件', '交易时段类型的默认开始时间。',
       '{"1":{"IMIX域名":"TradSesStartTime或者TradSesOpenTime"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('默认结束时间', 'Default_End_Time', 'Default_End_Time', '0865', '条件', '交易时段类型的默认结束时间。',
       '{"1":{"IMIX域名":"TradSesPreCloseTime或者TradSesCloseTime或者TradSesEndTime"}}', null, null, null, null, null, null,
       null, null, null, 2)
     ,('交易时段类型权限配置名称', 'Permission_Configuration_Name_of_Trading_Session_Type',
       'Permission_Configuration_Name_of_Trading_Session_Type', '0866', '条件', '用于描述市场中各交易时段类型对应的权限。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('计费办法名称', 'Fee_Method_Name', 'Fee_Method_Name', '0867', '条件', '计费办法的名称。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('交易费率名称', 'Trading_Fee_Rate_Name', 'Trading_Fee_Rate_Name', '0868', '条件', '交易费率的名称。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('交易发起方标识', 'Taker_Indicator', 'Taker_Indicator', '0869', '条件', '用来区分一笔交易中的发起方和接收方。',
       '{"1":{"IMIX域名":"PartyRole"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('交易费率值', 'Trading_Fee_Rate_Value', 'Trading_Fee_Rate_Value', '0870', '条件', '交易费用计算的参数值。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('交易费率值描述', 'Trading_Fee_Rate_Value_Description', 'Trading_Fee_Rate_Value_Description', '0871', '条件',
       '针对交易费率值的说明。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('临界方式类型', 'Critical_Bound_Mode_Type', 'Critical_Bound_Mode_Type', '0872', '条件', '当交易费用达到优惠区间的边界时确定计费费率的方式。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('优惠值', 'Discount_Value', 'Discount_Value', '0873', '条件', '特殊优惠的触发值。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('左端值', 'Left_End_Value', 'Left_End_Value', '0874', '条件', '优惠区间的起始值。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('右端值', 'Right_End_Value', 'Right_End_Value', '0875', '条件', '优惠区间的结束值。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('特殊费率名称', 'Name_0f_Special_Fee_Rate', 'Name_0f_Special_Fee_Rate', '0876', '条件', '特殊费率在系统中的名称。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('特殊费率值', 'Special_Fee_Rate_Value', 'Special_Fee_Rate_Value', '0877', '条件', '计算特殊费率的参数值。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('特殊费率值描述', 'Description_of_Special_Fee_Rate_Value', 'Description_of_Special_Fee_Rate_Value', '0878', '条件',
       '针对特殊费率值的说明。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('终端类型', 'Terminal_Type', 'Terminal_Type', '0879', '条件', '依据会员机构的不同身份划分的终端计费类型。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('终端费率名称', 'Name_of_Terminal_Fee_Rate', 'Name_of_Terminal_Fee_Rate', '0880', '条件', '终端费率在系统中的名称。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('终端费单价', 'Terminal_Charge_Unit_Price', 'Terminal_Charge_Unit_Price', '0881', '条件',
       '用于记录不同终端的单价，以及相同终端不同数量区间的单价（相同终端在不同数量区间的单价不相同）。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('信息服务费率名称', 'Name_of_Information_Service_Fee_Rate', 'Name_of_Information_Service_Fee_Rate', '0882', '条件',
       '信息服务费率在系统中的名称。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('数据传输类型', 'Data_Transfer_Type', 'Data_Transfer_Type', '0883', '条件', '信息服务数据的传输方式。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('下载方式', 'Download_Method', 'Download_Method', '0884', '条件', '会员机构下载信息服务数据的方式。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('信息服务费率值', 'Value_of_Information_Service_Fee_Rate', 'Value_of_Information_Service_Fee_Rate', '0885', '条件',
       '针对各信息产品在不同数据传输类型或下载方式中设定的服务费计算参数。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('费用类型名称', 'Fee_Type_Name', 'Fee_Type_Name', '0886', '条件', '费用的具体分类对应的名称。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('开始日期', 'Starting_Date', 'Starting_Date', '1227', '条件', '初始可操作日期。', '{"1":{"IMIX域名":"StartDate"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('开始时间', 'Starting_Time', 'Starting_Time', '1228', '条件', '初始可操作时间。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('截止日期', 'Closing_Date', 'Closing_Date', '0887', '条件', '最后可操作日期。', '{"1":{"IMIX域名":"EndDate"}}', null, null, null,
       null, null, null, null, null, null, 2)
     ,('截止时间', 'Ending_Time', 'Ending_Time', '0888', '条件', '最后可操作时间。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('检查类型', 'Check_Type', 'Check_Type', '1051', '风险控制', '系统进行授信关系检查的方式。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('授信关系检查结果', 'Result_of_Credit_Relationship_Check', 'Result_of_Credit_Relationship_Check', '1052', '风险控制',
       '用于表示授信关系检查是否通过。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('授信方式名称', 'Credit_Mode_Name', 'Credit_Mode_Name', '1053', '风险控制', '授信方式的名称。',
       '{"1":{"IMIX域名":"RiskLimitUpdateMethod"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('单笔最大限额', 'Single_Max_Limit', 'Single_Max_Limit', '1054', '风险控制', '交易员所能达成的单笔最大成交量。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('分行机构名称', 'Branch_Name', 'Branch_Name', '1055', '风险控制', '具有总分行关系的机构中分行机构在系统中的名称。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('总行机构名称', 'Headquarter_Name', 'Headquarter_Name', '1056', '风险控制', '具有总分行关系的机构中总行机构在系统中的名称。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('买入限额', 'Buy_Limit', 'Buy_Limit', '0258', '风险控制', '分行机构在买入/拆入/支付/正回购/融入方向上所允许交易的额度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('卖出限额', 'Sell_Limit', 'Sell_Limit', '0237', '风险控制', '分行机构在卖出/拆出/收取/逆回购/融出方向上所允许交易的额度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('分行最小净限额', 'Branch_Minimum_Net_Limit', 'Branch_Minimum_Net_Limit', '1057', '风险控制',
       '总行针对其分行机构设置的可成交的最小净限额，净限额的计算公式为：净限额=买入方向限额-卖出方向限额。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('分行最大净限额', 'Branch_Maximum_Net_Limit', 'Branch_Maximum_Net_Limit', '1058', '风险控制',
       '总行针对其分行机构设置的可成交的最大净限额，净限额的计算公式为：净限额=买入方向限额-卖出方向限额。', null, null, null, null, null, null, null, null, null, null,
       2)
     ,('买入限额预警值', 'Buy_Limit_Prewarning_Value', 'Buy_Limit_Prewarning_Value', '1059', '风险控制',
       '总行机构为其分行机构在买入方向上设置的超过一定界限值进行提示或限制的预警值。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('卖出限额预警值', 'Sell_Limit_Prewarning_Value', 'Sell_Limit_Prewarning_Value', '1060', '风险控制',
       '总行机构为其分行机构在卖出方向上设置的超过一定界限值进行提示或限制的预警值。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('最小净限额预警值', 'Minimum_Net_Limit_Prewarning_Value', 'Minimum_Net_Limit_Prewarning_Value', '1061', '风险控制',
       '总行机构为其分行机构在最小净限额上设置的超过一定界限值进行提示或限制的预警值。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('最大净限额预警值', 'Maximum_Net_Limit_Prewarning_Value', 'Maximum_Net_Limit_Prewarning_Value', '1062', '风险控制',
       '总行机构为其分行机构在最大净限额上设置的超过一定界限值进行提示或限制的预警值。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('做市券种代码', 'Market_Bonds_Code', 'Market_Bonds_Code', '1063', '风险控制', '做市券种在系统中的唯一编码。',
       '{"1":{"IMIX域名":"SecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('做市机构名称', 'Market_Institution_Name', 'Market_Institution_Name', '1064', '风险控制', '做市机构在系统中的中文简称。',
       '{"1":{"IMIX域名":"PartySubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，做市机构名称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('做市券种最小净限额', 'Market_Bonds_Minimum_Net_Limit', 'Market_Bonds_Minimum_Net_Limit', '1065', '风险控制',
       '针对做市券种设置的净限额最小值，做市券种净限额的计算公式为：做市券种净限额=做市券种买入总额-做市券种卖出总额。', null, null, null, null, null, null, null, null, null,
       null, 2)
     ,('做市券种最大净限额', 'Market_Bonds_Maximum_Net_Limit', 'Market_Bonds_Maximum_Net_Limit', '1066', '风险控制',
       '针对做市券种设置的净限额最大值，做市券种净限额的计算公式为：做市券种净限额=做市券种买入总额-做市券种卖出总额。', null, null, null, null, null, null, null, null, null,
       null, 2)
     ,('做市券种当日已用净限额', 'Market_Bonds_Used_Net_Limit', 'Market_Bonds_Used_Net_Limit', '1067', '风险控制',
       '做市券种在市场中当日被使用的净限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('做市券种当日剩余净限额', 'Market_Bonds_Available_Net_Limit', 'Market_Bonds_Available_Net_Limit', '1068', '风险控制',
       '做市券种的当日剩余可使用的净限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('限额类型', 'Limit_Type', 'Limit_Type', '0106', '风险控制', '不同种类限额的分类。', null, null, null, null, null, null, null, null,
       null, null, 2)
     ,('限额值类型', 'Limit_Value_Type', 'Limit_Value_Type', '1069', '风险控制', '限额取值的类型。', null, null, null, null, null, null,
       null, null, null, null, 2)
     ,('政策性限额类型', 'Policy_Limit_Type', 'Policy_Limit_Type', '1070', '风险控制', '政策性限额按照量、期限、比例进行的分类，同一产品可对应多个政策性限额类型。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('政策性限额映射关系状态', 'Policy_Limit_Mapping_Status', 'Policy_Limit_Mapping_Status', '1071', '风险控制',
       '政策性限额映射关系在系统中所处的状态。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('最大买入限额值', 'Maximum_Buy_Limit', 'Maximum_Buy_Limit', '1072', '风险控制', '机构在买入方向上的最大政策性限额。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('最大卖出限额值', 'Maximum_Sell_Limit', 'Maximum_Sell_Limit', '1073', '风险控制', '机构在卖出方向上的最大政策性限额。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('临时最大买入限额值', 'Temporary_Maximum_Buy_Limit', 'Temporary_Maximum_Buy_Limit', '1074', '风险控制',
       '机构在买入方向上的临时的最大政策性限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('临时最大卖出限额值', 'Temporary_Maximum_Sell_Limit', 'Temporary_Maximum_Sell_Limit', '1075', '风险控制',
       '机构在卖出方向上的临时的最大政策性限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('临时限额生效时间', 'Temporary_Limit_Effective_Time', 'Temporary_Limit_Effective_Time', '1076', '风险控制',
       '临时政策性限额在系统中生效的时间。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('临时限额失效时间', 'Temporary_Limit_Invalid_Time', 'Temporary_Limit_Invalid_Time', '1077', '风险控制', '临时政策性限额在系统中失效的时间。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('最大买入期限值', 'Maximum_Buy_Term', 'Maximum_Buy_Term', '1078', '风险控制', '会员机构在不同产品买入方向上的最大可交易期限。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('最大卖出期限值', 'Maximum_Sell_Term', 'Maximum_Sell_Term', '1079', '风险控制', '会员机构在不同产品卖出方向上的最大可交易期限。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('限额比例', 'Limit_Proportion', 'Limit_Proportion', '1080', '风险控制', '会员设置的政策性限额比例。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('额度状态', 'Limit_Status', 'Limit_Status', '1081', '风险控制', '拍卖交易模式下设置的发行额度在系统中的状态。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('已占用限额比例', 'Occupied_Limit_Proportion', 'Occupied_Limit_Proportion', '1082', '风险控制', '已占用限额占总限额的比例值。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('限额预警比例', 'Limit_Alert_Proportion', 'Limit_Alert_Proportion', '1083', '风险控制',
       '会员机构预警值占总限额的比例，一旦超过该预警值，系统予以预警或限额操作。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('已用买入限额', 'Used_Buy_Limit', 'Used_Buy_Limit', '1084', '风险控制', '会员已经占用的买入限额额度。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('可用买入限额', 'Available_Buy_Limit', 'Available_Buy_Limit', '1085', '风险控制', '会员剩余可用的买入限额额度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('已用卖出限额', 'Used_Sell_Limit', 'Used_Sell_Limit', '1086', '风险控制', '会员已经占用的卖出限额额度。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('可用卖出限额', 'Available_Sell_Limit', 'Available_Sell_Limit', '1087', '风险控制', '会员剩余可用的卖出限额额度。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('限额预警值', 'Limit_Alert_Value', 'Limit_Alert_Value', '1088', '风险控制', '机构的政策性限额监测预警值，一旦机构交易额度超过此预警值，系统进行预警或限额操作。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('授信机构名称', 'Credit_Institution_Name', 'Credit_Institution_Name', '1089', '风险控制', '与本方机构有授信关系的对手方机构中文简称。',
       '{"1":{"IMIX域名":"PartyDetailSubID（JR/T_0066一般以“Party”组件描述机构实体，以“Party”下的子组件“SubGrp”描述机构实体详细信息，授信机构名称由“SubGrp”组件中的Type域和ID域组合表示）"}}',
       null, null, null, null, null, null, null, null, null, 2)
     ,('初始授信额度', 'Original_Credit_Limit', 'Original_Credit_Limit', '1090', '风险控制',
       '会员机构对其对手方自行设置的最大可成交额度，超过此额度，机构之间的交易无法达成。', '{"1":{"IMIX域名":"RiskLimitAmount"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('已用授信额度', 'Used_Credit_Limit', 'Used_Credit_Limit', '1091', '风险控制', '已清算的交易所占用的额度。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('可用授信额度', 'Available_Credit_Limit', 'Available_Credit_Limit', '1092', '风险控制',
       '会员机构之间剩余可使用的交易额度，可用授信额度的计算公式为：可用授信额度=初始授信额度-已用授信额度。', '{"1":{"IMIX域名":"RiskLimitRemainingtAmt"}}', null, null,
       null, null, null, null, null, null, null, 2)
     ,('最长期限', 'Maximum_Term', 'Maximum_Term', '1093', '风险控制', '不同合约品种的最长期限值。', '{"1":{"IMIX域名":"RiskTerm"}}', null,
       null, null, null, null, null, null, null, null, 2)
     ,('预警比例', 'Alert_Proportion', 'Alert_Proportion', '1094', '风险控制', '系统对机构已用授信额度/初始授信额度，达到或超过设定的比例进行预警，从而控制风险。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('实际占用额度比例', 'Actual_Used_Proportion', 'Actual_Used_Proportion', '1095', '风险控制', '当前机构已用授信额度占初始授信额度的比例。', null,
       null, null, null, null, null, null, null, null, null, 2)
     ,('额度更新方式', 'Limit_Update_Method', 'Limit_Update_Method', '1096', '风险控制', '在指令驱动交易模式下，会员双边授信额度的更新方式。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('额度返还方式', 'Limit_Return_Method', 'Limit_Return_Method', '1097', '风险控制', '交易到期时，向机构或交易员返还额度的方式。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('合约品种', 'Contract_Type', 'Contract_Type', '1098', '风险控制', '互换市场中会员机构进行报价、交易的标的。',
       '{"1":{"IMIX域名":"SecurityID"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('风险系数', 'Risk_Coefficient', 'Risk_Coefficient', '1099', '风险控制', '针对不同合约品种设置的风险系数。',
       '{"1":{"IMIX域名":"RiskInstrumentMultiplier"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('初始额度', 'Original_Limit', 'Original_Limit', '1100', '风险控制', '根据统一的授信制度，对每个会员分别授予的交易总额度。',
       '{"1":{"IMIX域名":"RiskLimitAmount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('剩余可用额度', 'Remain_Available_Limit', 'Remain_Available_Limit', '1102', '风险控制', '初始额度扣除暂扣额度和已用额度后的额度。',
       '{"1":{"IMIX域名":"RiskLimitRemainingtAmt"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('已用净限额', 'Used_Net_Limit', 'Used_Net_Limit', '1103', '风险控制', '会员机构已经使用的净限额，已用净限额的计算公式为：已用净限额=已用买入限额-已用卖出限额。',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('可用净限额', 'Available_Net_Limit', 'Available_Net_Limit', '1104', '风险控制',
       '会员机构剩余可使用的净限额，可用净限额的计算公式为：可用净限额=净限额-已用净限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('已用比例', 'Used_Proportion', 'Used_Proportion', '1105', '风险控制', '会员机构已经使用的额度所占的比例。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('限额检查结果', 'Limit_Check_Result', 'Limit_Check_Result', '1106', '风险控制', '会员机构报价、交易前系统对其各类型限额进行检查的结果。', null, null,
       null, null, null, null, null, null, null, null, 2)
     ,('暂扣额度', 'Hold_Limit', 'Hold_Limit', '1107', '风险控制', '对已经发起但未成交的交易暂扣的额度，根据会员每笔报价的卖出币种金额、内部折算率计算。',
       '{"1":{"IMIX域名":"RiskLimitHoldAmount"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('净暂扣额度', 'Net_Hold_Limit', 'Net_Hold_Limit', '1108', '风险控制', '会员机构在买入方向上暂扣额度与卖出方向上暂扣额度的差值。', null, null, null,
       null, null, null, null, null, null, null, 2)
     ,('业务资格类型', 'Business_Qualifications_Type', 'Business_Qualifications_Type', '1109', '风险控制',
       '会员机构所能拥有的业务资格在系统中的分类。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('业务资格标识', 'Business_Qualifications_Identify', 'Business_Qualifications_Identify', '1110', '风险控制',
       '用于标识会员机构是否具有业务资格。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('授信类型', 'Credit_Type', 'Credit_Type', '0065', '风险控制', '针对授信作用的不同对象而对授信进行的分类。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('授信子类型', 'Credit_Sub_Type', 'Credit_Sub_Type', '0064', '风险控制', '因作用的限额不同，对授信类型的进一步分类。', null, null, null, null,
       null, null, null, null, null, null, 2)
     ,('限额值', 'Limit_Value', 'Limit_Value', '1122', '风险控制', '针对各限额设置的具体限额值。', null, null, null, null, null, null, null,
       null, null, null, 2)
     ,('做市券种名称', 'Market_Bonds_Name', 'Market_Bonds_Name', '1123', '风险控制', '做市券种在系统中的名称，如债券名称、资产支持证券名称等。',
       '{"1":{"IMIX域名":"Symbol"}}', null, null, null, null, null, null, null, null, null, 2)
     ,('最小净限额', 'Minimum_Net_Limit', 'Minimum_Net_Limit', '0088', '风险控制', '系统设置的净限额所能允许的最小值，净限额的计算公式为：净限额=买入方向限额-卖出方',
       null, null, null, null, null, null, null, null, null, null, 2)
     ,('最大净限额', 'Maximum_Net_Limit', 'Maximum_Net_Limit', '0084', '风险控制',
       '系统设置的净限额所能允许的最大值，净限额的计算公式为：净限额=买入方向限额-卖出方向限额。', null, null, null, null, null, null, null, null, null, null, 2)
     ,('发行备案起始日', 'Issue_Record_Start_Date', 'Issue_Record_Start_Date', '1188', '风险控制', '发行机构在某时间段内设置的发行限额的起始日。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和_Date域组合表示发行备案起始日）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('发行备案终止日', 'Issue_Record_End_Date', 'Issue_Record_End_Date', '1189', '风险控制', '发行机构在某时间段内设置的发行限额的终止日。',
       '{"1":{"IMIX域名":"EventDate（JR/T_0066一般以“EvntGrp”组件中的Type域和_Date域组合表示发行备案终止日）"}}', null, null, null, null, null,
       null, null, null, null, 2)
     ,('可用限额', 'Available_Limit', 'Available_Limit', '1190', '风险控制', '发行机构在大额存单上可用的发行额度。', null, null, null, null, null,
       null, null, null, null, null, 2)
     ,('大额存单发行限额状态', 'CDs_Issue_Limit_Status', 'CDs_Issue_Limit_Status', '1191', '风险控制',
       '发行机构设置的发行备案额度在系统中所处的状态，包含启用等。', null, null, null, null, null, null, null, null, null, null, 2);
insert into assets_standard_preset_standard (standard_name_cn, standard_name, standard_name_abbreviation,
                                             standard_number, catalog, business_definition, custom_attribute,
                                             data_type_id, data_length, data_length_operator, post_precision,
                                             pre_precision, nullable, repeatable, default_value, value_range,
                                             template_id)
values ('金额', 'Amount', 'Amount', null, '通用类型', '货币单位的数量', null, null, 20, '<=', null, null, null, null, null, null, 3)
     ,('费用', 'Fee', 'Fee', null, '通用类型', '银行办理某些业务向客户收取的费用，如国库券发行期内支取。打印
特殊单据等', null, null, 18, '<=', null, null, null, null, null, null, 3)
     ,('汇率', 'Exchange_rate', 'Exchange_rate', null, '通用类型', '一国货币单位与另一国货币单位之间的兑换比例', null, null, 13, '<=', null, null,
       null, null, null, null, 3)
     ,('利率', 'Interest_rate', 'Interest_rate', null, '通用类型', '计算利息的比率', null, null, 12, '<=', null, null, null, null,
       null, null, 3)
     ,('日期', 'Date', 'Date', null, '通用类型', '说明日期值', null, null, 8, '=', null, null, null, null, null, null, 3)
     ,('时间', 'Time', 'Time', null, '通用类型', '说明时间的值', null, null, 6, '=', null, null, null, null, null, null, 3)
     ,('精确时间', 'Specifed_time', 'Specifed_time', null, '通用类型', '说明时间的精确值', null, null, 6, '=', null, null, null, null,
       null, null, 3)
     ,('年期限', 'Period_value(year)', 'Period_value(year)', null, '通用类型', '说明年期限的值', null, null, 2, '<=', null, null,
       null, null, null, null, 3)
     ,('月期限', 'Period_value(month)', 'Period_value(month)', null, '通用类型', '说明月期限的值', null, null, 4, '<=', null, null,
       null, null, null, null, 3)
     ,('日期限', 'Period_value(day)', 'Period_value(day)', null, '通用类型', '说明日期限的值', null, null, 6, '<=', null, null, null,
       null, null, null, 3)
     ,('客户名称', 'Full_name_of_customer', 'Full_name_of_customer', null, '通用类型', '客户的中文全称', null, null, 100, '<=', null,
       null, null, null, null, null, 3)
     ,('客户英文名称', 'English_name_of_customer', 'English_name_of_customer', null, '通用类型', '客户的英文全称', null, null, 100, '<=',
       null, null, null, null, null, null, 3)
     ,('客户类别', 'Regimentation_of_customer', 'Regimentation_of_customer', null, '通用类型', '对公、对私的标识', null, null, 8, '<=',
       null, null, null, null, null, null, 3)
     ,('法人代表名称', 'Legal_entity_deputy_name', 'Legal_entity_deputy_name', null, '通用类型', '客户的法人代表名', null, null, 30, '<=',
       null, null, null, null, null, null, 3)
     ,('客户号', 'Customer_number', 'Customer_number', null, '通用类型', '银行标识客户身份的唯一号码', null, null, 19, '<=', null, null,
       null, null, null, null, 3)
     ,('客户信用评级代码', 'Code_of_rating_rank_for_customer', 'Code_of_rating_rank_for_customer', null, '通用类型',
       '银行对客户评级确定的信用级别', null, null, 2, '=', null, null, null, null, null, null, 3)
     ,('工作单位名称', 'Employer', 'Employer', null, '通用类型', '个人的工作单位的名称', null, null, 100, '<=', null, null, null, null,
       null, null, 3)
     ,('电子邮件', 'Email', 'Email', null, '通用类型', '客户的互联网邮件地址', null, null, 50, '<=', null, null, null, null, null, null,
       3)
     ,('网址', 'Web_address', 'Web_address', null, '通用类型', '客户的互联网网址', null, null, 30, '<=', null, null, null, null, null,
       null, 3)
     ,('有效证件类型代码', 'Code_of_availablity_certificate_type', 'Code_of_availablity_certificate_type', null, '通用类型',
       '个人的有效证件类型，如身份证、护照等', null, null, 2, '=', null, null, null, null, null, null, 3)
     ,('有效证件号码', 'Availability_certificate_number', 'Availability_certificate_number', null, '通用类型', '标识个人身份的有效证件的登记号',
       null, null, 20, '<=', null, null, null, null, null, null, 3)
     ,('地址', 'Address', 'Address', null, '通用类型', '说明一个地址', null, null, 100, '<=', null, null, null, null, null, null, 3)
     ,('联系电话', 'Contact_number', 'Contact_number', null, '通用类型', '客户的联系电话', null, null, 25, '<=', null, null, null,
       null, null, null, 3)
     ,('月收入', 'Monthly_income', 'Monthly_income', null, '通用类型', '个人的月收入', null, null, 10, '<=', null, null, null, null,
       null, null, 3)
     ,('密码', 'Password', 'Password', null, '通用类型', '标识由客户设定的密码', null, null, 6, '<=', null, null, null, null, null,
       null, 3)
     ,('会计凭证号', 'Voucher_number', 'Voucher_number', null, '会计类型', '按一定标准编制的凭证号码', null, null, 20, '<=', null, null,
       null, null, null, null, 3)
     ,('会计科目代号', 'Accounting_subject_code', 'Accounting_subject_code', null, '会计类型', '银行会计科目的代号', null, null, 10, '<=',
       null, null, null, null, null, null, 3)
     ,('银行会计科目类型代码', 'Code_of_banks''accounting_subject_type', 'Code_of_banks''accounting_subject_type', null, '会计类型',
       '银行会计科目的类型代', null, null, 1, '=', null, null, null, null, null, null, 3)
     ,('账户名称', 'Account_name', 'Account_name', null, '会计类型', '账户的名称', null, null, 100, '<=', null, null, null, null,
       null, null, 3)
     ,('账户状态代码', 'Code_of_account_status', 'Code_of_account_status', null, '会计类型', '账户所处状态的代码', null, null, 1, '=',
       null, null, null, null, null, null, 3)
     ,('账户类型代码', 'Code_of_account_type', 'Code_of_account_type', null, '会计类型', '按一定标准划分的账户种类的代码', null, null, 1, '=',
       null, null, null, null, null, null, 3)
     ,('账号', 'Account_number', 'Account_number', null, '会计类型', '账户的唯一标识号码', null, null, 23, '<=', null, null, null,
       null, null, null, 3)
     ,('子账户序号', 'Sub-account_serialnumber', 'Sub-account_serialnumber', null, '会计类型', '综合账户每次新开子账户系统又生成的号码，打印在对账簿上',
       null, null, 23, '<=', null, null, null, null, null, null, 3)
     ,('账户属性', 'Property_of_account', 'Property_of_account', null, '会计类型', '标识账户的属性，如：单币种、多币种、结算户、个人储蓄账户等', null, null,
       20, '<=', null, null, null, null, null, null, 3)
     ,('摘要', 'Summary', 'Summary', null, '会计类型', '简要说明', null, null, 60, '<=', null, null, null, null, null, null, 3)
     ,('存款种类代码', 'Code_of_deposit_type', 'Code_of_deposit_type', null, '存贷款类', '标识存款种类的代码', null, null, 3, '=', null,
       null, null, null, null, null, 3)
     ,('合同号', 'Contract_number', 'Contract_number', null, '存贷款类', '对合同赋子的，标识合同的唯一数值', null, null, 44, '<=', null, null,
       null, null, null, null, 3)
     ,('合同状态代码', 'Code_of_contract_status', 'Code_of_contract_status', null, '存贷款类', '标识合同所处的执行状态', null, null, 3, '=',
       null, null, null, null, null, null, 3)
     ,('担保方式代码', 'Code_of_collateral_tao_de', 'Code_of_collateral_tao_de', null, '存贷款类', '标识借款合同中担保方式的代码', null, null,
       2, '=', null, null, null, null, null, null, 3)
     ,('贷款种类代码', 'Code_of_loan_type', 'Code_of_loan_type', null, '存贷款类', '标识贷款种类的代码', null, null, 4, '=', null, null,
       null, null, null, null, 3)
     ,('还款方式代码', 'Code_of_repayment_mode', 'Code_of_repayment_mode', null, '存贷款类', '标识还贷款的方式', null, null, 2, '=', null,
       null, null, null, null, null, 3)
     ,('贷款期限类型代码', 'Code_of_loan_period_type', 'Code_of_loan_period_type', null, '存贷款类', '标识货款的期限，如：短期、中期等', null, null,
       1, '=', null, null, null, null, null, null, 3)
     ,('结息方式代码', 'Code_of_interest-calculating_mode', 'Code_of_interest-calculating_mode', null, '存贷款类',
       '标识银行存、贷款到期利息的结算方式的代码', null, null, 1, '=', null, null, null, null, null, null, 3)
     ,('资产保全方式代码', 'Code_of_asset_save_from_damage_mode', 'Code_of_asset_save_from_damage_mode', null, '存贷款类',
       '标识银行处理不良资产的方式', null, null, 2, '=', null, null, null, null, null, null, 3)
     ,('贷款核销方式', 'Mode_of_write-offs', 'Mode_of_write-offs', null, '存贷款类', '标识银行对呆、坏帐的处理方式', null, null, 20, '<=', null,
       null, null, null, null, null, 3)
     ,('货款账户状志代码', 'Code_of_Ioan_account_state', 'Code_of_Ioan_account_state', null, '存贷款类', '标识贷款账户所处的状态。如：正常、逾期、呆滞、呆、结清、
准信之服务平
部分途期等', null, null, 1, '=', null, null, null, null, null, null, 3)
     ,('贷款质量分类代码', 'Code_of_asset_loan_classification', 'Code_of_asset_loan_classification', null, '存贷款类',
       '贷款质量五级分类的代码', null, null, 2, '=', null, null, null, null, null, null, 3)
     ,('银行卡卡号', 'Card_number', 'Card_number', null, '银行卡类', '标识所使用卡的卡号', null, null, 19, '<=', null, null, null, null,
       null, null, 3)
     ,('银行卡种类代码', 'Code_of_card_type', 'Code_of_card_type', null, '银行卡类', '标识银行卡的种类，如：借记卡、贷记卡等', null, null, 2, '=',
       null, null, null, null, null, null, 3)
     ,('银行卡类别代码', 'Code_of_card_category', 'Code_of_card_category', null, '银行卡类', '标识银行卡的类别，如：个人卡、单位卡等', null, null, 2,
       '=', null, null, null, null, null, null, 3)
     ,('银行卡状态代码', 'Code_of_card_status', 'Code_of_card_status', null, '银行卡类', '标识银行卡的当前状态，如：冻结、挂失、注销等的代码', null, null,
       1, '=', null, null, null, null, null, null, 3)
     ,('主附卡标志', 'Master_or_supplemental_card_indicator', 'Master_or_supplemental_card_indicator', null, '银行卡类',
       '标识是否是主、附卡', null, null, 4, '<=', null, null, null, null, null, null, 3)
     ,('代理业务种类', 'Agent_service_type', 'Agent_service_type', null, '代理业务类', '标识代理业务的类别，用于对所有的代理业务进行分类，如：财政类、证券类、缴费类等',
       null, null, 3, '<=', null, null, null, null, null, null, 3)
     ,('代理业务编号', 'Agent_service_code', 'Agent_service_code', null, '代理业务类', '某一代理业务的标识号，在主机代理业务档案中定义', null, null, 9,
       '<=', null, null, null, null, null, null, 3)
     ,('结算方式代码', 'Settle_mode_code', 'Settle_mode_code', null, '结算清算类', '标识本外币交易结算方式的代码', null, null, 2, '=', null,
       null, null, null, null, null, 3)
     ,('票据名称', 'Voucher''s_name', 'Voucher''s_name', null, '结算清算类', '票据的中文名称', null, null, 20, '<=', null, null, null,
       null, null, null, 3)
     ,('票据号', 'Voucher''s_number', 'Voucher''s_number', null, '结算清算类', '票据的编号', null, null, 16, '<=', null, null, null,
       null, null, null, 3)
     ,('信用证号', 'L/C_No', 'L/C_No', null, '结算清算类', '信用证的编号', null, null, 16, '<=', null, null, null, null, null, null, 3)
     ,('保函号', 'Letter_of_guarantee_number', 'Letter_of_guarantee_number', null, '结算清算类', '保函的编号', null, null, 30, '<=',
       null, null, null, null, null, null, 3)
     ,('保函种类', 'Letter_of_guaranteev_class', 'Letter_of_guaranteev_class', null, '结算清算类', '保函的种类，例如预付款保函、投标保函等', null,
       null, 20, '<=', null, null, null, null, null, null, 3)
     ,('托收号', 'Collect_No', 'Collect_No', null, '结算清算类', '托妆业务的编号', null, null, 16, '<=', null, null, null, null, null,
       null, 3)
     ,('开证融资协议号', 'Agreement_No', 'Agreement_No', null, '结算清算类', '开融资协议的编号', null, null, 16, '<=', null, null, null,
       null, null, null, 3)
     ,('开证融资种类', 'Loan_type', 'Loan_type', null, '结算清算类', '开证融资的种类', null, null, 20, '<=', null, null, null, null, null,
       null, 3)
     ,('保证金种类', 'Margin_type', 'Margin_type', null, '结算清算类', '保证金的种类', null, null, 20, '<=', null, null, null, null,
       null, null, 3)
     ,('额度种类', 'Liability_type', 'Liability_type', null, '结算清算类', '授信额度的种类', null, null, 20, '<=', null, null, null,
       null, null, null, 3)
     ,('汇号', 'Purchase_No', 'Purchase_No', null, '结算清算类', '押汇业务的编号', null, null, 16, '<=', null, null, null, null, null,
       null, 3)
     ,('提货担保号', 'S/G_No', 'S/G_No', null, '结算清算类', '提货担保业务的编号', null, null, 16, '<=', null, null, null, null, null,
       null, 3)
     ,('开立方式', 'Open_method', 'Open_method', null, '结算清算类', '标识信用证或保函开立的方式，如：电开、信开等', null, null, 4, '<=', null, null,
       null, null, null, null, 3)
     ,('清算行行号', 'Code_of_bank_initiating_liquidation', 'Code_of_bank_initiating_liquidation', null, '结算清算类',
       '本币清算业务中对银行的标识代码', null, null, 12, '=', null, null, null, null, null, null, 3)
     ,('收/付款人开户行行号', 'Payee''s/payer''s_account-opening_bank_number', 'Payee''s/payer''s_account-opening_bank_number',
       null, '结算清算类', '收、付款人开户行的银行代码', null, null, 12, '=', null, null, null, null, null, null, 3)
     ,('附言', 'Postscript', 'Postscript', null, '结算清算类', '附言', null, null, 60, '<=', null, null, null, null, null, null,
       3);

-- 预设码表数据插入
delete
from assets_standard_preset_code;

insert into assets_standard_preset_code (code_name, code_number, code_content, template_id)
values ('银行卡类别代码', '720',
        '[{"encodeName":"VIP单位卡","encodeValue":"11"},{"encodeName":"金卡单位卡","encodeValue":"12"},{"encodeName":"呼通单位卡","encodeValue":"13"},{"encodeName":"金卡个人卡","encodeValue":"22"},{"encodeName":"其他卡","encodeValue":"90"},{"encodeName":"晋通个人卡","encodeValue":"23"},{"encodeName":"VIP个人卡","encodeValue":"21"},{"encodeName":"个人卡","encodeValue":"20"}]',
        4)
     ,('贷款账户状态代码', '634',
       '[{"encodeName":"逾期","encodeValue":"3"},{"encodeName":"展期","encodeValue":"2"},{"encodeName":"呆滞","encodeValue":"5"},{"encodeName":"呆账","encodeValue":"6"},{"encodeName":"其他","encodeValue":"9"},{"encodeName":"部分逾期","encodeValue":"4"},{"encodeName":"结清","encodeValue":"7"}]',
       4)
     ,('银行卡种类代码', '710',
       '[{"encodeName":"其他","encodeValue":"90"},{"encodeName":"贷记卡","encodeValue":"20"},{"encodeName":"准贷记卡","encodeValue":"30"}]',
       4)
     ,('银行卡状态代码', '730',
       '[{"encodeName":"临时止付","encodeValue":"3"},{"encodeName":"冻结","encodeValue":"2"},{"encodeName":"挂失","encodeValue":"4"},{"encodeName":"注销","encodeValue":"5"},{"encodeName":"其他","encodeValue":"9"},{"encodeDesc":"介入正赏和冻结状态之间的加强监控的状态","encodeName":"可以","encodeValue":"6"}]',
       4)
     ,('存款种类代码', '600',
       '[{"encodeName":"整存零取","encodeValue":"106"},{"encodeName":"教育疗款","encodeValue":"111"},{"encodeName":"零存整取","encodeValue":"105"},{"encodeName":"整存整取","encodeValue":"104"},{"encodeName":"活期支票","encodeValue":"102"},{"encodeName":"通知存歉","encodeValue":"108"},{"encodeName":"保证金存款","encodeValue":"209"},{"encodeName":"大额存款","encodeValue":"110"},{"encodeName":"对公","encodeValue":"200"},{"encodeName":"定活两便","encodeValue":"103"},{"encodeName":"存本取息","encodeValue":"107"},{"encodeName":"活期存款","encodeValue":"101"},{"encodeName":"保证金存歉","encodeValue":"109"},{"encodeName":"通知存款","encodeValue":"208"}]',
       4)
     ,('账户状态代码', '524',
       '[{"encodeDesc":"标明账户为临时止付状态","encodeName":"临时止付","encodeValue":"4"},{"encodeDesc":"标明账户为透支状态","encodeName":"透支","encodeValue":"5"},{"encodeDesc":"标明账户为睡眠状态","encodeName":"睡眠","encodeValue":"6"},{"encodeDesc":"标明账户全部或部分处于不能进行借记交易状态","encodeName":"冻结","encodeValue":"2"},{"encodeDesc":"标明账户为挂失状态","encodeName":"挂失","encodeValue":"3"},{"encodeDesc":"标明账户为销户状态","encodeName":"销户","encodeValue":"7"},{"encodeDesc":"标明账户的其他状态","encodeName":"其他","encodeValue":"9"}]',
       4)
     ,('担保方式代码', '620',
       '[{"encodeName":"商业承兑汇票贴现","encodeValue":"36"},{"encodeName":"可转让股份股票权质押","encodeValue":"37"},{"encodeDesc":"指以土地房产权作为抵押品而发放的抵押贷款的担保方式","encodeName":"土地房产权抵押","encodeValue":"41"},{"encodeDesc":"指在中国境内设立的除外国独资或中外合资银行以外的外资或中外合资融资租赁公司、信托投资公司尊非银行金融机构以第三者的身份承诺在借軟人不能偿还贷款时，按约定廉担一般保证贲任或者连带责任","encodeName":"外资或中外合资非银行金融机构保证","encodeValue":"26"},{"encodeName":"营运年辆抵押","encodeValue":"44"},{"encodeDesc":"指城市、农村信用合作银行以第三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证责任或者连带责任","encodeName":"信用合作银行保证","encodeValue":"23"},{"encodeDesc":"指在中国境内设立的外国独资或者中外合资经营的银行以第三者的身份承诺在借款人不能偿还贷款时，按约定承損-般保证贾任或者连带责任","encodeName":"外资或中外合资银行保证","encodeValue":"25"},{"encodeDesc":"指上述动产质押以外的动产质押方式","encodeName":"其他动产质押","encodeValue":"3A"},{"encodeDesc":"指以金融儘券作为抵押呂而发放的贷款","encodeName":"金融债券质押","encodeValue":"33"},{"encodeDesc":"指国有独姿商业银行及政第银行以第三者身份承诺在借款人不能偿还贷款时，按约定承担一般保证责任或连带责任","encodeName":"国有商业银行及政策性银行保证","encodeValue":"21"},{"encodeDesc":"指以居住楼宇作为抵押品而发放的抵押贷款的担保方式","encodeName":"居住楼宇抵押","encodeValue":"42"},{"encodeDesc":"以现汇作为抵押物而发放的贷秋","encodeName":"现汇质押","encodeValue":"32"},{"encodeName":"依法可设定抵押权的其他财产抵押","encodeValue":"45"},{"encodeDesc":"指商业银行及政策性银行向客户开出银行承兑汇京,客户向银行进行貼现所发生的资金往来款项","encodeName":"商业银行及政策性银行承兑汇票贴现","encodeValue":"35"},{"encodeDesc":"折保证人以第三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证责任或者连带资任而发放的贷款的担保方式","encodeName":"保证担保","encodeValue":"20"},{"encodeDesc":"拆出质人以动产或者权利作为质物，用来担保贷款合同履行而发放的贷款的扭保方式","encodeName":"质押押保","encodeValue":"30"},{"encodeDesc":"折除银行、非银行金融机构和企业以外的单位（法律规定的不能提供信用担保的单位除外）以第三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证责任或者连带责任","encodeName":"其他保证","encodeValue":"29"},{"encodeDesc":"指以人民币存单作为抵押品而发放的贷款的扭保方式","encodeName":"人民币存单质押","encodeValue":"38"},{"encodeDesc":"指上述担保方式以外的担保方式","encodeName":"其他担保","encodeValue":"99"},{"encodeDesc":"指信托投资公可、证券公可、保险公司等菲银行金融机构以第三者的身份承诺在借款人不能偿还贷款时，按约定承袒一般保证贲任或者连带责任","encodeName":"非银行金融机构保证","encodeValue":"24"},{"encodeDesc":"指以外币存单作为抵押品而发放的贷款的担保方式","encodeName":"外币存单质押","encodeValue":"39"},{"encodeDesc":"捋以其他有价证券及可转让物作为以抵押品转让而发放的贷款","encodeName":"其他有价证券及可转让权质押","encodeValue":"34"},{"encodeDesc":"指借款人或第三人将动产作为质押物而发放的贷款的担保方式","encodeName":"动产物业抵押","encodeValue":"43"},{"encodeDesc":"指以收费权等各种权利作为质押的一种质押方式","encodeName":"权利质押","encodeValue":"3B"},{"encodeDesc":"指股份制商业银行以笫三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证负任或者连带责任","encodeName":"其他银行保证","encodeValue":"22"},{"encodeDesc":"指除国家大型或特人型以外的企业以第三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证责任或者连带责任","encodeName":"其他企业保证","encodeValue":"28"},{"encodeDesc":"抵押担保是指抵押人以財产作为抵押物，用來扱保贷款合同履行而发放的贷款的担保方式","encodeName":"祇押担保","encodeValue":"40"},{"encodeDesc":"指由国家主管部门认定的国有独荒大型或特人型企业以第三者的身份承诺在借歎人不能偿还贷款时，按约定承担-般保证贡任或者连带责任","encodeName":"国存大型或箝大型企业保证","encodeValue":"27"},{"encodeDesc":"指以国债作为抵押财产而发放的贷款","encodeName":"国债质押","encodeValue":"31"},{"encodeDesc":"指上述抵押担保方式以外的抵押担保方式","encodeName":"其他抵押","encodeValue":"46"},{"encodeDesc":"指政府和部门以第三者的身份承诺在借款人不能偿还贷款时，按约定承担一般保证贵任或者连带贵任","encodeName":"政府和部门保证","encodeValue":"2A"}]',
       4)
     ,('贷款种类代码', '622',
       '[{"encodeDesc":"人民币","encodeName":"商业贷款","encodeValue":"1020"},{"encodeName":"转贴现","encodeValue":"4030"},{"encodeDesc":"人民币","encodeName":"再站现","encodeValue":"4020"},{"encodeDesc":"人民币","encodeName":"其它地产开发贷款","encodeValue":"2050"},{"encodeDesc":"人民币：外汇","encodeName":"短期信托贷款","encodeValue":"1130"},{"encodeDesc":"人民币","encodeName":"技术改造贷款","encodeValue":"2020"},{"encodeDesc":"外汇","encodeName":"中资企业贷款","encodeValue":"1090"},{"encodeDesc":"外汇","encodeName":"外商投资企业贷款","encodeValue":"1100"},{"encodeDesc":"外汇","encodeName":"国家特定贷款","encodeValue":"2100"},{"encodeName":"各项垫款","encodeValue":"5010"},{"encodeDesc":"人民币","encodeName":"住房开发贷款","encodeValue":"2030"},{"encodeDesc":"人民币","encodeName":"三资企业贷款","encodeValue":"1060"},{"encodeDesc":"外汇","encodeName":"境外短期贷款","encodeValue":"1120"},{"encodeDesc":"人民币","encodeName":"乡镇企业贷款","encodeValue":"1050"},{"encodeDesc":"外汇","encodeName":"“以储顶贷”专项存款转贷款","encodeValue":"2130"},{"encodeDesc":"人民币","encodeName":"中期流动资金贷款","encodeValue":"2070"},{"encodeName":"三、其他贷款类","encodeValue":"3000"},{"encodeDesc":"人民币","encodeName":"个人中长期贷款","encodeValue":"20S0"},{"encodeDesc":"人民币","encodeName":"建筑业贷款","encodeValue":"1030"},{"encodeDesc":"人民币","encodeName":"个人短期贷款","encodeValue":"1080"},{"encodeDesc":"人民币；外汇","encodeName":"中长期信托贷款","encodeValue":"2150"},{"encodeDesc":"外汇","encodeName":"进出口贸易融资","encodeValue":"3010"},{"encodeDesc":"外汇","encodeName":"境外筹资转贷款","encodeValue":"3030"},{"encodeDesc":"外汇","encodeName":"票据融资","encodeValue":"4040"},{"encodeDesc":"外汇","encodeName":"境内其他贷款","encodeValue":"1110"},{"encodeDesc":"人民币","encodeName":"贴现","encodeValue":"4010"},{"encodeDesc":"外汇","encodeName":"银团贷秋","encodeValue":"2120"},{"encodeDesc":"外汇","encodeName":"出口卖方信贷","encodeValue":"3020"},{"encodeDesc":"人民币","encodeName":"私营企业及个体贷款","encodeValue":"1070"},{"encodeDesc":"外汇","encodeName":"境外中长期贷款","encodeValue":"2160"},{"encodeDesc":"人民币","encodeName":"基本建设贷款","encodeValue":"2010"},{"encodeDesc":"人氏币","encodeName":"农业贷秋","encodeValue":"1040"},{"encodeDesc":"人民币","encodeName":"商业用房开发贷款","encodeValue":"2040"},{"encodeDesc":"外汇","encodeName":"特种贷款","encodeValue":"2110"}]',
       4)
     ,('贷款质量分类代码', '636',
       '[{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"四级（正常四级〉","encodeValue":"14"},{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"三级（正常三级》","encodeValue":"13"},{"encodeDesc":"在采取所有可能的措施或一切必要的法律程序之后，本息仍然无法收回，或只能收回极少部分","encodeName":"撩失","encodeValue":"50"},{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"二级（正常二级）","encodeValue":"12"},{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"五级（正幣五级）","encodeValue":"15"},{"encodeDesc":"借欷人无法足额偿还贷款本息，即使执行担保，也肯定要造成较大损失","encodeName":"可疑","encodeValue":"40"},{"encodeDesc":"借款人的还款能力出现明显问题，宪全依靠其正常营业收入无法足额偿还贷款本息，即使执行担保，也可能会造成较大损失","encodeName":"十级（次二级）","encodeValue":"32"},{"encodeDesc":"借款人的还款能力出现明显问题，宪全依靠其正常营业收入无法足额偿还贷款本息，即使执行担保，也可能会造成较大损失","encodeName":"次级","encodeValue":"30"},{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"一级（正常一级）","encodeValue":"11"},{"encodeDesc":"借款人的还款能力出现明显问题，宪全依靠其正常营业收入无法足额偿还贷款本息，即使执行担保，也可能会造成较大损失","encodeName":"九级（次一级）","encodeValue":"31"},{"encodeDesc":"尽管借款人目前有能力偿还贷款本息，但存在一些可踐对偿还产生不利影响的因袁","encodeName":"八级（关注二级）","encodeValue":"22"},{"encodeDesc":"借款人能够履行合同，沒有足够理由怀融贷款本息不能按时足额偿还","encodeName":"六级（正常六级）","encodeValue":"16"},{"encodeDesc":"尽管借款人目前有能力偿还贷款本息，但存在一些可踐对偿还产生不利影响的因袁","encodeName":"七级（关注一级）","encodeValue":"21"},{"encodeDesc":"尽管借款人目前有能力偿还贷款本息，但存在一些可踐对偿还产生不利影响的因袁","encodeName":"关注","encodeValue":"20"}]',
       4)
     ,('结算方式代码', '902',
       '[{"encodeDesc":"无条件的支付方式","encodeName":"信用证","encodeValue":"30"},{"encodeDesc":"指委托人（债权人）向银行（托收行）提交凭以收取款项的金融票据或商业银行单据或两者兼有，要求托收行通过其联行或代理行（或提示行〉向付款人（傲务人）请其付款的一种结算方式","encodeName":"托收","encodeValue":"20"},{"encodeDesc":"出票人签发的，委托付款人在指定日期无条件支付确定的金额给收款人或者持票人的票据","encodeName":"商业汇票","encodeValue":"82"},{"encodeDesc":"出靈人签发的.委托办湮支票存款业务的菽行在见票时无条件支付确定的金额给收款人或者持票人的票据","encodeName":"支票","encodeValue":"84"},{"encodeDesc":"捋收款人娄托银行向付款人殴取款瑜的结命方式","encodeName":"委托收获","encodeValue":"70"},{"encodeDesc":"是指汇款人委托银行将秋项支何给收歎人的结算方式","encodeName":"汇兑","encodeValue":"50"},{"encodeDesc":"指银行（或其他金啟机构或商业团体或个人）应某交易的一•方当爭人Z要求，向交易的另一方担保该交易项之某种贵任威义务.IS行所做出的在一定期限内承担--定金额支付负任或经济赂偿贵任的书血付款保证承诺","encodeName":"保函","encodeValue":"40"},{"encodeDesc":"指银行汇票、商业汇票、银行本票和支票","encodeName":"票据","encodeValue":"80"},{"encodeDesc":"银行签发的，承诺自己在见票时无条祚文付磁定的金额给收款人或者持累人的票据","encodeName":"银行本粟","encodeValue":"83"},{"encodeDesc":"根据购销合同，由收款人发负后委托银行向异地付款人收取款项，由付款人向慑行预认付款的结算方式","encodeName":"托收承付","encodeValue":"60"},{"encodeDesc":"商业银行向个人和单位发行金、凭此向特约单位购物、消费和向银行存取現金，且具有消费值用的特制载体卡片","encodeName":"银行卡","encodeValue":"90"},{"encodeDesc":"出票人签发的.由其在见票时按照实际结算金额无条件支付确定的金额给收款人或者持票人的票据","encodeName":"银行汇祭","encodeValue":"81"}]',
       4)
     ,('账户类型代码', '528',
       '[{"encodeDesc":"核算银行非内部、贷款、存款、同业往来业务的账户","encodeName":"其他账户","encodeValue":"5"},{"encodeDesc":"核算有价单证、重要空白凭证以及或有资产和或有负债等的账户","encodeName":"表外户","encodeValue":"6"},{"encodeDesc":"核算银行存款业务的账户","encodeName":"存款户","encodeValue":"3"},{"encodeDesc":"核算银行同业往来业务的账户","encodeName":"同业往来户","encodeValue":"4"},{"encodeDesc":"核算银行贷歎业务的账户","encodeName":"贷款户","encodeValue":"2"}]',
       4)
     ,('结息方式代码', '628',
       '[{"encodeDesc":"根据合同规定，利息分次支付","encodeName":"分次付息","encodeValue":"2"},{"encodeDesc":"根据合同规定的英他利息支付方式","encodeName":"其他","encodeValue":"9"}]',
       4)
     ,('有效证件类型代码', '326',
       '[{"encodeName":"武警文职干部退休证","encodeValue":"35"},{"encodeName":"武警文职干部证","encodeValue":"33"},{"encodeName":"文职干部退休证","encodeValue":"25"},{"encodeName":"户口簿","encodeValue":"40"},{"encodeName":"武警身份证件","encodeValue":"30"},{"encodeName":"士兵证","encodeValue":"21"},{"encodeDesc":"银行会计科目类型代码","encodeName":"护照","encodeValue":"50"},{"encodeName":"香港、澳门、台湾居民有效身份证件","encodeValue":"60"},{"encodeName":"武警士兵证","encodeValue":"31"},{"encodeName":"军官退休证","encodeValue":"24"},{"encodeName":"军人身份证","encodeValue":"20"},{"encodeName":"军官证","encodeValue":"22"},{"encodeName":"警官证","encodeValue":"32"},{"encodeName":"文职干部证","encodeValue":"23"},{"encodeName":"武警军官退休证","encodeValue":"34"}]',
       4)
     ,('资产保全方式代码', '630',
       '[{"encodeDesc":"通过诉前、诉讼、证摇保全等法律手段进行的资产保全方式","encodeName":"依法保全","encodeValue":"20"},{"encodeDesc":"根据人民银行和財政部的冇关规定作为呆账进行核销的资产保全方式","encodeName":"呆账核销","encodeValue":"50"},{"encodeDesc":"以以物抵傥或抵押进行的荒产保全方式","encodeName":"抵押保全","encodeValue":"30"},{"encodeDesc":"其他资产保全方式","encodeName":"其他","encodeValue":"90"},{"encodeDesc":"通过各种协议进行的资产保全方式","encodeName":"协议保全","encodeValue":"40"}]',
       4)
     ,('还款方式代码', '624',
       '[{"encodeDesc":"根据合同规迄分期归还本金","encodeName":"分期还款","encodeValue":"20"},{"encodeDesc":"根据合同规定分期同金额归还本金","encodeName":"等额还款","encodeValue":"21"},{"encodeDesc":"借贷双方协商的其他还啟方式","encodeName":"其他方式","encodeValue":"99"},{"encodeDesc":"根据合同规定分期不同金额归还本金","encodeName":"不等额还款","encodeValue":"22"}]',
       4)
     ,('合同状态代码', '612',
       '[{"encodeDesc":"合同已签署但尚未生效","encodeName":"未生效","encodeValue":"200"},{"encodeDesc":"已签署债券变更合同","encodeName":"债权变更","encodeValue":"322"},{"encodeDesc":"合同正常执行","encodeName":"正常执行","encodeValue":"310"},{"encodeDesc":"合同生效但尚未发生提款","encodeName":"未发生提款","encodeValue":"311"},{"encodeDesc":"已签署的上述以外的其他变更合同","encodeName":"其他变更","encodeValue":"329"},{"encodeDesc":"合同处于生效状态","encodeName":"生效","encodeValue":"300"},{"encodeDesc":"合同执行完毕并失效","encodeName":"执行完毕","encodeValue":"410"},{"encodeName":"其他","encodeValue":"315"},{"encodeDesc":"合同处于还款期","encodeName":"还款期","encodeValue":"314"},{"encodeDesc":"合同还款期已过但贷款尚未还清","encodeName":"逾期","encodeValue":"330"},{"encodeDesc":"合同项下已发生提款并处于提款期","encodeName":"提款期","encodeValue":"312"},{"encodeDesc":"合同被人为终止并失效","encodeName":"终止","encodeValue":"420"},{"encodeDesc":"合同同时处于提款期和还款期","encodeName":"在贷还本期","encodeValue":"313"},{"encodeName":"变更","encodeValue":"320"},{"encodeDesc":"合同被暂时中止","encodeName":"中止","encodeValue":"340"},{"encodeDesc":"合同己失效","encodeName":"失效","encodeValue":"400"},{"encodeName":"周期","encodeValue":"321"}]',
       4)
     ,('银行会计科目类型代码', '506',
       '[{"encodeDesc":"用以标明所有者权益类科目","encodeName":"所有者权益类","encodeValue":"3"},{"encodeDesc":"用以标明收入、支出等损益类科目","encodeName":"损益类","encodeValue":"4"},{"encodeName":"其他","encodeValue":"9"},{"encodeDesc":"用以标明负债类科目","encodeName":"负债类","encodeValue":"2"},{"encodeDesc":"用以标明资产负债共同类科目","encodeName":"资产负债共同类","encodeValue":"5"},{"encodeDesc":"用以标明有价单证、重要空白凭证及或有资产和或有负债等内容的项目","encodeName":"表外","encodeValue":"6"}]',
       4)
     ,('客户信用评级代码', '310',
       '[{"encodeDesc":"客户信用综合分值最低的客户","encodeName":"C级","encodeValue":"35"},{"encodeDesc":"客户信用综合分值次低的客户","encodeName":"B级","encodeValue":"25"},{"encodeDesc":"客户信用综合分值次高的客丿","encodeName":"AA级","encodeValue":"13"},{"encodeDesc":"客户信用综令分值较高的客户","encodeName":"A级","encodeValue":"15"},{"encodeDesc":"客户信用综合分值较低的客户","encodeName":"BB级","encodeValue":"23"},{"encodeDesc":"客户信用综合分值中间的客户","encodeName":"BBB级","encodeValue":"21"}]',
       4)
     ,('贷款期限类型代码', '626', '[{"encodeName":"中长期","encodeValue":"2"},{"encodeName":"其他","encodeValue":"9"}]', 4);
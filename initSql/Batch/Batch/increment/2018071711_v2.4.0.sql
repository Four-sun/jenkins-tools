-- 修改batchAlarm表的senderType范围以支持钉钉告警
 ALTER TABLE `rdos_batch_alarm`
CHANGE COLUMN `sender_type` `sender_type` INT(4) NOT NULL DEFAULT '0' COMMENT '发送的客户端类型 0x001: 邮件 0x010: 短信' ;
ALTER TABLE `rdos_stream_alarm`
CHANGE COLUMN `sender_type` `sender_type` INT(4) NOT NULL ;


-- 脚本类型
INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('3', 'Python 2.x', '1', 'Python 2.x', 'Python 2.x', '2', now(), now(), '0'),
('3', 'Python 3.x', '2', 'Python 3.x', 'Python 3.x', '3', now(), now(), '0'),
('3', 'Shell', '3', 'Shell', 'Shell', '4', now(), now(), '0')
on duplicate key update gmt_create=values(gmt_create);


alter ignore table rdos_table_project_data_history add unique key idx(`project_id`,`gmt_create`);

-- 修改batchAlarm表的senderType范围以支持钉钉告警
ALTER TABLE `rdos_batch_alarm`
CHANGE COLUMN `sender_type` `sender_type` INT(4) NOT NULL DEFAULT '0' COMMENT '发送的客户端类型 0x001: 邮件 0x010: 短信' ;
ALTER TABLE `rdos_stream_alarm`
CHANGE COLUMN `sender_type` `sender_type` INT(4) NOT NULL ;


alter table rdos_batch_task MODIFY column sql_text LONGTEXT NOT NULL COMMENT 'sql 文本';
alter table rdos_batch_task_shade MODIFY column sql_text LONGTEXT NOT NULL COMMENT 'sql 文本';
alter table rdos_engine_job_cache MODIFY column job_info LONGTEXT NOT NULL COMMENT 'sql 文本';
alter table rdos_batch_task_version MODIFY column sql_text LONGTEXT NOT NULL COMMENT 'sql 文本';
alter table rdos_batch_hive_select_sql MODIFY column sql_text LONGTEXT NULL COMMENT 'sql 文本';


-- 添加离线任务的模版表
-- 默认离线任务模版
CREATE TABLE `rdos_batch_task_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_type` tinyint(2) NOT NULL COMMENT '任务类型',
  `type` tinyint(2) NOT NULL COMMENT '1-ods  2-dwd  3-dws  4-ads  5-dim',
  `content` text NOT NULL COMMENT '任务内容',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
INSERT INTO `rdos_batch_task_template`(`task_type`,`type`,`content`)
VALUES
  ('0', '1',
'--name exam_ods_ddl
--authour shenhang
--create time 2018-07-24 12:08:05
--desc ods建表语句
create table if not exists ods_order_header (
     order_header_id     string comment ''订单头id''
    ,order_date          bigint comment ''订单日期''
    ,shop_id             string comment ''店铺id''
    ,customer_id         string comment ''客户id''
    ,order_status        bigint comment ''订单状态''
    ,pay_date            bigint comment ''支付日期''

)comment ''销售订单明细表''
PARTITIONED BY (ds string) lifecycle 1000;

create table if not exists ods_order_detail (
     order_header_id     string comment ''订单头id''
    ,order_detail_id     string comment ''订单明细id''
    ,item_id             string comment ''商品id''
    ,quantity            double comment ''商品数量''
    ,unit_price          double comment ''商品单价''
    ,dist_amout          double comment ''折扣金额''
)comment ''销售订单明细表''
PARTITIONED BY (ds string) lifecycle 1000;


create table if not exists exam_ods_shop_info (
     shop_id                string comment ''店铺id''
    ,shop_name              string comment ''店铺名称''
    ,shop_type              string comment ''店铺类型''
    ,address                string comment ''店铺地址''
    ,status                 string comment ''店铺状态,open/closed''
)comment ''店铺维度表''
PARTITIONED BY (ds string) lifecycle 1000;'),
('0','2',
'--name exam_dwd_sales_ord_df
--authour shenhang
--create time 2018-07-24 12:08:05
--desc 订单明细表
create table if not exists exam_dwd_sales_ord_df (
     order_header_id     string comment ''订单头id''
    ,order_detail_id     string comment ''订单明细id''
    ,order_date          bigint comment ''订单日期''
    ,pay_date            bigint comment ''付款日期''
    ,shop_id             string comment ''店铺id''
    ,customer_id         string comment ''客户id''
    ,item_id             string comment ''商品id''
    ,quantity            bigint comment ''商品数量''
    ,unit_price          double comment ''商品单价''
    ,amount              double comment ''总金额''
)comment ''销售订单明细表''
PARTITIONED BY (ds string) lifecycle 1000;


INSERT OVERWRITE TABLE exam_dwd_sales_ord_df PARTITION(ds = ''${bdp.system.bizdate}'')
select
 d.order_header_id
,d.order_detail_id
,h.order_date
,h.pay_date
,h.shop_id
,h.customer_id
,d.item_id
,d.quantity
,d.unit_price
,d.quantity*d.unit_price-d.dist_amout as amount
from ods_order_header as h join ods_order_detail as d on h.order_header_id = d.order_header_id
where h.ds = ''${bdp.system.bizdate}'' and d.ds= ''${bdp.system.bizdate}''
and h.order_status = 0;
'),
('0','3',
'--name exam_dws_sales_shop_1d
--authour shenhang
--create time 2018-07-24 12:08:05
--desc 最近一天门店粒度销售汇总表
create table if not exists exam_dws_sales_shop_1d (
     stat_date              string comment ''统计日期''
    ,shop_id                string comment ''订单明细id''
    ,ord_quantity_1d        bigint comment ''最近一天订单数量''
    ,ord_amount_1d          double comment ''最近一天订单金额''
    ,pay_quantity_1d        bigint comment ''最近一天付款数量''
    ,pay_amount_1d          double comment ''最近一天付款金额''
)comment ''最近一天门店粒度销售汇总表''
PARTITIONED BY (ds string) lifecycle 1000;

INSERT OVERWRITE TABLE exam_dws_sales_shop_1d PARTITION(ds = ''${bdp.system.bizdate}'')
select
 ''${bdp.system.bizdate}'' as stat_date
,shop_id
,sum(case when order_date = ''${bdp.system.bizdate}'' then quantity end) as ord_quantity_1d
,sum(case when order_date = ''${bdp.system.bizdate}'' then amount end)   as ord_amount_1d
,sum(case when pay_date = ''${bdp.system.bizdate}''   then quantity end) as pay_quantity_1d
,sum(case when pay_date = ''${bdp.system.bizdate}''   then amount end)   as pay_amount_1d
from
exam_dwd_sales_ord_df
where ds = ''${bdp.system.bizdate}''
group by shop_id;'),
('0','4',
'--name exam_ads_sales_all_d
--authour shenhang
--create time 2018-07-24 12:08:05
--desc 订单交易总表
create table if not exists exam_ads_sales_all_d (
     stat_date              string comment ''统计日期''
    ,ord_quantity           bigint comment ''订单数量''
    ,ord_amount             double comment ''订单金额''
    ,pay_quantity           bigint comment ''付款数量''
    ,pay_amount             double comment ''付款金额''
    ,shop_cnt               bigint comment ''有交易的店铺数量''
)comment ''订单交易总表''
PARTITIONED BY (ds string) lifecycle 7;

INSERT OVERWRITE TABLE exam_ads_sales_all_d PARTITION(ds = ''${bdp.system.bizdate}'')
select
 ''${bdp.system.bizdate}'' as stat_date
,sum(ord_quantity_1d) as ord_quantity
,sum(ord_amount_1d)   as ord_amount
,sum(pay_quantity_1d) as pay_quantity
,sum(pay_amount_1d)   as pay_amount
,count(distinct shop_id) as shop_cnt
from
exam_dws_sales_shop_1d
where ds = ''${bdp.system.bizdate}''
group by shop_id;'),
('0','5',
'--name exam_dim_shop
--authour shenhang
--create time 2018-07-24 12:08:05
--desc 店铺维度表
create table if not exists exam_dim_shop (
     shop_id                string comment ''店铺id''
    ,shop_name              string comment ''店铺名称''
    ,shop_type              string comment ''店铺类型''
    ,address                string comment ''店铺地址''
)comment ''店铺维度表''
PARTITIONED BY (ds string) lifecycle 365;

INSERT OVERWRITE TABLE exam_dim_shop PARTITION(ds = ''${bdp.system.bizdate}'')
select
 shop_id
,shop_name
,shop_type
,address
from exam_ods_shop_info
where ds = ''${bdp.system.bizdate}''
and status = ''open'';');
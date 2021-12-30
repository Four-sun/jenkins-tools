-- 数据模型初始化数据
delete from `rdos_batch_model_table` where tenant_id = -1 and project_id = -1;
INSERT INTO `rdos_batch_model_table`
(`tenant_id`,`project_id`,`type`,`name`,`prefix`,`model_desc`,`life_day`,`depend`,`create_user_id`,`modify_user_id`)
VALUES
(-1,-1,1,"ods","ods","操作数据层",1000,1,-1,-1),
(-1,-1,1,"dwd","dwd","数据仓库明细层",365,1,-1,-1),
(-1,-1,1,"dws","dws","数据仓库汇总层",90,1,-1,-1),
(-1,-1,1,"ads","ads","数据应用层",7,1,-1,-1),
(-1,-1,1,"tmp","tmp","临时表",7,0,-1,-1),
(-1,-1,1,"dim","dim","维度表",30,0,-1,-1),
(-1,-1,2,"sales","sales","销售",null,0,-1,-1),
(-1,-1,2,"customer","cust","客户",null,0,-1,-1),
(-1,-1,2,"marketing","mkt","市场",null,0,-1,-1),
(-1,-1,2,"purchasing","purch","采购",null,0,-1,-1),
(-1,-1,2,"manufacturing","manu","生产",null,0,-1,-1),
(-1,-1,2,"logistics","logi","物流",null,0,-1,-1),
(-1,-1,2,"warehouse","wms","仓储",null,0,-1,-1),
(-1,-1,2,"finance","fin","财务",null,0,-1,-1),
(-1,-1,2,"customer service","csc","客服",null,0,-1,-1),
(-1,-1,2,"human resources","hr","人力资源",null,0,-1,-1),
(-1,-1,2,"product","prod","产品",null,0,-1,-1),
(-1,-1,2,"public","pub","公共",null,0,-1,-1),
(-1,-1,3,"realtime","r","实时",null,0,-1,-1),
(-1,-1,3,"minute","min","分钟",null,0,-1,-1),
(-1,-1,3,"hour","h","小时",null,0,-1,-1),
(-1,-1,3,"day","d","天",null,0,-1,-1),
(-1,-1,3,"week","w","周",null,0,-1,-1),
(-1,-1,3,"month","m","月",null,0,-1,-1),
(-1,-1,3,"year","y","年",null,0,-1,-1),
(-1,-1,4,"inc","i","增量",null,0,-1,-1),
(-1,-1,4,"full","f","全量",null,0,-1,-1);


delete from `rdos_batch_model_rule` where tenant_id = -1 and project_id = -1;
INSERT INTO `rdos_batch_model_rule`
(`tenant_id`,`project_id`,`rule`,`create_user_id`,`modify_user_id`)
VALUES(-1,-1,"[1,2,5,3,4]",-1,-1);

-- 新增数据源
INSERT INTO `rdos_dict`(`type`,`dict_name`,`dict_value`,`dict_name_zh`,`dict_name_en`,`dict_sort`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('1', 'Redis', '12', 'Redis', 'Redis', '12', now(), now(), '0'),
('1', 'MongoDB', '13', 'MongoDB', 'MongoDB', '13', now(), now(), '0')
on duplicate key update gmt_create=values(gmt_create);
update rdos_dict set is_deleted = 0 where dict_name = "PostgreSQL";


-- 新增项目置顶关系表
CREATE TABLE if not exists `rdos_project_stick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL DEFAULT '0' COMMENT '租户id',
  `project_id` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `stick` datetime COMMENT '置顶字段',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
PRIMARY KEY (`id`),
UNIQUE KEY `idx_project_user` (`project_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目的置顶记录表';


drop procedure if exists schema_change;
delimiter //
create procedure schema_change()
begin

    if not exists (
        select * from information_schema.columns where table_name = 'rdos_batch_task_shade' and column_name = 'owner_user_id'
    ) then
        ALTER TABLE `rdos_batch_task_shade` add  `owner_user_id`  int(11)  COMMENT '负责人id';
        UPDATE `rdos_batch_task_shade` SET `owner_user_id` = `create_user_id`;
    end if;

    if not exists (
        select * from information_schema.columns where table_name = 'rdos_batch_task' and column_name = 'owner_user_id'
    ) then
        ALTER TABLE rdos_batch_task add  `owner_user_id`  int(11)  COMMENT '负责人id';
        UPDATE `rdos_batch_task` SET `owner_user_id` = `create_user_id`;
    end if;

    if exists (
        select * from information_schema.statistics where table_name = 'rdos_batch_hive_select_sql' and index_name = 'idx'
    ) then
        ALTER TABLE `rdos_batch_hive_select_sql` DROP INDEX `idx`;
        ALTER ignore TABLE `rdos_batch_hive_select_sql` ADD UNIQUE INDEX `idx` (`job_id`(128) ASC);
    end if;

    if not exists (
        select * from information_schema.statistics where table_name = 'rdos_batch_table_table' and index_name = 'unique_idx'
    )then
       alter ignore table `rdos_batch_table_table` add UNIQUE KEY `unique_idx` (`unique_key`);
    end if;

end//
delimiter ;

call schema_change();
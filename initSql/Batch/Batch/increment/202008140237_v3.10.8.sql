alter table rdos_batch_package add column package_type int(11) not null comment " 一键发布0 导入导出1";
alter table rdos_batch_package add column path varchar(500) DEFAULT null comment "如果式导入 则为导入的压缩包的path";
alter table rdos_batch_package add column path_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment "用于后期判断zip的导入时间是否过期";


alter table rdos_batch_package_item add column status int(11) not null comment "表示条目发布是否成功";
alter table rdos_batch_package_item add column log text DEFAULT null comment "条目发布时的日志记录";
alter table rdos_batch_package_item add column type int(11) not null comment "条目属于 0一键发布  1导入导出";
alter table rdos_batch_package_item add column item_name varchar(255) DEFAULT null comment "条目名称 作为冗余字段";



drop index idx on rdos_batch_package_item ;

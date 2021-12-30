-- 单表规则分类
ALTER TABLE dq_function ADD COLUMN type tinyint(1) NOT NULL DEFAULT '0' COMMENT '规则分类 1-完整性校验,2-准确性校验,3-规范性校验,4-唯一性校验';
-- 1-完整性校验  表行数，空值数，空值率，空串数，空串率
update dq_function set type = 1 where id in (1, 3, 4, 5, 6);
-- 2-准确性校验  负值比，零值比，正值比，求平均，求和
update dq_function set type = 2, name_zc = '求和' where id = 21;
update dq_function set type = 2, name_zc = '求平均' where id = 20;
update dq_function set type = 2 where id in (13, 14, 15);
-- 3-规范性校验 数值-取值范围,数值-枚举范围,数值-枚举个数,格式-身份证号格式,格式-手机号,格式-邮箱,字符串-最大长度,字符串-最小长度
update dq_function set type = 3, name_zc = '数值-取值范围' where id = 25;
update dq_function set type = 3, name_zc = '数值-枚举范围' where id = 11;
update dq_function set type = 3, name_zc = '数值-枚举个数' where id = 12;
update dq_function set type = 3, name_zc = '格式-身份证号' where id = 22;
update dq_function set type = 3, name_zc = '格式-手机号' where id = 23;
update dq_function set type = 3, name_zc = '格式-邮箱' where id = 24;
update dq_function set type = 3, name_zc = '字符串-最大长度' where id = 16;
update dq_function set type = 3, name_zc = '字符串-最小长度' where id = 17;
-- 4-唯一性校验  重复数，重复率，非重复个数，非重复占比
update dq_function set type = 4 where id in (7, 8);
update dq_function set type = 4, name_zc = '非重复个数' where id = 9;
update dq_function set type = 4, name_zc = '非重复占比' where id = 10;
-- 删除 max和min两个function，包含在取之范围中
update dq_function set is_deleted = 1 where id in (2,18, 19);

-- 函数分类排序字段
ALTER TABLE dq_function ADD COLUMN `sort` tinyint(1) NOT NULL DEFAULT '0' COMMENT '排序字段，按函数分类排序';
-- 完整性校验排序
update dq_function set `sort` = 1 where `id` = 1; -- 表行数
update dq_function set `sort` = 2 where `id` = 3; -- 空值数
update dq_function set `sort` = 3 where `id` = 4; -- 空置率
update dq_function set `sort` = 4 where `id` = 5; -- 空串数
update dq_function set `sort` = 5 where `id` = 6; -- 空串率
-- 准确性校验排序
update dq_function set `sort` = 1 where `id` = 21; -- 求和
update dq_function set `sort` = 2 where `id` = 20; -- 求平均
update dq_function set `sort` = 3 where `id` = 13; -- 负值比
update dq_function set `sort` = 4 where `id` = 14; -- 零值比
update dq_function set `sort` = 5 where `id` = 15; -- 正值比
-- 规范性校验
update dq_function set `sort` = 1 where `id` = 25; -- 数值-取值范围
update dq_function set `sort` = 2 where `id` = 11; -- 数值-枚举范围
update dq_function set `sort` = 3 where `id` = 12; -- 数值-枚举个数
update dq_function set `sort` = 4 where `id` = 22; -- 格式-身份证号
update dq_function set `sort` = 5 where `id` = 23; -- 格式-手机号
update dq_function set `sort` = 6 where `id` = 24; -- 格式-邮箱
update dq_function set `sort` = 7 where `id` = 16; -- 字符串-最大长度
update dq_function set `sort` = 8 where `id` = 17; -- 字符串-最小长度
-- 唯一性校验
update dq_function set `sort` = 1 where `id` = 7; -- 重复数
update dq_function set `sort` = 2 where `id` = 8; -- 重复率
update dq_function set `sort` = 3 where `id` = 9; -- 非重复个数
update dq_function set `sort` = 4 where `id` = 10; -- 非重复占比


-- v4.2.2

-- 增加Kafka 2.x数据源
insert into dq_dict values (0, 1, 'KAFKA_2X', 37, 'Kafka2.x', 'KAFKA_2X', 10, now(), now(), 0);
-- 增加kafka 0.11数据源
insert into dq_dict values (0, 1, 'KAFKA_10', 17, 'Kafka_0.10', 'KAFKA_10', 11, now(), now(), 0);
-- 更新Spark数据源展示顺序
update dq_dict set dict_sort = 9 where dict_value = 45 and type = 1;

-- kafka实时校验
create table dq_monitor_stream
(
    `id`              int(11) primary key AUTO_INCREMENT comment '主键id',
    `tenant_id`       int(11)    NOT NULL COMMENT '租户id',
    `project_id`      int(11)    NOT NULL DEFAULT '1' COMMENT '项目ID',
    `monitor_id`      int(11) comment '监控规则id',
    `charset`         varchar(32) comment '编码格式',
    `mapping_columns` varchar(1024) comment '映射字段',
    `upper_limit`     int(11) comment '样本量上限',
    `create_user_id`  int(11)    NOT NULL COMMENT '创建的用户',
    `modify_user_id`  int(11)    NOT NULL COMMENT '修改的用户',
    `gmt_create`      datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`    datetime   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`      tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）规则相关信息';

-- 实时校验的临时表
create table dq_stream_temp_result
(
    `tenant_id`      int(11)     NOT NULL COMMENT '租户id',
    `project_id`     int(11)     NOT NULL DEFAULT '1' COMMENT '项目ID',
    `create_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '创建的用户',
    `modify_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '修改的用户',
    `gmt_create`     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`     tinyint(1)  NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `job_id`         varchar(64) not null comment '引擎的job key',
    `monitor_id`     int(11)     not null comment '监控规则id',
    `rule_id`        int(11)     not null comment '子规则id',
    `val`            varchar(32) comment '校验结果值',
    `check_column`   varchar(64) not null comment '校验的字段',
    PRIMARY KEY (`job_id`,`rule_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）临时数据';

-- 实时校验的脏数据表，用于页面查看、下载明细
create table dq_stream_dirty_result
(
    `id`             int(11) primary key AUTO_INCREMENT comment '主键id',
    `tenant_id`      int(11)     NOT NULL COMMENT '租户id',
    `project_id`     int(11)     NOT NULL DEFAULT '1' COMMENT '项目ID',
    `create_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '创建的用户',
    `modify_user_id` int(11)     NOT NULL DEFAULT '1' COMMENT '修改的用户',
    `gmt_create`     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`     tinyint(1)  NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    `job_id`         varchar(64) not null comment '引擎的job key',
    `monitor_id`     int(11)     not null comment '监控规则id',
    `rule_id`        int(11)     not null comment '子规则id',
    `data`           varchar(1024) comment '脏数据JSON'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 comment '实时校验（抽检）脏数据表';

-- Kafka2x(对应Flink Streaming SQL)
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 37, 'select cast(count(1) as VARCHAR)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 37, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 37, 'select cast(count(1) as VARCHAR) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 37, 'select cast(sum(case when ${col} is null then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 37, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 37, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 37, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 37, 'select cast(sum(case when c>1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 37, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 37, 'select cast(sum(case when c=1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 37, 'select cast(count(1) as VARCHAR) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 37, 'select cast(count(1) as VARCHAR) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 37, 'select cast(sum(case when ${col} < 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 37, 'select cast(sum(case when ${col} = 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 37, 'select cast(sum(case when ${col} > 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 37, 'SELECT cast(max(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 37, 'SELECT cast(min(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 37, 'select cast(max(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 37, 'select cast(min(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 37, 'select cast(avg(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 37, 'select cast(sum(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter}', '${table} where NOT REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[1]([3-9])[0-9]{9}$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[1][35678][0-9]{9}$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 37, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');



-- KAFKA_10(对应Flink Streaming SQL)
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (1, 17, 'select cast(count(1) as VARCHAR)  as val  from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (2, 17, '', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (3, 17, 'select cast(count(1) as VARCHAR) as val from ${table} where ${col} is null ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (4, 17, 'select cast(sum(case when ${col} is null then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} is null ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (5, 17, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (6, 17, 'select cast(sum(case when CHAR_LENGTH(${col})=0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where CHAR_LENGTH(${col})=0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (7, 17, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (8, 17, 'select cast(sum(case when c>1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} t1 where 1=1 ${filter} group by ${col}) temp', '${table} t2 where exists (select  ${col} from ${table} t1 where 1=1 ${filter} ${unionFilter} group by ${col} having count(1) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (9, 17, 'select cast(count(1) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (10, 17, 'select cast(sum(case when c=1 then 1 else 0 end) / sum(c) as VARCHAR) as val from (select count(${col}) as c from ${table} where 1=1 ${filter} group by ${col}) temp', '${table} where ${col} in (select  ${col} from ${table} t1 where 1=1 ${filter} group by ${col} having count(${col}) > 1) ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (11, 17, 'select cast(count(1) as VARCHAR) as val from  ${table}  where  ${col} ${enum}  ${filter}', '${table} where ${col} ${enum} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (12, 17, 'select cast(count(1) as VARCHAR) as val from (select ${col} from ${table} where 1=1 ${filter} group by ${col}) temp', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (13, 17, 'select cast(sum(case when ${col} < 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} < 0 ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (14, 17, 'select cast(sum(case when ${col} = 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} = 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (15, 17, 'select cast(sum(case when ${col} > 0 then 1 else 0 end) / count(1) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col} > 0 ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (16, 17, 'SELECT cast(max(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (17, 17, 'SELECT cast(min(CHAR_LENGTH(${col})) as VARCHAR) as val from ${table} where 1=1 ${filter}','${table} where CHAR_LENGTH(${col})< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (18, 17, 'select cast(max(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}> ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (19, 17, 'select cast(min(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '${table} where ${col}< ${expectation} ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (20, 17, 'select cast(avg(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (21, 17, 'select cast(sum(${col}) as VARCHAR) as val from ${table} where 1=1 ${filter}', '');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (22, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter}', '${table} where NOT REGEXP(${col}, ''(^[1-9][0-9]{5}(18|19|([23][0-9]))[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}[0-9Xx]$)|(^[1-9][0-9]{5}[0-9]{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)[0-9]{3}$)'') ${filter} ');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (23, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[1]([3-9])[0-9]{9}$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[1][35678][0-9]{9}$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (24, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}', '${table} where NOT REGEXP(${col}, ''^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$'') ${filter}');
INSERT INTO dq_function_template (function_id, data_source_type, template, template_query) VALUES (25, 17, 'SELECT cast(count(1) as VARCHAR) AS val FROM ${table} WHERE ${range} ${filter}', '${table} where ${reverse_range} ${filter}');

-- 增加实时校验结果生命周期管理的定时任务
INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '0 0 4 * * ?', 'streamLifecycleJob','streamLifecycleJobGroup','streamLifecycleJobTrigger','streamLifecycleJobTriggerGroup','com.dtstack.dq.schedule.job.StreamLifecycleJob','0',null,null,now(),now(),'0');

INSERT INTO `dt_center_cron_schedule`
(`biz_type`,`cron`,`job_detail_name`,`job_detail_group`,`job_trigger_name`,`job_trigger_group`,`class_name`,`concurrent`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`,`is_deleted`)
VALUES
('dq', '*/15 * * * * ?', 'streamDataSyncJob','streamDataSyncJobGroup','streamDataSyncJobTrigger','streamDataSyncJobTriggerGroup','com.dtstack.dq.schedule.job.StreamDataSyncJob','0',null,null,now(),now(),'0');

ALTER TABLE dq_monitor_stream ADD COLUMN `is_submit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否提交成功 0 提交失败,1 提交成功';
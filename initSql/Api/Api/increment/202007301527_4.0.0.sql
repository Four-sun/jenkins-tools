-- fix 28590
# 升级过程
# 1.da_invoke_count 重命名为 da_invoke_count_all
# 2.da_invoke_count_all 插入索引 invoke_time（耗时）
# 3.建表da_invoke_count
# 4.向da_invoke_count插入30天数据（耗时）
# 5.建表da_invoke_count_day
# 6.向da_invoke_count_day插入所有2年内所有天数据（耗时）
# 7.插入天聚合任务

# 1.da_invoke_count 重命名为 da_invoke_count_all
RENAME TABLE da_invoke_count TO da_invoke_count_all;

# 2.da_invoke_count_all 插入索引 invoke_time（耗时）
alter table da_invoke_count_all
    add index invoke_time (`invoke_time`);

# 3.建表da_invoke_count
create table da_invoke_count
(
    id           int(11) unsigned auto_increment
        primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null,
    project_id   int(11)    DEFAULT NULL COMMENT '项目id',
    index invoke_time (invoke_time)
)
    charset = utf8;

create index app_u_a_i
    on da_invoke_count (app_sign, user_id, api_id);

delimiter //
# 4.向da_invoke_count插入30天数据（耗时）
CREATE PROCEDURE insert_30day()
BEGIN
    DECLARE i INT DEFAULT 30;
    WHILE i >= 0
        DO
            INSERT INTO da_invoke_count (user_id,invoke_time,api_id,count,execute_time,gmt_create,gmt_modified,is_deleted,app_sign,project_id) 
            SELECT user_id,invoke_time,api_id,count,execute_time,gmt_create,gmt_modified,is_deleted,app_sign,project_id
            FROM da_invoke_count_all
            WHERE invoke_time BETWEEN CURDATE() - INTERVAL i DAY AND CURDATE() - INTERVAL i - 1 DAY;
            SET i = i - 1;
        END WHILE;
END;
//
delimiter ;

CALL insert_30day();

# 5.建表da_invoke_count_day
create table da_invoke_count_day
(
    id           int(11) unsigned auto_increment primary key,
    user_id      int                  not null,
    invoke_time  datetime             not null,
    api_id       int                  not null,
    count        int                  not null,
    execute_time int(36)              not null,
    gmt_create   datetime             not null,
    gmt_modified datetime             not null on update CURRENT_TIMESTAMP,
    is_deleted   tinyint(2) default 0 not null comment '0正常 1逻辑删除',
    app_sign     varchar(64)          not null,
    project_id   int(11)    DEFAULT NULL COMMENT '项目id',
    index api_time (api_id, invoke_time)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='调用情况统计表（按日维度）';

delimiter //
# 6.向da_invoke_count_day插入所有2年内所有天数据（耗时）
# 创建调用过程：给客户升级的时候，将da_invoke_count数据转化为da_invoke_count_day（耗时）
CREATE PROCEDURE count_day()
BEGIN
    DECLARE i INT DEFAULT 730;
    WHILE i >= 1
        DO
            INSERT da_invoke_count_day (`invoke_time`, `api_id`, `user_id`, `count`, `execute_time`, `gmt_create`,
                                        `gmt_modified`, `is_deleted`, `app_sign`, `project_id`)
            SELECT concat(LEFT(date_format(invoke.invoke_time, '%Y-%m-%d %H:%i'), 10), ' 00:00:00') AS time_flag,
                   api_id,
                   user_id,
                   sum(invoke.count)                                                                AS callSum,
                   avg(execute_time),
                   NOW(),
                   NOW(),
                   0,
                   'API',
                   project_id
            FROM da_invoke_count invoke
            WHERE
                  invoke.app_sign = 'API'
              AND invoke.invoke_time BETWEEN CURDATE() - INTERVAL i DAY AND CURDATE() - INTERVAL i - 1 DAY
            GROUP BY api_id, user_id, project_id, time_flag;
            SET i = i - 1;
        END WHILE;
END;
//
delimiter ;

CALL count_day();

# 7.插入天聚合任务
INSERT INTO `dt_center_cron_schedule`(`id`, `job_detail_name`, `job_detail_group`, `job_trigger_name`,
                                      `job_trigger_group`, `class_name`, `cron`, `concurrent`, `start_time`, `end_time`,
                                      `biz_type`, `gmt_create`, `gmt_modified`, `is_deleted`)
VALUES (7, 'apiInvokeCountDayJob', 'apiInvokeCountDayJob', 'apiInvokeCountDayJobTrigger',
        'apiInvokeCountDayJobTriggerGroup', 'com.dtstack.da.schedule.job.InvokeCountDayJob', '1 0 0 * * ? ', 0, NULL,
        NULL, 'api', now(), now(), 0);



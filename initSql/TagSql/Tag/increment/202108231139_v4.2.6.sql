alter table dl_tag
    add column update_success
        tinyint(1) default 0 not null comment '是否更新成功过 0 失败 1 成功';

update dt_center_cron_schedule
set cron = '0 0 0/2 * * ? *'
where job_detail_name='groupJob';
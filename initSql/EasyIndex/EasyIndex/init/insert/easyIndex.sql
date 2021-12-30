insert into ei_statis_period(period_name, period_desc, start_date, end_date, is_sys, project_id, tenant_id,
                             is_deleted, gmt_create, gmt_modified, create_user_id, modify_user_id)
values ('当日', '默认为计划运行时间的前一天', '${bdp.system.bizdate}', '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1),
       ('当月', '当月1号截止到当日', '${bdp.system.currmonth}01', '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1),
       ('上月', '上个月1号到上个月月底', '${bdp.system.premonth}01', '${bdp.system.currmonth}01', 1, -1, -1, 0, now(), now(), -1, -1),
       ('当年', '当年1月1号截止到当日', '${format(yyyyMMddHHmmss,\'yyyy\')}0101', '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1),
       ('去年', '去年1月1号到去年年底', '${format(yyyyMMddHHmmss-1y,\'yyyy\')}0101', '${format(yyyyMMdd,\'yyyy\')}0101', 1, -1, -1, 0, now(), now(), -1, -1),
       ('最近7天', '基于业务日期的近7天', '$[yyyyMMdd-7]', '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1),
       ('最近30天', '基于业务日期的近30天', '$[yyyyMMdd-30]', '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1),
       ('历史截止到当前', '历史累计到当前日期', null, '${yyyyMMdd+1}', 1, -1, -1, 0, now(), now(), -1, -1);
update dt_center_cron_schedule
set cron='0 0/30 * * * ?'
where job_detail_name = 'tagJob';

delete from dl_tag_value_data_count
where (sync_period_type, business_format_time, tag_id) in
      (SELECT t.sync_period_type, t.business_format_time, t.tag_id
       FROM (
                SELECT sync_period_type, business_format_time, tag_id
                FROM dl_tag_value_data_count
                GROUP BY sync_period_type, business_format_time, tag_id
                HAVING count(1) > 1) t)
  and id not in (
    select id
    from (SELECT MAX(t1.id) AS id
          FROM dl_tag_value_data_count t1
          GROUP BY t1.sync_period_type, t1.business_format_time, t1.tag_id
          HAVING count(1) > 1) t2);


alter table dl_tag_value_data_count
    add constraint unique_name
        unique(tag_id,sync_period_type,business_format_time,is_deleted);
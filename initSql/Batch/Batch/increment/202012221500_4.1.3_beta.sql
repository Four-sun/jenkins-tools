update dt_center_cron_schedule set is_deleted = 1, gmt_modified = now() where job_detail_name = 'BatchJobStateCountJob';

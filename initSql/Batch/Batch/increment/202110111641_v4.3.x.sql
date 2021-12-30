CREATE INDEX index_project_id ON rdos_batch_alarm_record (project_id);
CREATE INDEX index_job_id ON rdos_batch_task_process_record (job_id);
CREATE INDEX index_source_id ON rdos_batch_table_sync_log (source_id);
CREATE INDEX index_task_id ON rdos_batch_task_version (task_id);
CREATE INDEX index_project_id ON rdos_batch_task_version (project_id);
CREATE INDEX index_component_id ON rdos_batch_task (component_id);
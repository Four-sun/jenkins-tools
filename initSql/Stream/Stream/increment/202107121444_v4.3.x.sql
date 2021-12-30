BEGIN;
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Greenplum', now(), now(), '0', '1', '36');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Greenplum', now(), now(), '0', '5', '36');
insert into `rdos_stream_support_data_source` ( `data_source_name`, `gmt_modified`, `gmt_create`, `is_deleted`, `type`, `data_source_value`) values ( 'Greenplum', now(), now(), '0', '7', '36');
COMMIT;
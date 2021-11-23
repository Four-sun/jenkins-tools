update dl_tag_task set engine_type = 30 where engine_type = 22;

update  dt_pub_service.dsc_info dd, (select id ,FROM_BASE64(data_json) as data_json, FROM_BASE64(link_json) as link_json, data_type
    from dt_pub_service.dsc_info di
    where data_type='Presto'
    and di.id in (select data_source_id from tagapp.dl_project where is_deleted=0)) b
set dd.data_type='Trino',
    dd.data_type_code = 59,
    dd.data_json = REPLACE(REPLACE(TO_BASE64(REPLACE(b.data_json, 'jdbc:presto', 'jdbc:trino')), CHAR(10), ''), CHAR(13),''),
    dd.link_json = REPLACE(REPLACE(TO_BASE64(REPLACE(b.link_json, 'jdbc:presto', 'jdbc:trino')), CHAR(10), ''), CHAR(13),'')
where dd.data_type='Presto' and dd.is_deleted=0 and dd.id = b.id;
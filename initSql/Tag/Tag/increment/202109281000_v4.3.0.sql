update dl_api
set is_deleted=1
where entity_id not in (select e.id from dl_entity e where e.is_deleted = 0);
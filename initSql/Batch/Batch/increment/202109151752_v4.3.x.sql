
-- 更新userid为uic的userid
update rdos_batch_apply a
left join rdos_user c on c.id=a.deal_user_id and c.is_deleted=0
set a.deal_user_id=c.dtuic_user_id
where a.is_deleted=0 and a.deal_user_id is not null;

update rdos_batch_package a
left join rdos_user c on c.id=a.publish_user_id and c.is_deleted=0
set a.publish_user_id=c.dtuic_user_id
where a.is_deleted=0 and a.publish_user_id is not null;
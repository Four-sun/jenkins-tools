delete from dl_user where is_deleted = 1;

delete
from dl_user
where id in (
    select u.id
    from (select id
          from dl_user
          where dtuic_user_id
              in (
                    select dtuic_user_id
                    from dl_user
                    where is_deleted = 0
                    group by dtuic_user_id
                    having count(*) > 1
                )
            and id
              not in
                (
                    select min(id)
                    from dl_user
                    where is_deleted = 0
                    group by dtuic_user_id
                    having count(*) > 1
                )) u
);

update dl_role_user
set is_deleted = 1
where user_id in (
    select id
    from dl_user
    where dl_user.is_deleted = 1
);

ALTER TABLE dl_user ADD UNIQUE  index_uic_user_id (dtuic_user_id, is_deleted);
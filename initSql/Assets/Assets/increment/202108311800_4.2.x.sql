-- 修改资源目录表结构
alter table assets_resource_catalog
  add column next_id bigint(20) COMMENT '后一个节点id',
  add column prev_id bigint(20) COMMENT '前一个节点id',
  add column child_id bigint(20) COMMENT '子节点id',
  modify column parent_id bigint(20) NULL COMMENT '父节点id';

update assets_resource_catalog set parent_id = null where parent_id = -1;

-- >>>start 资源目录数据迁移<<<

-- 递归查询树子孙节点 并组装成字符串
-- set global log_bin_trust_function_creators=TRUE;
delimiter $$
drop function if exists func_recursive_get_child$$
create function func_recursive_get_child(in_id varchar(10)) returns varchar(500)
begin
  declare ids varchar(500) default '';
  declare temp_ids varchar(500);
  set temp_ids = in_id;
  while temp_ids is not null do
  set ids = concat_ws(',',ids,temp_ids);
  select group_concat(id) into temp_ids from assets_resource_catalog
  where find_in_set(parent_id,temp_ids) > 0;
  end while;
  return ids;
end
$$
delimiter ;

-- 创建一个临时辅助表用于字符串切分
drop table  if exists tmp_index_table;
create  table tmp_index_table(id INT UNSIGNED NOT NULL auto_increment primary key);
delimiter $$
drop procedure if exists func_creat_tmp_index_table$$
create procedure func_creat_tmp_index_table()
begin
  declare v_id,v_max int(10) unsigned;
  set v_id = 1;
  set v_max = 2000;
  while v_id < v_max do
  insert into tmp_index_table values(v_id);
  set v_id = v_id + 1;
  end while;
end
$$
delimiter ;

-- 创建id辅助表
drop table  if exists tmp_id_table;
create table `tmp_id_table` (`id` int(10) DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 更新目录前后节点id
delimiter $$
drop procedure if exists func_update_node$$
create procedure func_update_node(v_str varchar(1000))
begin
  declare v_sq int unsigned;
  declare v_sq1 int unsigned;
  declare v_sq2 int unsigned;
  set v_str = concat(v_str,',-1');
  truncate tmp_id_table;
  insert into tmp_id_table values(-1);
  insert into tmp_id_table(id) (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_str,',',id+1),',',-1) AS tid
                                FROM tmp_index_table
                                WHERE tmp_index_table.id < LENGTH(v_str)-LENGTH(REPLACE(v_str,',',''))+1);

  set v_sq = 0;
  ud_loop:
    loop
      set v_sq1 = v_sq +1;
      set v_sq2 = v_sq +2;
      if (select id from tmp_id_table limit v_sq1,1) is null then
        leave ud_loop;
      end if;

      update assets_resource_catalog a
        inner join (select id from tmp_id_table limit v_sq,1) b
        inner join (select id from tmp_id_table limit v_sq2,1) c
        inner join (select id from tmp_id_table limit v_sq1,1) d
      set
        prev_id = if(b.id = -1, null, b.id),
        next_id = if(c.id = -1, null, c.id)
      where a.id = d.id;
      set v_sq = v_sq1;
    end loop;
end
$$
delimiter ;


-- 按租户id查询根节点目录
delimiter $$
drop procedure if exists func_handle_catalog_root$$
create procedure func_handle_catalog_root(v_tenant_id int)
begin
  declare done int default 0;
  declare v_root_id bigint(20) default null;
  declare v_cur cursor for
    select id from assets_resource_catalog where tenant_id = v_tenant_id and is_deleted = 0 and parent_id is null;

  declare continue handler for not found
    set done =1;

  open v_cur;
  start_loop :
    loop
      fetch v_cur into  v_root_id;
      if done = 1 then
        leave start_loop;

      end if;
      call func_update_node(func_recursive_get_child(v_root_id));
    end loop;
  close v_cur;
end;
$$
delimiter ;

-- 获取所有租户 按租户处理数据
delimiter $$
drop procedure if exists func_foreach_tenant$$
create procedure func_foreach_tenant()
begin
  declare done int default 0;
  declare v_tenant_id bigint(20) default null;
  declare v_cur cursor for
    select id from assets_tenant where is_deleted = 0;

  declare
    continue handler for not found
      set done = 1;
  -- 打开游标
  open v_cur;
  rd_loop :
    loop
      fetch v_cur into v_tenant_id;
      if
          done = 1 then
        leave rd_loop;
      end if;

      call func_handle_catalog_root(v_tenant_id);
    end loop;
  close v_cur;
end;
$$
delimiter ;

call func_creat_tmp_index_table();
call func_foreach_tenant();

-- 更新目前child_id
update assets_resource_catalog a
  inner join (select id,parent_id from assets_resource_catalog where parent_id = prev_id) b
set a.child_id = b.id
where a.id = b.parent_id;

update assets_resource_catalog a
  inner join (select id,parent_id,next_id from assets_resource_catalog) b
set a.prev_id = a.parent_id
where a.id = b.next_id and a.parent_id != b.parent_id;

update assets_resource_catalog a
  inner join (select id,parent_id,next_id from assets_resource_catalog) b
set a.next_id = null
where a.next_id = b.id and a.parent_id != b.parent_id;

-- 同级目录处理

-- 更新目录前后节点id
delimiter $$
drop procedure if exists func_update_same_level_node$$
create procedure func_update_same_level_node(v_str varchar(1000))
begin
  declare v_sq int unsigned;
  declare v_sq1 int unsigned;
  declare v_sq2 int unsigned;
  declare v_st2 varchar(500);

  truncate tmp_id_table;

  set v_str = concat('-1,',v_str,',-1');

  insert into tmp_id_table(id)values(-1);
  insert into tmp_id_table(id) (SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(v_str,',',id+1),',',-1) AS tid
                                FROM tmp_index_table
                                WHERE tmp_index_table.id < LENGTH(v_str)-LENGTH(REPLACE(v_str,',',''))+1);

  set v_sq = 0;
  select group_concat(id) into v_st2 from tmp_id_table;

  ud_loop:
    loop
      set v_sq1 = v_sq +1;
      set v_sq2 = v_sq +2;
      if (select id from tmp_id_table limit v_sq1,1) is null then
        leave ud_loop;
      end if;

      update assets_resource_catalog a
        inner join (select id from tmp_id_table limit v_sq,1) b
        inner join (select id from tmp_id_table limit v_sq2,1) c
        inner join (select id from tmp_id_table limit v_sq1,1) d
      set
        prev_id = if((b.id = -1 or b.id = -2), null, b.id),
        next_id = if((c.id = -1 or c.id = -2), null, c.id)
      where a.id = d.id and (a.prev_id != a.parent_id or a.parent_id is null);
      set v_sq = v_sq1;
    end loop;
end
$$
delimiter ;

-- 递归处理子孙节点 并组装成字符串，并更新
-- set global log_bin_trust_function_creators=TRUE;
delimiter $$
drop procedure if exists func_recursive_handle_child$$
create procedure func_recursive_handle_child(in_id varchar(10))
begin
  declare ids varchar(500) default '';
  declare temp_ids varchar(500);
  set temp_ids = in_id;
  while temp_ids is not null do
  select group_concat(id) into temp_ids from assets_resource_catalog
  where find_in_set(parent_id,temp_ids) > 0;
  call func_update_same_level_node(temp_ids);
  end while;
end
$$
delimiter ;


-- 按租户id查询根节点目录
delimiter $$
drop procedure if exists func_handle_catalog_by_tenant$$
create procedure func_handle_catalog_by_tenant(v_tenant_id int)
begin
  declare done int default 0;
  declare v_root_id bigint(20) default null;
  declare v_root_id_str varchar(500) default '';
  declare v_cur cursor for
    select id from assets_resource_catalog where tenant_id = v_tenant_id and is_deleted = 0 and parent_id is null;

  declare continue handler for not found
    set done =1;
  open v_cur;
  start_loop :
    loop
      fetch v_cur into  v_root_id;
      if done = 1 then
        leave start_loop;

      end if;
      call func_recursive_handle_child(v_root_id);
    end loop;
  close v_cur;
  select group_concat(id) into v_root_id_str  from assets_resource_catalog where tenant_id = v_tenant_id and is_deleted = 0 and parent_id is null;
  call func_update_same_level_node(v_root_id_str);
end;
$$
delimiter ;

-- 获取所有租户 按租户处理数据
delimiter $$
drop procedure if exists func_foreach_tenant2$$
create procedure func_foreach_tenant2()
begin
  declare done int default 0;
  declare v_tenant_id bigint(20) default null;
  declare v_cur cursor for
    select id from assets_tenant where is_deleted = 0;

  declare
    continue handler for not found
      set done = 1;
  -- 打开游标
  open v_cur;
  rd_loop :
    loop
      fetch v_cur into v_tenant_id;
      if
          done = 1 then
        leave rd_loop;
      end if;

      call func_handle_catalog_by_tenant(v_tenant_id);
    end loop;
  close v_cur;
end;
$$
delimiter ;

call func_foreach_tenant2();

-- 删除辅助表
drop table  if exists tmp_index_table;
drop table  if exists tmp_id_table;

update assets_resource_catalog a
  inner join (select id,parent_id,prev_id from assets_resource_catalog where parent_id = prev_id ) b
set a.child_id = b.id
where a.id = b.parent_id;

-- >>>end 资源目录数据迁移<<<

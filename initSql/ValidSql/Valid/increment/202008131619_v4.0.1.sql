alter table dq_monitor_record
	add monitor_type tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验';

alter table dq_monitor
	add monitor_type tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验';

alter table dq_table
	add monitor_type tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验';

alter table dq_monitor_rule
	add monitor_type tinyint(1) unsigned default 0 null comment '监控规则类型， 0是单表规则；1是多表校验';

alter table dq_verify
	add monitor_id int default 0 null comment '监控规则id';

alter table dq_verify_record
	add monitor_record_id int default 0 null comment '监控规则记录id';

alter table dq_monitor_record_rules
  add status tinyint(1)  default 0 not null comment '状态';

insert into dq_dict VALUES (0,1,'Greenplum',36,'Greenplum','Greenplum',7,now(),now(),0);

INSERT into dq_function_template values
(null,1,36,
'select count(1) as val from ${table} where 1=1 ${filter}',
now(), now(),0,''
);

INSERT into dq_function_template values
  (null,2,36,
   'select count(1) as val from INFORMATION_SCHEMA.COLUMNS  WHERE TABLE_NAME=''${table}'' and TABLE_SCHEMA=''${db}''',
   now(),
   now(),1,
   ''
  );
INSERT into dq_function_template values
  (null,3,36,
   'select count(1) as val from ${table} where ${col} is null ${filter}',
   now(),
   now(),0,
   '${table} where ${col} is null ${filter}'
  );
INSERT into dq_function_template values
  (null,4,36,
   'select round(sum(case when ${col} is null then 1 else 0 end)::numeric / count(1)::numeric, 4) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   ' ${table} where ${col} is null ${filter}'
  );
INSERT into dq_function_template values
  (null,5,36,
   'select sum(case when char_length(text(${col})=0 then 1 else 0 end) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where char_length(text(${col}))=0 ${filter}'
  );

INSERT into dq_function_template values
  (null,6,36,
   'select round(sum(case when char_length(text(${col})) != 0 then 1 else 0 end)::numeric / count(1)::numeric, 4) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where char_length(text(${col}))=0 ${filter}'
  );

INSERT into dq_function_template values
(null,7,36,
'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1) temp ',
now(),
now(),0,
'${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'
);


INSERT into dq_function_template values
(null,8,36,
'select sum(case when count>1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',
now(),
now(),0,
'${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'
);


INSERT into dq_function_template values
(null,9,36,
'select count(1) as val from (select count(${col}) from ${table} where 1=1 ${filter} group by ${col} having count(${col}) = 1) temp	',
now(),
now(),0,
' ${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'
);

INSERT into dq_function_template values
(null,10,36,
'select sum(case when count=1 then 1 else 0 end) / sum(count) as val from (select count(${col}) as count from ${table} where 1=1 ${filter} group by ${col}) temp',
now(),
now(),0,
'${table} where ${col} in (select  ${col} from ${table} where 1=1 ${filter} group by ${col} having count(${col}) > 1)  ${filter}'
);

INSERT into dq_function_template values
(null,11,36,
'select count(1) as val from  ${table} where  ${col} ${enum}  ${filter}',
now(),
now(),0,
'${table} where ${col} ${enum} ${filter}'
);

INSERT into dq_function_template values
  (null,12,36,
   'select count(distinct coalesce(${col},NULL))  as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   ''
  );

INSERT into dq_function_template values
(null,13,36,
'select sum(case when ${col} < 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}',
now(),
now(),0,
'${table} where ${col} < 0 ${filter}'
);

INSERT into dq_function_template values
  (null,14,36,
   'select sum(case when ${col} = 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where ${col} = 0 ${filter}'
  );

INSERT into dq_function_template values
  (null,15,36,
   'select sum(case when ${col} > 0 then 1 else 0 end) / count(1) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where ${col} > 0 ${filter}'
  );


INSERT into dq_function_template values
  (null,16,36,
   'SELECT max(char_length(${col})) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where char_length(${col}) = (select max(char_length(${col})) from ${table} where 1=1 ${filter} ) ${filter}'
  );

INSERT into dq_function_template values
  (null,17,36,
   'SELECT min(char_length(${col})) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where char_length(${col}) = (select min(char_length(${col})) from ${table} where 1=1 ${filter} ) ${filter}'
  );

INSERT into dq_function_template values
  (null,18,36,
   'select max(${col}) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where ${col} = (select max(${col}) from ${table} where 1=1 ${filter} ) ${filter}'
  );

INSERT into dq_function_template values
  (null,19,36,
   'select min(${col}) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   '${table} where ${col} = (select min(${col}) from ${table} where 1=1 ${filter} ) ${filter}'
  );

INSERT into dq_function_template values
  (null,20,36,
   'select avg(${col}) as val from ${table} where 1=1 ${filter}	',
   now(),
   now(),0,
   ''
  );

INSERT into dq_function_template values
  (null,21,36,
   'select sum(${col}) as val from ${table} where 1=1 ${filter}',
   now(),
   now(),0,
   ''
  );
INSERT into dq_function_template values
  (null,22,36,
   "SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}",
   now(),
   now(),0,
   "${table} where text(${col}) !~ '^[1-9][[:digit:]]{7}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}$|^[1-9][[:digit:]]{5}[1-9][[:digit:]]{3}((0[[:digit:]])|(1[0-2]))(([0|1|2][[:digit:]])|3[0-1])[[:digit:]]{3}([0-9]|X)$' ${filter}"
  );

INSERT into dq_function_template values
  (null,23,36,
   "SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[1][35678][0-9]{9}$' ${filter}",
   now(),
   now(),0,
   "${table} where text(${col}) !~ '^[1][35678][0-9]{9}$'  ${filter} "
  );

INSERT into dq_function_template values
  (null,24,36,
   "SELECT count(1) AS val FROM ${table} WHERE text(${col})  ~ '^[-[:alnum:]_]+@[-[:alnum:]_]+.[-[:alnum:]_]+$'  ${filter}",
   now(),
   now(),0,
   "${table} where text(${col}) !~ '^[-[:alnum:]_]+@[-[:alnum:]_]+.[-[:alnum:]_]+$' ${filter}"
  );

update dt_center_cron_schedule set is_deleted = 1 where job_detail_name = 'verifyJob';
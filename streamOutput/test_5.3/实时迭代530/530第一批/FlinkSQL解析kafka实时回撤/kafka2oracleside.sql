


-- name kafka2oracleside
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-30 17:04:05
-- desc 
CREATE TABLE sourceTable(
id int,
name varchar,
age int,
proc_time AS PROCTIME()
)WITH(
'properties.bootstrap.servers'='172.16.100.109:9092',
'connector'='kafka-x',
'scan.parallelism'='1',
'format'='json',
'topic'='fanshu2',
'scan.startup.mode'='latest-offset'
);
CREATE TABLE kafkaResultTable(
id int,
name varchar,
age int
)WITH(
'properties.bootstrap.servers'='172.16.100.109:9092',
'connector'='kafka-x',
'format'='json',
'topic'='fanshu7',
'sink.parallelism'='1'
);
CREATE TABLE oracleSideTable(
ID decimal(38,0) ,
FLOAT_DATA decimal(126,0) ,
DOUBLE_DATA decimal(126,0) ,
NUMBER_1 decimal(1,0) ,
CHAR_255 char,
NVARCHAR2_255 varchar,
VARCHAR_255 varchar,
VARCHAR2_255 varchar,
DATE_DATA timestamp,
TIMESTAMP_DATA timestamp,
PRIMARY KEY(ID) NOT ENFORCED
)WITH(
'password' = '******',
'connector'='oracle-x',
'lookup.cache-type'='LRU',
'schema-name'='SHIXIAO',
'lookup.parallelism'='1',
'vertx.worker-pool-size'='5',
'lookup.cache.ttl'='60000',
'lookup.cache.max-rows'='10000',
'table-name'='FLINKX_CDC_ALL_TYPE_ONE',
'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
'username'='shixiao'
);
INSERT
INTO
kafkaResultTable
select
st.id,
ost.VARCHAR_255 as name,
st.age
from
sourceTable st
left join
oracleSideTable for SYSTEM_TIME as of st.proc_time as ost
on st.id = ost.ID;

CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE inceptorResultTable(
    id int,
    name varchar(255) ,
    type varchar(255) 
 )WITH(
    'security.kerberos.krb5.conf'='./krb5.conf',
    'password' = '******',
    'partition'='pt',
    'connector'='inceptor-x',
    'table-name'='test01',
    'security.kerberos.keytab'='./inceptor.keytab',
    'sink.parallelism'='1',
    'url'='jdbc:hive2://172.16.83.150:10000/tiezhu;principal=hive/tdh02@TDH',
    'username'='admin',
    'security.kerberos.principal'='hive/tdh02@TDH'
 );
-- name kafka2inceptor
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-22 21:17:37
-- desc
INSERT 
INTO
    inceptorResultTable
    select
        id,
        name,
        cast(age as varchar) as type 
    from
        sourceTable;

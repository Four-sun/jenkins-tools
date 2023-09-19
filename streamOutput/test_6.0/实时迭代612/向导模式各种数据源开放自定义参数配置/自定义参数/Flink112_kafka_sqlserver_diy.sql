CREATE TABLE sourceTable(
    id int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE sqlserverResultTable(
    id int,
    varchar_data STRING,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='sqlserver-x',
    'sink.buffer-flush.interval'='2',
    'schema-name'='dbo',
    'sink.all-replace'='true',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='source_112_sqlserver_varchar',
    'sink.parallelism'='2',
    'url'='jdbc:sqlserver://172.16.101.246:1433;database=db_test',
    'username'='sa'
 );
CREATE TABLE mysqlResultTable(
    id bigint,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='10000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='stream_mysql_ogg_one_fanshu001',
    'sink.parallelism'='2',
    'url'='jdbc:mysql://172.16.82.144:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE oracleResultTable(
    ID decimal(38,0) ,
    NAME varchar,
    GRADE decimal(126,0) 
 )WITH(
    'password' = '******',
    'connector'='oracle-x',
    'sink.buffer-flush.interval'='2',
    'schema-name'='SHIXIAO',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='CASE_64090',
    'sink.parallelism'='2',
    'url'='jdbc:oracle:thin:@172.16.100.243:1521:orcl',
    'username'='shixiao'
 );
CREATE TABLE postgresqlResultTable(
    id int,
    name varchar,
    age int,
    address varchar,
    salary float
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='2',
    'schema-name'='public',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='company_0621',
    'sink.parallelism'='2',
    'url'='jdbc:postgresql://172.16.101.246:5432/postgres',
    'username'='dtstack_rep'
 );
CREATE TABLE kingbaseResult(
    id int,
    varchar_data varchar
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='2',
    'schema-name'='PUBLIC',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='kingbaseFanshuOne',
    'sink.parallelism'='2',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
CREATE TABLE esResultTable(
    id int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'sink.bulk-flush.max-actions'='2',
    'hosts'='172.16.100.243:9200',
    'index'='fanshu_test',
    'sink.parallelism'='2'
 );
CREATE TABLE clickhouseResult(
    id int,
    name varchar,
    grade int
 )WITH(
    'connector'='clickhouse-x',
    'sink.buffer-flush.interval'='2',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='CASE_75824_DEST',
    'sink.parallelism'='2',
    'url'='jdbc:clickhouse://172.16.21.76:8123/test',
    'username'='default'
 );
CREATE TABLE impalaResultTable(
    id bigint,
    name varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='impala-x',
    'schema-name'='default',
    'table-name'='a79095_impala',
    'sink.parallelism'='2',
    'url'='jdbc:impala://172.16.100.32:21050/default;AuthMech=0'
 );
CREATE TABLE starrocksResultTable(
    month_code string
 )WITH(
    'password' = '******',
    'connector'='starrocks-x',
    'schema-name'='batch_60',
    'feNodes'='172.16.82.221:8030',
    'sink.buffer-flush.max-rows'='2',
    'table-name'='dim_month',
    'sink.parallelism'='2',
    'url'='jdbc:mysql://172.16.82.221:9030',
    'username'='root'
 );
-- name Flink112_kafka_sqlserver_update
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-08 15:16:03
-- desc 
INSERT  
INTO
    sqlserverResultTable
    select
        id,
        varchar_data    
    from
        sourceTable;

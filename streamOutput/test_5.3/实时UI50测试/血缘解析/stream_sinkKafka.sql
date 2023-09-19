CREATE TABLE sourceTable(
    id int,
    varchar_data varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu3',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR,
    timestamp_data TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='mysql_all_type_test',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultOne(
    id int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
CREATE TABLE source
(
    id        INT,
    name      STRING,
    money     DECIMAL(32, 2),
    dateone   timestamp,
    age       bigint,
    datethree timestamp,
    datesix   timestamp(6),
    datenigth timestamp(9),
    dtdate    date,
    dttime    time
) WITH (
      'connector' = 'stream-x',
      'number-of-rows' = '10', -- 输入条数，默认无限
      'rows-per-second' = '1' -- 每秒输入条数，默认不限制
      );

INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        st.name as varchar_data
    from
        source st

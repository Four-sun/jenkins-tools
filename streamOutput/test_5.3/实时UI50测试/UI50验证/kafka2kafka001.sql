CREATE TABLE MyTable(
    id int,
    content varchar,
    intro varchar,
    isread int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'fanshu'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );


CREATE TABLE source(
    id        INT,
    name      STRING,
    money     DECIMAL(32,2) ,
    dateone   timestamp,
    age       bigint,
    datethree timestamp,
    datesix   timestamp(6) ,
    datenigth timestamp(9) ,
    dtdate    date,
    dttime    time
 )WITH(
    'connector'='stream-x',
    'number-of-rows'='10000',
    'rows-per-second'='1'
 );
CREATE TABLE sink(
    id        INT,
    name      STRING,
    money     DECIMAL(32,2) ,
    dateone   timestamp,
    age       bigint,
    datethree timestamp,
    datesix   timestamp(6) ,
    datenigth timestamp(9) ,
    dtdate    date,
    dttime    time
 )WITH(
    'connector'='stream-x',
    'print'='true'
 );
insert 
into
    sink
    select
        * 
    from
        source;

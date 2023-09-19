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
INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        st.varchar_data
    from
        sourceTable st





CREATE TABLE source_table(
    id int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='test_topic_name_gcwfybte',
    'scan.startup.mode'='earliest-offset'
 );
CREATE TABLE target_table(
    user_id int primary key
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='testuser',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='jiuwei_table',
    'sink.parallelism'='1',
    'url'='jdbc:postgresql://172.16.84.251/postgres',
    'username'='testuser'
 );
CREATE TABLE side_table(
    user_id int,
    PRIMARY KEY(user_id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='postgresql-x',
    'lookup.cache-type'='LRU',
    'schema-name'='testuser',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='account',
    'url'='jdbc:postgresql://172.16.84.251/postgres',
    'username'='testuser'
 );
insert  
into
    target_table
    select
        st.id as user_id      
    from
        source_table as st      
    left join
        side_table  as sd           
            on st.id = sd.user_id;

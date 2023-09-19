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
CREATE TABLE kingbaseSideTable(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'lookup.cache-type'='LRU',
    'schema-name'='PUBLIC',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='kingbase8_basic_input_test',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
CREATE TABLE kingbaseResultTableOne(
    id int,
    name varchar,
    age int,
    start_time timestamp
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='PUBLIC',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='kingbase8_basic_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
CREATE TABLE kingbaseResultTableTwo(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='PUBLIC',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='kingbase8_basic_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
CREATE TABLE kingbaseResultTableThree(
    id int,
    name varchar,
    age int,
    start_time timestamp,
    PRIMARY KEY(id,name) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='kingbase-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='PUBLIC',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='kingbase8_basic_output_test',
    'sink.parallelism'='1',
    'url'='jdbc:kingbase8://172.16.83.182:54321/TEST',
    'username'='SYSTEM'
 );
-- desc FlinkSQL112_sourceKafka_sideKingbaseES8_sinkKingbaseES8
INSERT  
INTO
    kingbaseResultTableOne
    select
        st.id,
        mst.name as name,
        mst.age as age ,
        mst.start_time as start_time     
    from
        sourceTable st     
    left join
        kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
INSERT  
INTO
    kingbaseResultTableTwo
    select
        st.id,
        mst.name as name,
        mst.age as age ,
        mst.start_time as start_time     
    from
        sourceTable st     
    left join
        kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;
INSERT  
INTO
    kingbaseResultTableThree
    select
        st.id,
        mst.name as name,
        mst.age as age ,
        mst.start_time as start_time     
    from
        fanshu.fanshuDatabase.sourceTable st     
    left join
        kingbaseSideTable for SYSTEM_TIME as of st.proc_time as mst              
            on st.id = mst.id;

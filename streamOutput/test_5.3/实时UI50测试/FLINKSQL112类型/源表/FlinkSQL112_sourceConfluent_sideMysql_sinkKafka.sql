CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.83.180:9092',
    'avro-confluent.schema-registry.url'='http://172.16.83.180:8081',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='avro-confluent',
    'topic'='wc_test',
    'avro-confluent.schema-registry.subject'='wc_test-value',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id INT,
    name VARCHAR,
    channel VARCHAR,
    time_info VARCHAR,
    flag VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='threedimjoin_sidetabletwo',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='csv',
    'key.format'='json',
    'topic'='fanshu3',
    'sink.parallelism'='1',
    'key.fields'='id',
    'sink.partitioner'='com.dtstack.chunjun.connector.kafka.partitioner.CustomerFlinkPartition'
 );
-- desc FlinkSQL112_sourceConfluent_sideMysql_sinkKafka
INSERT 
INTO
    kafkaResultTable
    select
        st.id,
        mst.name,
        st.id as age 
    from
        sourceTable st
    left join
        mysqlSideTable for SYSTEM_TIME as of st.proc_time as mst 
            on st.id = mst.id;


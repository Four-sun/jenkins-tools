CREATE TABLE sourceTable(
    id int,
    name varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'consumer.group'='STREAM_APP_ROCKET_MQ',
    'time.zone'='Asia/Shanghai',
    'connector'='rocketmq-x',
    'nameserver.address'='172.16.83.182:9876',
    'consumer.start-offset-mode'='latest',
    'topic'='TieZhu',
    'tag'='*',
    'encoding'='utf-8'
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
-- desc FlinkSQL112_sourceRocket_sideMysql_sinkKafka
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


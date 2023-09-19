CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu0001',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='avro',
    'value.fields-include'='ALL',
    'key.format'='avro',
    'topic'='flink_1123',
    'sink.parallelism'='1'
 );
-- name FlinkSQL112_sourceKafka_sideMysql_sinkMysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-17 11:04:01
-- desc FlinkSQL112_sourceKafka_sideMysql_sinkMysql
INSERT 
INTO
    kafkaResultOne
    select
        st.id,
        st.name,
        st.age
    from
        sourceTable st



CREATE TABLE kafkaResultTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.83.204:21013,172.16.83.229:21013,172.16.83.234:21013',
    'properties.sasl.jaas.config'='com.sun.security.auth.module.Krb5LoginModule required
useKeyTab=true
storeKey=true
refreshKrb5Config=true
keyTab="huawei_kafka_1223.keytab"useTicketCache=false
principal="hive/hadoop.hadoop.com@HADOOP.COM";',
    'connector'='kafka-HW-x',
    'properties.sasl.mechanism'='GSSAPI',
    'format'='json',
    'topic'='wangchuan_41',
    'properties.security.protocol'='SASL_PLAINTEXT',
    'sink.parallelism'='1',
    'properties.sasl.kerberos.service.name'='kafka'
 );
-- name stream_hwkafka
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-01 10:30:56
-- desc
CREATE TABLE source(
    id int,
    name varchar,
    age int
 )WITH(
    'connector'='stream-x',
    'number-of-rows'='1000'
 );
INSERT 
INTO
    kafkaResultTable
    select
        id,
        name,
        age 
    from
        source;

CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi',
    'scan.startup.mode'='latest-offset'
 );

CREATE TABLE hiveResultTableOne(
    id int,
    name string
 )WITH(
    'file-type'='text',
    'field-delimiter'='\u0001',
    'properties.dfs.namenode.rpc-address.ns1.nn1'='172.16.20.255:9000',
    'properties.dfs.namenode.rpc-address.ns1.nn2'='172.16.21.253:9000',
    'default-fs'='hdfs://ns1',
    'url'='jdbc:hive2://172.16.20.255:10004/default',
    'properties.dfs.client.failover.proxy.provider.ns1'='org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider',
    'partition'='pt',
    'connector'='hive-x',
    'table-name'='test_result_table_name_dotysfub',
    'sink.parallelism'='1',
    'partition-type'='DAY',
    'properties.dfs.ha.namenodes.ns1'='nn1,nn2',
    'username'='admin',
    'properties.dfs.nameservices'='ns1'
 );
-- name FlinkSQL116_sourceKafka_sinkhive2_bak
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-25 14:12:27
-- desc 
INSERT  
INTO
    hiveResultTableOne
    select
        st.id,
        st.name  
    from
        sourceTable st;




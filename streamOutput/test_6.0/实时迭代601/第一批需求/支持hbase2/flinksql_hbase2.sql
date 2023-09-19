


-- name flinksql_hbase2
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-02-21 20:20:24
-- desc 
CREATE TABLE sourceTable(
    id int,
    varchar_data varchar,
    int_data int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE hbaseResultTable(
    id int,
    info ROW<int_data int,
    varchar_data varchar>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='hbase2-x',
    'zookeeper.quorum'='172.16.101.95,172.16.100.32,172.16.101.137:2181',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='fanshu_test_1',
    'zookeeper.znode.parent'='/hbase',
    'sink.parallelism'='1'
 );
insert   
into
    hbaseResultTable
    SELECT
        id,
        ROW(int_data,
        varchar_data) as info          
    from
        sourceTable;

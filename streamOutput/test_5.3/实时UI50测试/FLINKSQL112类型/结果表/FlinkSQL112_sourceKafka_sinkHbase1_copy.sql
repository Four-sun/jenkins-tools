[{"sourceId":"219","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"537","columnsText":"cf ROW<id int, name varchar, age int>","columns":[{"column":"cf ROW<id int, name varchar, age int>"}],"parallelism":1,"createType":0,"type":8,"batchWaitInterval":1000,"tableName":"hbaseResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","rowKeyType":"int","sourceName":"hbase1x_auto_test","batchSize":100,"table":"test_source_table_amtgofzc","rowKey":"id"}]
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
CREATE TABLE hbaseResultTable(
    id int,
    cf ROW<id int,
    name varchar,
    age int>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='hbase14-x',
    'zookeeper.quorum'='172.16.83.84:2181,172.16.83.101:2181,172.16.83.201:2181',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='test_source_table_amtgofzc',
    'sink.parallelism'='1'
 );
INSERT  
INTO
    hbaseResultTable
    SELECT
        st.id as rowkey,
        ROW(id,
        name,
        age) as cf          
    FROM
        sourceTable st;

[{"sourceId":"219","columnsText":"id int\nname varchar\nvarchar_data varchar\ntinyint_data tinyint\nfloat_data float\ndouble_data double\ndate_data date\ntime_data time\ntimestamp_data timestamp","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"varchar_data","type":"varchar"},{"column":"tinyint_data","type":"tinyint"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"date_data","type":"date"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"555","columnsText":"id int\nname varchar\nvarchar_data varchar\ntinyint_data tinyint\nfloat_data float\ndouble_data double\ndate_data date\ntime_data time\ntimestamp_data timestamp","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"varchar_data","type":"varchar"},{"column":"tinyint_data","type":"tinyint"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"date_data","type":"date"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"}],"parallelism":1,"createType":0,"collection":"auto_test","type":53,"batchWaitInterval":1000,"tableName":"solrResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"solr7x","batchSize":100},{"sourceId":"945","columnsText":" id int\n name varchar\n age int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultOne","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu2","partitionKeys":["id"],"sourceName":"kafka_2x_237","enableKeyPartitions":true}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    varchar_data varchar,
    tinyint_data tinyint,
    float_data float,
    double_data double,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE solrResultTable(
    id int,
    name varchar,
    varchar_data varchar,
    tinyint_data tinyint,
    float_data float,
    double_data double,
    date_data date,
    time_data time,
    timestamp_data timestamp
 )WITH(
    'zk-chroot'='/solr',
    'connector'='solr-x',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'collection'='auto_test',
    'sink.parallelism'='1',
    'zk-hosts'='172.16.101.95:2181,172.16.100.32:2181,172.16.101.137:2181'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'format'='json',
    'key.format'='json',
    'topic'='fanshu2',
    'sink.parallelism'='1',
    'key.fields'='id',
    'sink.partitioner'='com.dtstack.chunjun.connector.kafka.partitioner.CustomerFlinkPartition'
 );
INSERT   
INTO
    solrResultTable
    SELECT
        st.id,
        st.name,
        st.varchar_data,
        st.tinyint_data,
        st.float_data,
        st.double_data,
        st.date_data,
        st.time_data,
        st.timestamp_data       
    FROM
        sourceTable st;

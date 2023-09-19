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


-- desc FlinkSQL112_sourceKafka_sinkSolr
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

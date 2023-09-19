[{"sourceId":"219","columnsText":"id int\nname varchar\ntimestamp_data timestamp(6)\ntinyint_data int\ndecimal_data decimal\ndouble_data double\nvarchar_data varchar","charset":"utf-8","_panelKey":"1673354422730345321","sourceDataType":1,"timeTypeArr":[1],"offset":0,"customParams":[],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"timestamp_data","type":"timestamp(6)"},{"column":"tinyint_data","type":"int"},{"column":"decimal_data","type":"decimal"},{"column":"double_data","type":"double"},{"column":"varchar_data","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"173","schema":"test","columns":[{"column":"id","type":"INT"},{"column":"name","type":"VARCHAR(100)"},{"column":"idcard","type":"VARCHAR(100)"},{"column":"birthday","type":"TIMESTAMP(6)"},{"column":"mobile","type":"VARCHAR(100)"},{"column":"email","type":"VARCHAR(100)"},{"column":"gender","type":"INT"},{"column":"create_time","type":"TIMESTAMP(6)"},{"column":"type_smallint","type":"INT"},{"column":"type_mediumint","type":"INT"},{"column":"type_bigint","type":"INT"},{"column":"type_decimal","type":"DECIMAL(10,2)"},{"column":"type_float","type":"FLOAT"},{"column":"type_double","type":"DOUBLE"},{"column":"type_text","type":"VARCHAR(65533)"}],"parallelism":1,"createType":0,"type":64,"batchWaitInterval":1000,"tableName":"dorisResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sourceName":"doris_auto_test","batchSize":100,"table":"stream_doris_result_table","primaryKey":[]}]
CREATE TABLE sourceTable(
    id int,
    name varchar,
    timestamp_data timestamp(6) ,
    tinyint_data int,
    decimal_data decimal,
    double_data double,
    varchar_data varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE dorisResultTable(
    id INT,
    name VARCHAR(100) ,
    idcard VARCHAR(100) ,
    birthday TIMESTAMP(6) ,
    mobile VARCHAR(100) ,
    email VARCHAR(100) ,
    gender INT,
    create_time TIMESTAMP(6) ,
    type_smallint INT,
    type_mediumint INT,
    type_bigint INT,
    type_decimal DECIMAL(10,2) ,
    type_float FLOAT,
    type_double DOUBLE,
    type_text VARCHAR(65533) 
 )WITH(
    'connector'='doris-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='test',
    'feNodes'='172.16.83.193:8030',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_doris_result_table',
    'sink.parallelism'='1',
    'username'='root'
 );
INSERT  
INTO
    dorisResultTable
    SELECT
        st.id,
        st.name,
        st.name as idcard,
        st.timestamp_data as birthday,
        st.name as mobile,
        st.name as email,
        st.tinyint_data as gender,
        st.timestamp_data as create_time,
        st.tinyint_data  as type_smallint,
        st.tinyint_data  as type_mediumint,
        st.tinyint_data  as type_bigint,
        st.decimal_data as type_decimal,
        1.1 as type_float,
        st.double_data as type_double,
        st.varchar_data as type_text     
    FROM
        sourceTable st;

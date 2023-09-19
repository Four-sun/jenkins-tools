[{"sourceId":"625","columnsText":"id int\ntinyint_data tinyint\nint_data int\nbigint_data bigint\ndecimal_data decimal\nfloat_data float\ndouble_data double\nvarchar_data varchar\ndate_data date\ntime_data time\ntimestamp_data timestamp\nname varchar\nage int","charset":"utf-8","_panelKey":"1678417719379708248","sourceDataType":4,"timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"int_data","type":"int"},{"column":"bigint_data","type":"bigint"},{"column":"decimal_data","type":"decimal"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"varchar_data","type":"varchar"},{"column":"date_data","type":"date"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"625","columnsText":"id int\ntinyint_data tinyint\nint_data int\nbigint_data bigint\ndecimal_data decimal\nfloat_data float\ndouble_data double\nvarchar_data varchar\ndate_data date\ntime_data time\ntimestamp_data timestamp\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"int_data","type":"int"},{"column":"bigint_data","type":"bigint"},{"column":"decimal_data","type":"decimal"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"varchar_data","type":"varchar"},{"column":"date_data","type":"date"},{"column":"time_data","type":"time"},{"column":"timestamp_data","type":"timestamp"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTable","bulkFlushMaxActions":100,"updateMode":"upsert","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu7","sourceName":"kafka2x_auto_test","primaryKey":["id"]}]
CREATE TABLE sourceTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    float_data float,
    double_data double,
    varchar_data varchar,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='ogg-json-x',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultTable(
    id int,
    tinyint_data tinyint,
    int_data int,
    bigint_data bigint,
    decimal_data decimal,
    float_data float,
    double_data double,
    varchar_data varchar,
    date_data date,
    time_data time,
    timestamp_data timestamp,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='upsert-kafka-x',
    'value.format'='json',
    'value.fields-include'='ALL',
    'key.format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
INSERT   
INTO
    kafkaResultTable
    select
        id,
        tinyint_data,
        int_data,
        bigint_data,
        decimal_data,
        float_data,
        double_data,
        varchar_data,
        date_data,
        time_data,
        timestamp_data,
        name,
        age          
    FROM
        sourceTable;

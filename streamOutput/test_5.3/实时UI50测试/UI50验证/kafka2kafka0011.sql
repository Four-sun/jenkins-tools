[{"sourceId":"219","columnsText":"id int\ncontent varchar\nintro varchar\nisread int","charset":"utf-8","_panelKey":"1673341187417945124","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"content","type":"varchar"},{"column":"intro","type":"varchar"},{"column":"isread","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"procTime":"proc_time","offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"MyTable"}]
[]
[]
ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/27_blink-udx-3_blink-udx-3.x-1.0-SNAPSHOT.jar;
CREATE AGGREGATE FUNCTION count_udaf WITH com.alibaba.blink.udx.CountUdaf;
ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/27_blink-udx-3_blink-udx-3.x-1.0-SNAPSHOT.jar;
CREATE TABLE FUNCTION split_udtf WITH com.alibaba.blink.udx.SplitUdtf;
ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/27_blink-udx-3_blink-udx-3.x-1.0-SNAPSHOT.jar;
CREATE SCALAR FUNCTION strlen_udf WITH com.alibaba.blink.udx.StringLengthUdf;
CREATE TABLE MyTable(
    id int,
    content varchar,
    intro varchar,
    isread int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu4',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    content VARCHAR,
    content_a VARCHAR,
    intro_length BIGINT
 )WITH(
    'connector'='stream-x',
    'print'='true'
 );
CREATE TABLE MyResultUdaf(
    cnt_udaf BIGINT
 )WITH(
    'connector'='stream-x',
    'print'='true'
 );
INSERT           
INTO
    MyResult
    select
        S.id,
        S.content as content,
        T.a as content_a,
        strlen_udf(S.intro) as intro_length                  
    from
        MyTable as S,
        lateral table(split_udtf(content)) as T(a);
INSERT           
INTO
    MyResultUdaf
    select
        CAST(count_udaf(CAST(S.id as BIGINT) ) as BIGINT) as cnt_udaf                    
    from
        MyTable as S;

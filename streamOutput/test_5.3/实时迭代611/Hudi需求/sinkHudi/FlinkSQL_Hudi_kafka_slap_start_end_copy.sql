[{"sourceId":"915","schema":"default","charset":"utf-8","_panelKey":"1688969841250340222","batchEndCommit":"20230711112833240","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":68,"offsetReset":"latest","tableType":1,"streamingStartOffset":"latest","offsetUnit":"SECOND","batchStartCommit":"20230711112833240","timeInterval":5,"sourceName":"hivemetasotre_flink03_hudi","table":"cow_cdc_fanshu","readMode":false}]
[]
[{"sourceId":"917","columnsText":"uuid varchar\nname varchar\nage int","columns":[{"column":"uuid","type":"varchar"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResult","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu7","sourceName":"kafka2x_auto_test"}]
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/core-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/hdfs-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/yarn-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
CREATE TABLE cow_cdc_fanshu(
    uuid string,
    name string,
    age int,
    ts bigint
 )WITH(
    -- 'pk.constraint.name'='PK_3601370',
    -- 'transient_lastDdlTime'='1689043988',
    'hoodie.datasource.write.recordkey.field'='uuid',
    'hoodie.datasource.query.type'='incremental',
    'path'='/tmp/liuliu/hudi_test/cow_cdc_fanshu',
    'connector'='hudi',
    -- 'last_commit_time_sync'='20230711110307953',
    -- 'comment'='',
    'table.type'='COPY_ON_WRITE',
    -- 'read.streaming.enabled'='false',
    'read.start-commit'='20230711110020693',
    'read.end-commit'='20230711110307953'
    -- 'read.streaming.check-interval'='5'
 );
CREATE TABLE kafkaResult(
    uuid varchar,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
INSERT  
INTO
    kafkaResult
    select
        uuid,
        name,
        age     
    from
        cow_cdc_fanshu;

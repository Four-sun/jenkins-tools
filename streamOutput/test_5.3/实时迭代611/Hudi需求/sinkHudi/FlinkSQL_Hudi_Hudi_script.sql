[{"sourceId":"915","schema":"default","charset":"utf-8","_panelKey":"1688969841250340222","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":68,"offsetReset":"latest","tableType":1,"streamingStartOffset":"earliest","offsetUnit":"SECOND","timeInterval":5,"sourceName":"hivemetasotre_flink03_hudi","table":"cow_cdc_fanshu","readMode":true}]
[]
[{"sourceId":"919","schema":"default","bulkFlushMaxActions":100,"updateMode":"insert","allReplace":"false","columns":[],"parallelism":1,"createType":0,"sourceName":"hive_flink003","type":68,"table":"cow_cdc_fanshu_5"}]
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/core-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/hdfs-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1881/yarn-site.xml FOR default_catalog.default_database.cow_cdc_fanshu as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1887/core-site.xml FOR default_catalog.default_database.cow_cdc_fanshu_5 as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1887/hdfs-site.xml FOR default_catalog.default_database.cow_cdc_fanshu_5 as hadoop.conf.dir;
ADD CONFIG FILE WITH /home/admin/sftp/dttestuic_com/ssl_DsCenter_1887/yarn-site.xml FOR default_catalog.default_database.cow_cdc_fanshu_5 as hadoop.conf.dir;
CREATE TABLE cow_cdc_fanshu(
    uuid string,
    name string,
    age int,
    ts TIMESTAMP(3)
 )WITH(
    'pk.constraint.name'='PK_3601370',
    'transient_lastDdlTime'='1689043988',
    'hoodie.datasource.write.recordkey.field'='uuid',
    'path'='/tmp/liuliu/hudi_test/cow_cdc_fanshu',
    'connector'='hudi',
    'last_commit_time_sync'='20230711110307953',
    'comment'='',
    'table.type'='COPY_ON_WRITE',
    'read.streaming.enabled'='true',
    'read.start-commit'='earliest',
    'read.streaming.check-interval'='5'
 );
CREATE TABLE cow_cdc_fanshu_5(
    uuid string,
    name string,
    age int,
    ts TIMESTAMP(3)
 )WITH(
    'pk.constraint.name'='PK_3601370',
    'transient_lastDdlTime'='1689045408',
    'hoodie.datasource.write.recordkey.field'='uuid',
    'path'='/tmp/liuliu/hudi_test/cow_cdc_fanshu_5',
    'connector'='hudi',
    'comment'='',
    'table.type'='COPY_ON_WRITE',
    'write.operation'='insert'
 );
INSERT  
INTO
    cow_cdc_fanshu_5
    select
        uuid,
        name,
        age,
        ts     
    from
        cow_cdc_fanshu;

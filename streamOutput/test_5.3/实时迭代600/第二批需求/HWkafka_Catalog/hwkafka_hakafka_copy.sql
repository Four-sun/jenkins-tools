[{"sourceId":"575","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1675220594036751773","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"customParams":[{"auto":true,"value":"com.sun.security.auth.module.Krb5LoginModule required\nuseKeyTab=true\nstoreKey=true\nrefreshKrb5Config=true\nkeyTab=\"huawei_kafka_1223.keytab\"\nuseTicketCache=false\nprincipal=\"hive/hadoop.hadoop.com@HADOOP.COM\";","key":"properties.sasl.jaas.config"},{"auto":true,"value":"GSSAPI","key":"properties.sasl.mechanism"},{"auto":true,"value":"SASL_PLAINTEXT","key":"properties.security.protocol"},{"auto":true,"value":"kafka","key":"properties.sasl.kerberos.service.name"}],"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":70,"offsetReset":"latest","offsetUnit":"SECOND","topic":"wangchuan_41","sourceName":"qianyiKafka","table":"sourceTable"}]
[]
[{"sourceId":"475","columnsText":"id int\nname varchar\nage int","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"createType":0,"type":37,"tableName":"kafkaResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","sinkDataType":"dt_nest","topic":"fanshu7","sourceName":"kafka2x_auto_test"}]
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1223/hive.keytab RENAME huawei_kafka_1223.keytab;
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1223/krb5.conf;
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.83.204:21013,172.16.83.229:21013,172.16.83.234:21013',
    'properties.sasl.jaas.config'='com.sun.security.auth.module.Krb5LoginModule required useKeyTab=true storeKey=true refreshKrb5Config=true keyTab="huawei_kafka_1223.keytab"useTicketCache=false principal="hive/hadoop.hadoop.com@HADOOP.COM";',
    'connector'='kafka-HW-x',
    'scan.parallelism'='1',
    'properties.sasl.mechanism'='GSSAPI',
    'format'='json',
    'topic'='wangchuan_41',
    'properties.security.protocol'='SASL_PLAINTEXT',
    'scan.startup.mode'='latest-offset',
    'properties.sasl.kerberos.service.name'='kafka'
 );
CREATE TABLE kafkaResultTable(
    id int,
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
    kafkaResultTable
    select
        id,
        name,
        age      
    from
        sourceTable;

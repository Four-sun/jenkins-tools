[{"sourceId":"337","columnsText":"id int\nname varchar\nage int","charset":"utf-8","_panelKey":"1671715092269656003","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"},{"column":"age","type":"int"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTable"}]
[]
[{"sourceId":"383","columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar(255)"},{"column":"type","type":"varchar(255)"}],"parallelism":1,"createType":0,"type":52,"batchWaitInterval":1000,"tableName":"inceptorResultTable","bulkFlushMaxActions":100,"updateMode":"append","allReplace":"false","partitionfields":"pt","sourceName":"inceptor_stream_test","batchSize":100,"isShowPartition":true,"table":"test01"}]
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_977/216_inceptor.keytab;
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_977/216_krb5.conf;
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE inceptorResultTable(
    id int,
    name varchar(255) ,
    type varchar(255) 
 )WITH(
    'security.kerberos.krb5.conf'='./216_krb5.conf',
    'password' = '******',
    'partition'='pt',
    'connector'='inceptor-x',
    'table-name'='test01',
    'security.kerberos.keytab'='./216_inceptor.keytab',
    'sink.parallelism'='1',
    'url'='jdbc:hive2://172.16.83.150:10000/tiezhu;principal=hive/tdh02@TDH',
    'username'='admin',
    'security.kerberos.principal'='hive/tdh02@TDH'
 );
INSERT  
INTO
    inceptorResultTable
    select
        id,
        name,
        cast(age as varchar) as type      
    from
        sourceTable;

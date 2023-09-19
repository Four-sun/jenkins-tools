[{"sourceId":"817","columnsText":"id int\nname varchar","charset":"utf-8","_panelKey":"167996786585894579","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"name","type":"varchar"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTableOne"}]
[]
[{"sourceId":"859","columnsText":"cf ROW<id int, name varchar>","customParams":[{"id":"1679990928752599806","value":"10b","key":"sink.buffer-flush.max-size"}],"columns":[{"column":"cf ROW<id int, name varchar>"}],"parallelism":1,"createType":0,"type":103,"batchWaitInterval":1000,"tableName":"resultTableOne","bulkFlushMaxActions":100,"rowKeyType":"int","updateMode":"upsert","allReplace":"false","sourceName":"hyperbase","batchSize":100,"table":"stream_test_one","rowKey":"id"}]
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/inceptor.keytab;
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/krb5.conf;
CREATE TABLE sourceTableOne(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE resultTableOne(
    id int,
    cf ROW<id int,
    name varchar>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.jaasSectionName'='Client',
    'properties.java.security.krb5.conf'='krb5.conf',
    'properties.useLocalFile'='true',
    'properties.hbase.security.authorization'='true',
    'security.kerberos.krb5conf'='krb5.conf',
    'properties.hbase.regionserver.kerberos.principal'='hbase/_HOST@TDH',
    'properties.hbase.security.java.security.krb5.conf'='krb5.conf',
    'properties.hbase.master.kerberos.principal'='hbase/_HOST@TDH',
    'security.kerberos.keytab'='inceptor.keytab',
    'sink.parallelism'='1',
    'properties.principalFile'='inceptor.keytab',
    'properties.hbase.security.auth.enable'='true',
    'properties.hbase.security.principal'='hive/tdh-node02@TDH',
    'zookeeper.quorum'='tdh-node02,tdh-node03,tdh-node01',
    'sink.buffer-flush.interval'='1000',
    'sink.buffer-flush.max-rows'='100',
    'zookeeper.znode.parent'='/hyperbase1',
    'security.kerberos.principal'='hive/tdh-node02@TDH',
    'sink.buffer-flush.max-size'='10b',
    'properties.hbase.security.authentication'='kerberos',
    'properties.principal'='hive/tdh-node02@TDH',
    'connector'='hyperbase-x',
    'properties.hbase.security.principalFile'='inceptor.keytab',
    'table-name'='stream_test_one',
    'properties.isAddSecurityModule'='true'
 );
insert   
into
    resultTableOne
    SELECT
        st.id as rowkey,
        ROW(id,
        name) as cf           
    from
        sourceTableOne st;

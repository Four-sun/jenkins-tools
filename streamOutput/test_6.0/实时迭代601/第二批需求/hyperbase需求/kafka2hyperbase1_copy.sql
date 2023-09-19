[{"sourceId":"129","columnsText":"id int\ntinyint_data tinyint\nbigint_data bigint\nfloat_data float\ndouble_data double\ndecimal_data decimal\nvarchar_data varchar\ntimestamp_data timestamp(3) \ndate_data date","charset":"utf-8","_panelKey":"1681387655370184288","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"bigint_data","type":"bigint"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"decimal_data","type":"decimal"},{"column":"varchar_data","type":"varchar"},{"column":"timestamp_data","type":"timestamp(3)"},{"column":"date_data","type":"date"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2_auto","table":"sourceTableOne"}]
[]
[{"sourceId":"225","columnsText":"cf row<id int, tinyint_data tinyint, bigint_data bigint, float_data float, double_data double, decimal_data decimal, varchar_data varchar, timestamp_data timestamp(3), date_data date>","columns":[{"column":"cf row<id int, tinyint_data tinyint, bigint_data bigint, float_data float, double_data double, decimal_data decimal, varchar_data varchar, timestamp_data timestamp(3), date_data date>"}],"parallelism":1,"createType":0,"type":103,"batchWaitInterval":1000,"tableName":"hyperbaseResultTable","bulkFlushMaxActions":100,"rowKeyType":"int","updateMode":"upsert","allReplace":"false","sourceName":"hyperbase_1","batchSize":100,"table":"stream_test_two","rowKey":"id"}]
ADD FILE WITH /home/admin/sftp/stream_6x/DSCENTER_HYPER_BASE_107/inceptor.keytab;
ADD FILE WITH /home/admin/sftp/stream_6x/DSCENTER_HYPER_BASE_107/krb5.conf;
CREATE TABLE sourceTableOne(
    id int,
    tinyint_data tinyint,
    bigint_data bigint,
    float_data float,
    double_data double,
    decimal_data decimal,
    varchar_data varchar,
    timestamp_data timestamp(3) ,
    date_data date
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE hyperbaseResultTable(
    id int,
    cf row<id int,
    tinyint_data tinyint,
    bigint_data bigint,
    float_data float,
    double_data double,
    decimal_data decimal,
    varchar_data varchar,
    timestamp_data timestamp(3) ,
    date_data date>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'properties.hbase.security.auth.enable'='true',
    'properties.hbase.security.principal'='hive/tdh-node02@TDH',
    'zookeeper.quorum'='tdh-node02,tdh-node03,tdh-node01',
    'sink.buffer-flush.interval'='1000',
    'properties.hbase.config.read.zookeeper.config' = 'false',
    'sink.buffer-flush.max-rows'='100',
    'zookeeper.znode.parent'='/hyperbase1',
    'properties.jaasSectionName'='Client',
    'properties.java.security.krb5.conf'='krb5.conf',
    'properties.useLocalFile'='true',
    'properties.hbase.security.authorization'='true',
    'security.kerberos.principal'='hive/tdh-node02@TDH',
    'security.kerberos.krb5conf'='krb5.conf',
    'properties.hbase.security.authentication'='kerberos',
    'properties.principal'='hive/tdh-node02@TDH',
    'connector'='hyperbase-x',
    'properties.hbase.regionserver.kerberos.principal'='hbase/_HOST@TDH',
    'properties.hbase.security.principalFile'='inceptor.keytab',
    'properties.hbase.security.java.security.krb5.conf'='krb5.conf',
    'table-name'='stream_test_two',
    'properties.hbase.master.kerberos.principal'='hbase/_HOST@TDH',
    'security.kerberos.keytab'='inceptor.keytab',
    'properties.isAddSecurityModule'='true',
    'sink.parallelism'='1',
    'properties.principalFile'='inceptor.keytab'
 );
insert      
into
    hyperbaseResultTable
    SELECT
        st.id as rowkey,
        ROW(id,
        tinyint_data,
        bigint_data,
        float_data,
        double_data,
        decimal_data,
        varchar_data,
        timestamp_data,
        date_data) as cf                          
    from
        sourceTableOne st;

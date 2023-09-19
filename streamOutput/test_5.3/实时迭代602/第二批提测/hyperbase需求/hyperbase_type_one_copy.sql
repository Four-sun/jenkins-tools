[{"sourceId":"817","columnsText":"id int\ntinyint_data tinyint\nbigint_data bigint\nfloat_data float\ndouble_data double\ndecimal_data decimal\nvarchar_data varchar\ntimestamp_data timestamp(3)\ndate_data date","charset":"utf-8","_panelKey":"167996786585894579","sourceDataType":"dt_nest","timeTypeArr":[1],"offset":0,"columns":[{"column":"id","type":"int"},{"column":"tinyint_data","type":"tinyint"},{"column":"bigint_data","type":"bigint"},{"column":"float_data","type":"float"},{"column":"double_data","type":"double"},{"column":"decimal_data","type":"decimal"},{"column":"varchar_data","type":"varchar"},{"column":"timestamp_data","type":"timestamp(3)"},{"column":"date_data","type":"date"}],"parallelism":1,"timeType":1,"timeZone":"Asia/Shanghai","createType":0,"type":37,"offsetReset":"latest","offsetUnit":"SECOND","topic":"fanshu2","sourceName":"kafka2x_auto_test","table":"sourceTableOne"}]
[]
[{"sourceId":"859","columnsText":"cf row<id int, tinyint_data tinyint, bigint_data bigint, float_data float, double_data double, decimal_data decimal, varchar_data varchar, timestamp_data timestamp(3), date_data date>","customParams":[{"id":"1679990928752599806","value":"10b","key":"sink.buffer-flush.max-size"}],"columns":[{"column":"cf row<id int, tinyint_data tinyint, bigint_data bigint, float_data float, double_data double, decimal_data decimal, varchar_data varchar, timestamp_data timestamp(3), date_data date>"}],"parallelism":1,"createType":0,"type":103,"batchWaitInterval":1000,"tableName":"hyperbaseResultTable","bulkFlushMaxActions":100,"rowKeyType":"int","updateMode":"upsert","allReplace":"false","sourceName":"hyperbase","batchSize":100,"table":"stream_test_two","rowKey":"id"}]
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/inceptor.keytab;
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/krb5.conf;
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
    'table-name'='stream_test_two',
    'properties.isAddSecurityModule'='true'
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

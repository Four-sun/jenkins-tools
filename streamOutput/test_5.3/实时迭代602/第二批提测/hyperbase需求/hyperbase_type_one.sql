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
    'properties.hbase.config.read.zookeeper.config'='false',
    'security.kerberos.principal'='hive/tdh-node02@TDH',
    'sink.buffer-flush.max-size'='10b',
    'properties.hbase.security.authentication'='kerberos',
    'properties.principal'='hive/tdh-node02@TDH',
    'connector'='hyperbase-x',
    'properties.hbase.security.principalFile'='inceptor.keytab',
    'table-name'='stream_test_two',
    'properties.isAddSecurityModule'='true'
 );
-- name hyperbase_test_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-27 17:51:52
-- desc
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

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
-- name hyperbase_test_1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-28 16:54:55
-- desc 
insert  
into
    resultTableOne
    SELECT
        st.id as rowkey,
        ROW(id,
        name) as cf      
    from
        sourceTableOne st;


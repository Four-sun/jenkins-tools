


ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/inceptor.keytab;
ADD FILE WITH /home/admin/sftp/dttestuic_com/DsCenter_1671/krb5.conf;
CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu7',
    'sink.parallelism'='1'
 );
CREATE TABLE hyperbaseSideTable(
    id int,
    cf row<id int,
    name varchar>,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
      'connector' = 'hyperbase-x'
      ,'zookeeper.quorum' = 'tdh-node01,tdh-node02,tdh-node03'
      ,'properties.hbase.zookeeper.property.clientPort' = '2181'
      ,'zookeeper.znode.parent' = '/hyperbase1'
      ,'null-string-literal' = 'null'
      ,'table-name' = 'liuliu:test_001'
      ,'properties.hbase.security.authentication' = 'kerberos'
      ,'properties.hbase.master.kerberos.principal' = 'hbase/_HOST@TDH'
      ,'properties.hbase.regionserver.kerberos.principal' = 'hbase/_HOST@TDH'
      ,'properties.useLocalFile' = 'true'
      ,'properties.principalFile' = 'inceptor.keytab'
      ,'properties.principal' = 'hive/tdh-node02@TDH'
      ,'properties.java.security.krb5.conf' = 'krb5.conf'
      ,'properties.isAddSecurityModule' = 'true'
      ,'properties.jaasSectionName' = 'Client'
      ,'lookup.cache-type' = 'lru'
 );
INSERT   
INTO
    kafkaResultOne
    SELECT
        st.id as id,
        b.cf.name as name           
    FROM
        sourceTableOne st                    
    LEFT JOIN
        hyperbaseSideTable FOR SYSTEM_TIME AS OF st.proc_time AS b                           
            ON st.id = b.id;

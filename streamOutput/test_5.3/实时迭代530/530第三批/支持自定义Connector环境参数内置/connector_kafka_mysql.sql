


-- name connector_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-11-03 18:08:31
-- desc 
-- name connector_kafka_mysql
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-28 11:29:41
-- desc
-- ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/0_flink-connector-jdbc_2_flink-connector-jdbc_2.12-1.12.7.jar;
ADD JAR WITH /home/admin/sftp/dttestuic_com/stream/resource/0_mysql-connector-java-5_mysql-connector-java-5.1.46.jar;
CREATE TABLE sourceTable(
    id int,
    int_data int,
    varchar_data varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE SinkTable(
    id INT,
    int_data INT,
    varchar_data VARCHAR
 )WITH(
    'connector'='jdbc',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco',
    'password' = '******',
    'table-name'='flink_catalog_one'
 );
insert 
into
    SinkTable
    select
        * 
    from
        sourceTable;

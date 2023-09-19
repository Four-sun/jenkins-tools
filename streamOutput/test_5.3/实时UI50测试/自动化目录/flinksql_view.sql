CREATE TABLE sourceTableOne(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE mysqlSideTable(
    id int,
    varchar_data string,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='ALL',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'table-name'='stream_mysql_ogg_one',
    'lookup.cache-period'='60000',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE kafkaResultOne(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'format'='json',
    'topic'='fanshu4',
    'sink.parallelism'='1'
 );
-- name flinksql_view
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-03-30 20:51:04
-- desc
CREATE VIEW viewTable AS SELECT
    st.id as id,
    ost.varchar_data as name ,
    st.age as age           
FROM
    sourceTableOne st         
LEFT JOIN
    mysqlSideTable for SYSTEM_TIME as of st.proc_time as ost                                                                                                            
        on         st.id = ost.id;
INSERT           
INTO
    kafkaResultOne
    SELECT
        id,
        name,
        age          
    FROM
        viewTable;

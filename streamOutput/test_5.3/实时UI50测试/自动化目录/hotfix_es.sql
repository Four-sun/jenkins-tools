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

CREATE TABLE esResultTable(
    id int,
    name varchar,
    age int,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch7-x',
    'sink.bulk-flush.max-actions'='100',
    'hosts'='172.16.100.229:9200;172.16.100.242:9200;172.16.101.116:9200',
    'index'='stream_test',
    'sink.parallelism'='1'
 );
-- name hotfix_es
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-08-11 17:19:03
-- desc 
INSERT 
INTO
    esResultTable
    select
        st.id,
        st.name as name,
        st.age as age 
    from
        sourceTable st

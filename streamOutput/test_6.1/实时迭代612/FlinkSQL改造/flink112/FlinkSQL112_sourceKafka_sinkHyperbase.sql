CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='mizhi',
    'scan.startup.mode'='latest-offset'
 );


-- name FlinkSQL116_sourceKafka_sinkHyperbase
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-05-29 17:58:01
-- desc FlinkSQL116_sourceKafka_sinkHyperbase
-- name kafka2hyperbase1
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2023-04-13 20:06:43
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







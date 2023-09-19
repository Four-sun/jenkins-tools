


-- 已验证通过
CREATE TABLE sourceTable(
    id int,
    name varchar,
    timestamp_data timestamp(6) ,
    tinyint_data int,
    decimal_data decimal,
    double_data double,
    varchar_data varchar,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_doris_all_type',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE dorisResultTable(
    id INT,
    name VARCHAR(100) ,
    idcard VARCHAR(100) ,
    birthday TIMESTAMP(6) ,
    mobile VARCHAR(100) ,
    email VARCHAR(100) ,
    gender INT,
    create_time TIMESTAMP(6) ,
    type_smallint INT,
    type_mediumint INT,
    type_bigint INT,
    type_decimal DECIMAL(10,2) ,
    type_float FLOAT,
    type_double DOUBLE,
    type_text VARCHAR(65533)
 )WITH(
    'connector'='doris-x',
    'sink.buffer-flush.interval'='1000',
    'schema-name'='test',
    'feNodes'='172.16.83.193:8030',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_doris_result_table',
    'sink.parallelism'='1',
    'username'='root'
 );
INSERT
INTO
    dorisResultTable
    SELECT
        st.id,
        st.name,
        st.name as idcard,
        st.timestamp_data as birthday,
        st.name as mobile,
        st.name as email,
        st.tinyint_data as gender,
        st.timestamp_data as create_time,
        st.tinyint_data  as type_smallint,
        st.tinyint_data  as type_mediumint,
        st.tinyint_data  as type_bigint,
        st.decimal_data as type_decimal,
        1.1 as type_float,
        st.double_data as type_double,
        st.varchar_data as type_text
    FROM
        sourceTable st;


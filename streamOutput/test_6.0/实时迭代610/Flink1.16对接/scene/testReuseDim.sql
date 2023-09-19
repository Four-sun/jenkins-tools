


-- 数据打不进结果表
CREATE TABLE MyTable1(
    id INT,
    name VARCHAR,
    age INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_testReuseDim_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTable2(
    id INT,
    name VARCHAR,
    age INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_testReuseDim_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult1(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_testreusedim_resultone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE MyResult2(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_testreusedim_resulttwo',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='testreusedim_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW test_view AS   SELECT
    tableB.id,
    tableB.name,
    tableA.age,
    tableA.address,
    tableA.school,
    tableA.message,
    tableA.start_time
FROM
    (     SELECT
        t1.id,
        t1.name,
        t1.age,
        t1.address,
        t1.school,
        t1.message,
        t1.start_time
    FROM
        MyTable1 t1      ) as tableA
JOIN
    (
        SELECT
            t2.id,
            t2.name,
            t2.age,
            t2.address,
            t2.school,
            t2.message,
            t2.start_time
        FROM
            MyTable2 t2
    ) as tableB
        ON tableA.id = tableB.id;
CREATE VIEW test_view2 AS  SELECT
    tv.id,
    tv.name,
    tv.age,
    st.address,
    st.school,
    st.message,
    st.start_time,
    st.end_time
FROM
    test_view tv
LEFT JOIN
    SideTable st
        ON tv.id = st.id;
CREATE VIEW test_view3 AS  SELECT
    tv.id,
    tv.name,
    tv.age,
    st.address,
    st.school,
    st.message,
    st.start_time,
    st.end_time
FROM
    test_view tv
LEFT JOIN
    SideTable st
        ON tv.id = st.id;
INSERT
INTO
    MyResult1
    SELECT
        tv2.id,
        tv2.name,
        tv2.address,
        tv2.school,
        tv2.message,
        tv2.start_time,
        tv2.end_time
    FROM
        test_view2 tv2;
INSERT
INTO
    MyResult2
    SELECT
        tv3.id,
        tv3.name,
        tv3.address,
        tv3.school,
        tv3.message,
        tv3.start_time,
        tv3.end_time
    FROM
        test_view3 as tv3;


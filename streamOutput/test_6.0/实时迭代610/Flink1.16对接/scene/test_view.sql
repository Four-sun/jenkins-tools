


-- 数据未打入
CREATE TABLE MyTable1(
    id INT,
    name VARCHAR,
    age INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_test_view_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTable2(
    id INT,
    name VARCHAR,
    age INT,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_test_view_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    id INT,
    age INT,
    address VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_testview_resultone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    name VARCHAR,
    age INT,
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
    'table-name'='testview_sidetableone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW test_view AS   SELECT
    tableA.id,
    tableA.age,
    tableB.address
FROM
    (     SELECT
        MAX(t1.id) as id,
        MAX(t1.age) as age
    FROM
        MyTable1 t1
    GROUP BY
        t1.id      ) as tableA
JOIN
    (
        SELECT
            MAX(t2.id) as id,
            MAX(t2.address) as address
        FROM
            MyTable2 t2
        GROUP BY
            t2.id
    ) as tableB
        ON tableA.id = tableB.id;
CREATE VIEW test_view2 AS  SELECT
    tv.id,
    tv.age,
    st.address
FROM
    test_view tv
LEFT JOIN
    SideTable st
        ON tv.id = st.id;
INSERT
INTO
    MyResult
    SELECT
        *
    FROM
        test_view2 tv2;


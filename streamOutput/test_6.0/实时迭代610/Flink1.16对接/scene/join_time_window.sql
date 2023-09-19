


-- 已验证通过
CREATE TABLE MyTable1(
    id INT,
    channel VARCHAR,
    name VARCHAR,
    start_time TIMESTAMP(3),
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_join_time_window_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTable2(
    id INT,
    channel VARCHAR,
    name VARCHAR,
    start_time TIMESTAMP(3),
    WATERMARK FOR start_time AS start_time - INTERVAL'10'SECOND
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_join_time_window_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    mt_channel VARCHAR,
    mt_pv INT,
    mt_outtime TIMESTAMP,
    PRIMARY KEY(mt_pv) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_jointimewindow_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT
INTO
    MyResult
    SELECT
        mt1.channel AS mt_channel,
        mt1.id AS mt_pv,
        mt2.start_time AS mt_outtime
    FROM
        MyTable1 mt1
    LEFT JOIN
        MyTable2 mt2
            ON mt1.channel = mt2.channel
            AND mt1.start_time BETWEEN mt2.start_time - INTERVAL '10' SECOND AND mt2.start_time;


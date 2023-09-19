


-- 已验证通过
CREATE TABLE MyTable1(
    id INT,
    channel VARCHAR,
    name VARCHAR,
    start_time TIMESTAMP
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_join_no_time_window_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTable2(
    id INT,
    channel VARCHAR,
    name VARCHAR,
    start_time TIMESTAMP
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_join_no_time_window_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    mt_channel VARCHAR,
    mt_pv INT,
    mt_xctime TIMESTAMP,
    PRIMARY KEY(mt_pv) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_joinnotimewindow_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert
into
    MyResult
    SELECT
        mt1.channel AS mt_channel,
        mt1.id AS mt_pv,
        mt2.start_time AS mt_xctime
    FROM
        MyTable1 mt1
    left join
        MyTable2 mt2
            on mt1.channel = mt2.channel;


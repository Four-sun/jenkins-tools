


-- 已验证通过
CREATE TABLE TableJoin_SourceTable(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    message VARCHAR,
    start_time TIME,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='4TableJoin',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE TableJoin_ResultTable(
    sink_id INT,
    sink_name VARCHAR,
    sink_start_time TIME,
    sink_school VARCHAR,
    sink_message VARCHAR,
    sink_end_time TIMESTAMP,
    PRIMARY KEY(sink_id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_4tablejoin_table',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE TableJoin_SideOne(
    message VARCHAR,
    PRIMARY KEY(message) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='4tablejoin_sideone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE TableJoin_SideTwo(
    id INT,
    name VARCHAR,
    start_time TIME,
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
    'table-name'='4tablejoin_sidetwo',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE TableJoin_SideThree(
    name VARCHAR,
    PRIMARY KEY(name) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='4tablejoin_sidethree',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE TableJoin_SideFour(
    mid INT,
    mbb VARCHAR,
    mstime TIME,
    metime TIMESTAMP,
    PRIMARY KEY(mid) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='4tablejoin_sidefour',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE VIEW ViewOne AS select
    ST.message AS view_one_message,
    ST.school AS view_one_school,
    ST.name AS view_one_name,
    ST.start_time AS view_one_start_time,
    DF.mid AS view_one_id
from
    TableJoin_SourceTable ST
left join
    TableJoin_SideFour FOR SYSTEM_TIME AS OF ST.proc_time AS DF
        on ST.id = DF.mid
left join
    TableJoin_SideThree FOR SYSTEM_TIME AS OF ST.proc_time AS DT
        on ST.name = DT.name;
CREATE VIEW ViewTwo AS SELECT
    DT.name AS view_two_name,
    DT.end_time AS view_two_end_time,
    DT.start_time AS view_two_start_time
FROM
    TableJoin_SourceTable ST
LEFT JOIN
    TableJoin_SideTwo FOR SYSTEM_TIME AS OF ST.proc_time AS DT
        on DT.name = ST.name
GROUP BY
    DT.name,
    DT.end_time,
    DT.start_time;
INSERT
INTO
    TableJoin_ResultTable
    SELECT
        VO.view_one_id AS sink_id     ,
        VO.view_one_name AS sink_name     ,
        VT.view_two_start_time AS sink_start_time     ,
        VO.view_one_message AS sink_message     ,
        VO.view_one_school AS sink_school     ,
        VT.view_two_end_time AS sink_end_time
    FROM
        ViewOne VO
    LEFT JOIN
        TableJoin_SideTwo DT
            ON DT.name = VO.view_one_name
    LEFT JOIN
        ViewTwo VT
            ON VO.view_one_start_time = VT.view_two_start_time
    LEFT JOIN
        TableJoin_SideOne DO
            ON VO.view_one_message = DO.message
    LEFT JOIN
        TableJoin_SourceTable ST
            on ST.name = VO.view_one_name
            and  ST.id = VO.view_one_id
    GROUP BY
        VO.view_one_id     ,
        VO.view_one_name     ,
        VT.view_two_start_time     ,
        VO.view_one_message     ,
        VO.view_one_school     ,
        VT.view_two_end_time;


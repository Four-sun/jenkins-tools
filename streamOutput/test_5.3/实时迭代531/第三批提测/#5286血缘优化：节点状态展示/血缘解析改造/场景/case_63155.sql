-- name case_63155
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-09 15:17:01
-- desc 
CREATE TABLE d_form_filling_record(
    message ROW< after ROW<form_subtitle varchar,
    check_method varchar,
    check_classification varchar,
    check_result varchar > >,
    proc_time AS PROCTIME()
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_reuseSideTable',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE test_table(
    jcdbt VARCHAR,
    jcff_bm VARCHAR,
    jcff_mc VARCHAR,
    jcfl_bm VARCHAR,
    jcfl_mc VARCHAR,
    jcjg_bm VARCHAR,
    jcjg_mc VARCHAR,
    PRIMARY KEY(jcdbt) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_reuseresulttable',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE dim_d_form_dict(
    dict_code VARCHAR,
    dict_value VARCHAR,
    dict_type VARCHAR,
    id INT,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='reusesidetable',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
INSERT
INTO
    test_table
    SELECT
        a.form_subtitle as jcdbt,
        a.check_method as jcff_bm,
        '' as jcff_mc,
        a.check_classification as jcfl_bm,
        c.dict_value as jcfl_mc,
        a.check_result as jcjg_bm,
        d.dict_value as jcjg_mc
    FROM
        d_form_filling_record a
    LEFT JOIN
        dim_d_form_dict b
            ON a.check_method = b.dict_code
    LEFT JOIN
        dim_d_form_dict c
            ON a.check_classification = c.dict_code
    LEFT JOIN
        dim_d_form_dict d
            ON  a.check_result = d.dict_code
    where
        b.id = 1
        and c.id = 2
        and d.id = 3;


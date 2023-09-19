CREATE TABLE sourceTable(
    id int,
    name varchar
 )WITH(
    'properties.bootstrap.servers'='172.16.100.109:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='fanshu2',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE es6ResultTable(
    id int,
    name varchar,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='elasticsearch6-x',
    'sink.bulk-flush.max-actions'='100',
    'hosts'='172.16.100.186:9200',
    'index'='stream_test',
    'sink.parallelism'='1',
    'document-type'='external'
 );
INSERT 
INTO
    es6ResultTable
    select
        id,
        name 
    from
        sourceTable;

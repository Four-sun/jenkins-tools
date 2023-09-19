CREATE TABLE sourceTable(
    id int,
    name varchar
 )WITH(
    'consumer.group'='STREAM_APP_ROCKET_MQ',
    'time.zone'='Asia/Shanghai',
    'connector'='rocketmq-x',
    'nameserver.address'='172.16.83.182:9876',
    'consumer.start-offset-mode'='latest',
    'topic'='TopicWang',
    'tag'='*',
    'encoding'='utf-8'
 );

CREATE TABLE mysqlResultTableOne(
    id bigint,
    varchar_data string
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='stream_mysql_ogg_one',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );

INSERT 
INTO
    mysqlResultTableOne
    select
        st.id,
        st.name as varchar_data
    from
        sourceTable st


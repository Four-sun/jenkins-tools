


-- 失败已提交
CREATE TABLE MyTable1(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_left_join_group_by_one',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyTable2(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'properties.bootstrap.servers'='172.16.21.237:9092',
    'connector'='kafka-x',
    'scan.parallelism'='1',
    'format'='json',
    'topic'='source_112_left_join_group_by_two',
    'scan.startup.mode'='latest-offset'
 );
CREATE TABLE MyResult(
    m1_id INT,
    m1_name VARCHAR,
    m2_name VARCHAR,
    st_school VARCHAR,
    PRIMARY KEY(m1_id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'sink.buffer-flush.interval'='1000',
    'sink.all-replace'='false',
    'sink.buffer-flush.max-rows'='100',
    'table-name'='result_112_leftjoinsgroupby_resulttableone',
    'sink.parallelism'='1',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
CREATE TABLE SideTable(
    id INT,
    name VARCHAR,
    address VARCHAR,
    school VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'password' = '******',
    'connector'='mysql-x',
    'lookup.cache-type'='LRU',
    'lookup.parallelism'='1',
    'vertx.worker-pool-size'='5',
    'lookup.cache.ttl'='60000',
    'lookup.cache.max-rows'='10000',
    'table-name'='leftjoinsgroupby_sideone',
    'url'='jdbc:mysql://172.16.100.186:3306/automation',
    'username'='drpeco'
 );
insert 
into
    MyResult
    select
        m1.id as m1_id,
        m1.name as m1_name,
        m2.name as m2_name,
        st.school as st_school     
    from
        MyTable1 m1     
    left join
        MyTable2 m2             
            on                    m1.id = m2.id     
    left join
        SideTable st             
            on                     m2.name = st.name     
    where
        m1.age <> 20         
        and st.school = 'school'         
        and st.address <> 'address_0'         
        and st.address LIKE '%address%'         
        and st.school in (
            'school','school_1'         
        )         
        and st.id between 1 and 10000         
        and st.school is not null     
    group by
        m1.id,
        m1.name,
        m2.name,
        st.school;

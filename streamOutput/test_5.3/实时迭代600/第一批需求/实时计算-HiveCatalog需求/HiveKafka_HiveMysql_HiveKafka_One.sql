


-- name HiveKafka_HiveOracle_HiveKafka_One
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-12-30 11:51:01
-- desc
INSERT 
INTO
    stream_600_test.stream_db_600.kafkaresulttable
    select
        st.id,
        ost.varchar_data as name,
        st.age 
    from
        stream_600_test.stream_db_600.sourcetableone st 
    left join
        stream_600_test.stream_db_600.mysqlresulttableone for SYSTEM_TIME as of st.proc_time as ost
    on st.id = ost.id;
    -- s

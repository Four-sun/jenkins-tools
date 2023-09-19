


-- name debug
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-25 11:08:26
-- desc 
CREATE TABLE sourceTable(
    id int,
    name varchar,
    age int,
    proc_time AS PROCTIME() 
 )WITH(
    'path'='/home/admin/sftp/dttestuic_com/stream/debugData/Task_43/7250f920-ac23-4ea9-84b8-f3b397b01c58//fanshu_catalog.fanshu_database.sourceTable_v1.csv',
    'protocol'='sftp',
    'password' = '******',
    'connector'='ftp-x',
    'isFirstLineHeader'='true',
    'host'='172.16.82.70',
    'format'='csv',
    'username'='admin'
 );
CREATE TABLE mysqlResultTableOne(
    id INT,
    int_data INT,
    varchar_data VARCHAR,
    PRIMARY KEY(id) NOT ENFORCED
 )WITH(
    'connector'='http-x',
    'method'='post',
    'url'='http://172.16.84.247:9021/api/streamapp/service/streamTaskDebug/callback/7250f920-ac23-4ea9-84b8-f3b397b01c58/mysqlResultTableOne'
 );
-- name session_insert_one
-- type FlinkSQL
-- author admin@dtstack.com
-- create time 2022-10-17 15:37:03
-- desc
INSERT       
INTO
    mysqlResultTableOne
    select
        id,
        age as int_data,
        name as varchar_data                             
    from
        sourceTable;

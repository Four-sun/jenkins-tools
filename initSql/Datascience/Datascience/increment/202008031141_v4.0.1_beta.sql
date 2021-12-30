alter table science_task add column preset tinyint(4) default 0 comment '是否为预置实验演示任务,0为非预置,1为预置演示,默认为0';

update science_task
set preset = 1
where flow_id = 0 and (task_type = 14 and name in ('HeartDisease_Prediction', 'Shop_Cluster'))
          || (task_type = 6 and name in ('LR', 'RandomForest', 'SVM', 'dbscan', 'keras_number', 'kmeans'));
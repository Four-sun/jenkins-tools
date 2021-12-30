-- 数据模型初始化数据
INSERT INTO `rdos_batch_model_table`
(`tenant_id`,`project_id`,`type`,`name`,`prefix`,`model_desc`,`life_day`,`depend`,`create_user_id`,`modify_user_id`)
VALUES
(-1,-1,1,"ods","ods","操作数据层",1000,1,-1,-1),
(-1,-1,1,"dwd","dwd","数据仓库明细层",365,1,-1,-1),
(-1,-1,1,"dws","dws","数据仓库汇总层",90,1,-1,-1),
(-1,-1,1,"ads","ads","数据应用层",7,1,-1,-1),
(-1,-1,1,"tmp","tmp","临时表",7,0,-1,-1),
(-1,-1,1,"dim","dim","维度表",30,0,-1,-1),

(-1,-1,2,"sales","sales","销售",null,0,-1,-1),
(-1,-1,2,"customer","cust","客户",null,0,-1,-1),
(-1,-1,2,"marketing","mkt","市场",null,0,-1,-1),
(-1,-1,2,"purchasing","purch","采购",null,0,-1,-1),
(-1,-1,2,"manufacturing","manu","生产",null,0,-1,-1),
(-1,-1,2,"logistics","logi","物流",null,0,-1,-1),
(-1,-1,2,"warehouse","wms","仓储",null,0,-1,-1),
(-1,-1,2,"finance","fin","财务",null,0,-1,-1),
(-1,-1,2,"customer service","csc","客服",null,0,-1,-1),
(-1,-1,2,"human resources","hr","人力资源",null,0,-1,-1),
(-1,-1,2,"product","prod","产品",null,0,-1,-1),
(-1,-1,2,"public","pub","公共",null,0,-1,-1),

(-1,-1,3,"realtime","r","实时",null,0,-1,-1),
(-1,-1,3,"minute","min","分钟",null,0,-1,-1),
(-1,-1,3,"hour","h","小时",null,0,-1,-1),
(-1,-1,3,"day","d","天",null,0,-1,-1),
(-1,-1,3,"week","w","周",null,0,-1,-1),
(-1,-1,3,"month","m","月",null,0,-1,-1),
(-1,-1,3,"year","y","年",null,0,-1,-1),

(-1,-1,4,"inc","i","增量",null,0,-1,-1),
(-1,-1,4,"full","f","全量",null,0,-1,-1);


INSERT INTO `rdos_batch_model_rule`
(`tenant_id`,`project_id`,`rule`,`create_user_id`,`modify_user_id`)
VALUES
(-1,-1,"[1,2,5,3,4]",-1,-1);

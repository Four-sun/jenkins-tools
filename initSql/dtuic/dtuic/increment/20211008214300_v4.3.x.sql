update uic_license
set license_info = '{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"id":"database","field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"offline","field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataManage","field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":false,"id":"dataModel","field":"数据模型","fieldType":"checkbox","value":false,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":10000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":10000,"widgetType":1},{"defaultValue":10000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":10000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"id":"database","field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"development","field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":2000,"widgetType":1},{"children":[{"defaultValue":true,"id":"overview","field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"recordQuery","field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"monitorConfig","field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实时校验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataSourceMgr","field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"projectMgr","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":500,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":500,"widgetType":1},{"children":[{"defaultValue":true,"id":"overview","field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"apiMarket","field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"apiManage","field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataSource","field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"projectManage","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project_manage_menu","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"entity_manage_menu","field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"tag_center_menu","field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"group_analysis_menu","field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Science","componentId":"science","componentName":"算法开发","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"science","field":"显示名称","fieldType":"input","value":"DataScienceIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"id":"workbench","field":"算法开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"source","field":"数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"id":"INVENTORY","field":"资产盘点","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATASTANDARD","field":"数据标准","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATAMODEL","field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"METADATA","field":"元数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"PLATFORMMGR","field":"平台管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATARESOURCE","field":"数据资源","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.MessageManager","componentId":"messageManager","componentName":"消息管理","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"MessageManager","field":"显示名称","fieldType":"input","value":"MessageManager","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"id":"CLUSTERCONTROLLER","field":"集群管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"TOPIC","field":"Topic","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATASAMPLING","field":"数据采样","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"CLUSTERDETAIL","field":"集群详情","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"USERMANAGER","field":"用户管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"easyIndex","componentId":"easyIndex","componentName":"指标管理","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"EasyIndex","field":"显示名称","fieldType":"input","value":"EasyIndex","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"34","field":"容量/版本","fieldType":"input","value":"34","widgetType":2},{"children":[{"defaultValue":true,"id":"INDEXPOOL","field":"指标池","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"IINDEXCENTER","field":"指标中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"MAINTENANCECENTER","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"PROJECTMANAGE","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DTinsight（基础版）","productCode":"DTinsight"}'
where custom = '数栈基础版-4.3';



update uic_license
set license_info = '{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"id":"database","field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"offline","field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataManage","field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":false,"id":"dataModel","field":"数据模型","fieldType":"checkbox","value":false,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":10000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":10000,"widgetType":1},{"defaultValue":10000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":10000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"id":"database","field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"development","field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":2000,"widgetType":1},{"children":[{"defaultValue":true,"id":"overview","field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"recordQuery","field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"monitorConfig","field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实时校验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataSourceMgr","field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"projectMgr","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":500,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":500,"widgetType":1},{"children":[{"defaultValue":true,"id":"overview","field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"apiMarket","field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"apiManage","field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"dataSource","field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"projectManage","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project_manage_menu","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"entity_manage_menu","field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"tag_center_menu","field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"group_analysis_menu","field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Science","componentId":"science","componentName":"算法开发","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"science","field":"显示名称","fieldType":"input","value":"DataScienceIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"id":"workbench","field":"算法开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"operation","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"source","field":"数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"project","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"id":"INVENTORY","field":"资产盘点","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATASTANDARD","field":"数据标准","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATAMODEL","field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"METADATA","field":"元数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"PLATFORMMGR","field":"平台管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATARESOURCE","field":"数据资源","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.MessageManager","componentId":"messageManager","componentName":"消息管理","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"MessageManager","field":"显示名称","fieldType":"input","value":"MessageManager","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"id":"CLUSTERCONTROLLER","field":"集群管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"TOPIC","field":"Topic","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"DATASAMPLING","field":"数据采样","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"CLUSTERDETAIL","field":"集群详情","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"USERMANAGER","field":"用户管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"easyIndex","componentId":"easyIndex","componentName":"指标管理","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"EasyIndex","field":"显示名称","fieldType":"input","value":"EasyIndex","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"34","field":"容量/版本","fieldType":"input","value":"34","widgetType":2},{"children":[{"defaultValue":true,"id":"INDEXPOOL","field":"指标池","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"IINDEXCENTER","field":"指标中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"MAINTENANCECENTER","field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"id":"PROJECTMANAGE","field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DTinsight（基础版）","productCode":"DTinsight"}'
where custom = '数栈高级版-4.3';
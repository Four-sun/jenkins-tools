CREATE TABLE uic_sub_product (
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  product_code  varchar(30) NOT NULL COMMENT '产品CODE',
  sub_product_code varchar(30) NOT NULL COMMENT '子产品CODE',
  sub_product_name varchar(64) NOT NULL COMMENT '子产品名称',
  sub_product_desc varchar(64) DEFAULT NULL COMMENT '子产品描述',
  order_num  int(11)  DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='子产品列表';


CREATE TABLE uic_user_sub_product_rel (
  id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  is_deleted varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否删除,Y删除，N未删除',
  gmt_create datetime DEFAULT NULL COMMENT '创建时间',
  gmt_modified datetime DEFAULT NULL COMMENT '修改时间',
  creator int(11) DEFAULT NULL COMMENT '创建人',
  modifier int(11) DEFAULT NULL COMMENT '修改人',
  tenant_id int(11) unsigned NOT NULL COMMENT '关联租户id',
  user_id int(11) unsigned NOT NULL COMMENT '关联用户id',
  product_code varchar(30) NOT NULL COMMENT '产品CODE',
  sub_product_code varchar(30) NOT NULL COMMENT '子产品CODE',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户-子产品角色关联表';


INSERT INTO uic_sub_product
( gmt_create,gmt_modified,product_code,sub_product_code,sub_product_name,sub_product_desc)
VALUE
(NOW(),NOW(),'RDOS','rdos','离线开发','一站式多引擎离线数据开发平台，新一代数据仓库，开发效率升一倍'),
(NOW(),NOW(),'RDOS','stream','实时开发','全链路流计算FlinkSQL开发平台，秒级实时开发，人力省一半'),
(NOW(),NOW(),'RDOS','dataQuality','数据质量','配置关键数据表校验与监控规则，及时发现数据质量问题'),
(NOW(),NOW(),'RDOS','dataApi','数据API','可视化生成、注册、管理数据API，快速构建 OneService 数据共享服务'),
(NOW(),NOW(),'RDOS','tagEngine','标签引擎','基于 OneID 构建的实体标签引擎，数据萃取赋能业务创新'),
(NOW(),NOW(),'RDOS','science','算法开发','可视化的机器学习算法开发平台，算法开发工程化，效率提升 100%'),
(NOW(),NOW(),'RDOS','dataAssets','数据资产','通过元数据管理，实现企业数据的标准化与资产化。打造企业级数据中心"
');

INSERT INTO uic_user_sub_product_rel (
gmt_create,
gmt_modified,
tenant_id,
user_id,
product_code,
sub_product_code
)
SELECT
  NOW( ),
  NOW( ),
  p.tenant_id AS tenant_id,
  p.user_id AS user_id,
  p.product_code AS product_code,
  s.sub_product_code AS sub_product_code
FROM
  uic_user_product_rel AS p
  LEFT JOIN uic_sub_product AS s ON p.product_code = s.product_code
WHERE
  p.is_deleted = 'N'
  AND p.product_code = 'RDOS';
  
  
update uic_license set license_info
='{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":10000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":10000,"widgetType":1},{"defaultValue":10000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":10000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":2000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":false,"field":"逐行校验","fieldType":"checkbox","value":false,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":500,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":500,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Science","componentId":"science","componentName":"算法开发","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"science","field":"显示名称","fieldType":"input","value":"DataScienceIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"算法实验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"元数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"安全管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DTinsight（基础版）","productCode":"DTinsight"}' where id =40;

update uic_license set license_info
='{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":100000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":100000,"widgetType":1},{"defaultValue":100000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":100000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":4,"field":"容量限制","fieldType":"input","value":4,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":100000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":100000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"逐行校验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":100000,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":100000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Science","componentId":"science","componentName":"算法开发","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"science","field":"显示名称","fieldType":"input","value":"DataScienceIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"算法实验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"元数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"安全管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DTinsight（高级版）","productCode":"DTinsight"}' where id =49;


update uic_license set license_info
='{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":100000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":100000,"widgetType":1},{"defaultValue":100000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":100000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":4,"field":"容量限制","fieldType":"input","value":4,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":100000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":100000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"逐行校验","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":100000,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":100000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"元数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"安全管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DataQ-ECO（高级版）","productCode":"DTinsight"}' where id =50;

update uic_license set license_info
='{"components":[{"componentCode":"Hadoop.hdfs_namenode;Hadoop,yarn_nodemanager","componentName":"计算节点","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"计算节点","field":"显示名称","fieldType":"input","value":"计算节点","widgetType":3},{"defaultValue":30,"field":"容量限制","fieldType":"input","value":30,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2}]},{"componentCode":"DTApp.Batch","componentId":"rdos","componentName":"离线计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"离线计算","field":"显示名称","fieldType":"input","value":"离线计算","widgetType":3},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"运维中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据模型","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3},{"defaultValue":10000,"effectApi":"batchHiveTableInfo/ddlCreateTable;batchHiveTableInfo/createTable","field":"表数量","fieldType":"input","proofImpl":"batchHiveTableInfo/capableOfCreate","value":10000,"widgetType":1},{"defaultValue":10000,"effectApi":"batchTask/addOrUpdateTask","field":"任务数","fieldType":"input","proofImpl":"batchTask/capableOfCreate","value":10000,"widgetType":1}]},{"componentCode":"DTApp.Stream","componentId":"stream","componentName":"实时计算","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"StreamIDE","field":"显示名称","fieldType":"input","value":"StreamIDE","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据开发","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务运维","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Analytics","componentId":"analyticsEngine","componentName":"分析引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Analytics","field":"显示名称","fieldType":"input","value":"Analytics","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":20,"effectApi":"dataBaseManagement/createTable;dataBaseManagement/ddlCreateTable","field":"表数量限制","fieldType":"input","proofImpl":"dataBaseManagement/capableOfCreate","value":20,"widgetType":1},{"defaultValue":10,"effectApi":"","field":"并发查询限制","fieldType":"input","proofImpl":"","value":10,"widgetType":1},{"children":[{"defaultValue":true,"field":"数据库管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"表管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.Valid","componentId":"dataQuality","componentName":"数据质量","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"Valid","field":"显示名称","fieldType":"input","value":"Valid","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":2000,"effectApi":"monitor/add","field":"规则数","fieldType":"input","proofImpl":"monitor/capableOfCreate","value":2000,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"任务查询","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"规则配置","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":false,"field":"逐行校验","fieldType":"checkbox","value":false,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]},{"componentCode":"DTApp.API","componentId":"dataApi","componentName":"数据API","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"API","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"defaultValue":500,"effectApi":"apis/saveOrUpdateApiInfo","field":"API总数","fieldType":"input","proofImpl":"apis/capableOfCreate","value":500,"widgetType":1},{"children":[{"defaultValue":true,"field":"概览","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API市场","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的API","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"API管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"授权与安全","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.tagEngine","componentId":"tagEngine","componentName":"标签引擎","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"API","field":"显示名称","fieldType":"input","value":"tagEngine","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":34,"field":"容量/版本","fieldType":"input","value":34,"widgetType":2},{"children":[{"defaultValue":true,"field":"数据源管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"项目管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"实体管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"标签中心","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"群组分析","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"数据服务","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","widgetType":3}]},{"componentCode":"DTApp.Assets","componentId":"dataAssets","componentName":"数据资产","widgets":[{"defaultValue":true,"field":"是否授权","fieldType":"radio","value":true,"widgetType":3},{"defaultValue":"dataAsset","field":"显示名称","fieldType":"input","value":"dataAsset","widgetType":3},{"defaultValue":2,"field":"容量限制","fieldType":"input","value":2,"widgetType":2},{"defaultValue":"1.0","field":"容量/版本","fieldType":"input","value":"1.0","widgetType":2},{"children":[{"defaultValue":true,"field":"数据地图","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"元数据管理","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"我的数据","fieldType":"checkbox","value":true,"widgetType":3},{"defaultValue":true,"field":"安全管理","fieldType":"checkbox","value":true,"widgetType":3}],"defaultValue":true,"field":"功能模块","fieldType":"checkboxGroup","value":true,"widgetType":3}]}],"product":"DataQ-ECO（基础版）","productCode":"DTinsight"}' where id =51;

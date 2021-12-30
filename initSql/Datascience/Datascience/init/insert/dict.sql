INSERT INTO `science_dict`(`type`, `dict_name`, `dict_value`, `dict_name_zh`, `dict_name_en`, `dict_sort`, `gmt_create`,
                           `gmt_modified`, `is_deleted`)
VALUES ('12', 'Notebook', '1', 'Notebook', 'notebook', '1', now(), now(), '0'),
       ('12', 'Laboratory', '2', '实验', 'laboratory', '2', now(), now(), '0'),
       ('12', 'Component', '3', '组件', 'component', '3', now(), now(), '0'),
       ('12', 'Model', '4', '模型', 'model', '4', now(), now(), '0'),
       ('12', 'Resource', '5', '资源管理', 'resource', '5', now(), now(), '0'),

       ('13', 'Notebook', '1', 'Notebook开发', 'notebook', '1', now(), now(), '0'),
       ('13', 'Laboratory', '2', '实验开发', 'laboratory', '2', now(), now(), '0'),
       ('13', 'Component', '3', '数据源/目标', 'component', '1', now(), now(), '0'),
       ('13', 'Component', '3', '数据工具', 'component', '2', now(), now(), '0'),
       ('13', 'Component', '3', '数据合并', 'component', '3', now(), now(), '0'),
       ('13', 'Component', '3', '数据预处理', 'component', '4', now(), now(), '0'),
       ('13', 'Component', '3', '机器学习', 'component', '5', now(), now(), '0'),
       ('13', 'Component', '3', '预测', 'component', '6', now(), now(), '0'),
       ('13', 'Component', '3', '评估', 'component', '7', now(), now(), '0'),
       ('13', 'Component', '3', '特征工程', 'component', '8', now(), now(), '0'),
       ('13', 'Resource', '5', '资源管理', 'resource', '1', now(), now(), '0'),
       ('13', 'Component', '3', '自定义组件', 'component', '9', now(), now(), '0'),

       ('14', 'Notebook', '1', 'Notebook演示', 'notebook', '1', now(), now(), '0'),
       ('14', 'Notebook', '1', '我的Notebook', 'notebook', '2', now(), now(), '0'),
       ('14', 'Laboratory', '2', '实验演示', 'laboratory', '1', now(), now(), '0'),
       ('14', 'Laboratory', '2', '我的实验', 'laboratory', '2', now(), now(), '0')


on duplicate key update gmt_create=values(gmt_create);
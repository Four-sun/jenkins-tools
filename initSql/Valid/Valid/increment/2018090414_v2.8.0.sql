-- 文案修改
update dq_dict set dict_name = '月度波动检测', dict_name_en = '月度波动检测', gmt_modified = now() WHERE dict_name = '30天波动检测' and type = 2;
update dq_dict set dict_name = '月度平均值波动检测', dict_name_en = '月度平均值波动检测', gmt_modified = now() WHERE dict_name = '30天平均值波动检测' and type = 2;


-- 修改系统函数中的 双引号为单引号
UPDATE rdos_stream_function SET param_desc=REPLACE(param_desc,'"','\'')  WHERE param_desc LIKE '%\"%' and type = 1;
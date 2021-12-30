use common;
update task_param_template set params = '##sql开头的参数仅仅适用于SQL任务, mr开头的参数仅仅适用于MR任务, 其他参数两者都适用

##sql任务并发度设置
sql.env.parallelism=1

## sql任务最大并发度设置
##sql.max.env.parallelism=1


##设置输出缓冲区的最大刷新时间频率（毫秒）。
##sql.buffer.timeout.millis=100

##生成checkpoint时间间隔（以毫秒为单位）,注释掉该选项会关闭checkpoint生成
sql.checkpoint.interval=300000

##任务出现故障的时候一致性处理,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE
##sql.checkpoint.mode=EXACTLY_ONCE

##设置checkpoint生成超时（以毫秒为单位），默认:10分钟
##sql.checkpoint.timeout=600000

##最大并发生成 checkpoint 数量，默认：1 次
##sql.max.concurrent.checkpoints=1

##checkpoint 外存的清理动作，true（任务结束之后删除checkpoint外部存储信息）or
##false（任务结束之后保留checkpoint外部存储信息）
sql.checkpoint.cleanup.mode=false


## mr任务的并发度设置，注意：只有当任务本身并没有设置并发度参数的时候才生效
##mr.job.parallelism=1

## 任务运行方式,per_job:单独为任务创建flink yarn session，new:多个任务共用一个flink yarn session,默认per_job
## flinkTaskRunMode=per_job'

where compute_type = 0 and engine_type = 0
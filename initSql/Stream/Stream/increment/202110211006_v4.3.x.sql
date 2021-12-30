BEGIN;
UPDATE `rdos_stream_param_template`
SET `param` ='## 资源相关
parallelism.default=1
taskmanager.numberOfTaskSlots=1
jobmanager.memory.process.size=1g
taskmanager.memory.process.size=2g

## 时间相关
## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选
## 非脚本模式会根据Kafka自动设置。脚本模式默认为ProcessingTime
# pipeline.time-characteristic=EventTime

## Checkpoint相关
## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成
execution.checkpointing.interval=5min
## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE
# execution.checkpointing.mode=EXACTLY_ONCE
##任务取消后保留hdfs上的checkpoint文件
execution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION

# Flink SQL独有，状态过期时间
table.exec.state.ttl=1d

log.level=INFO

## 使用Iceberg和Hive维表开启
# table.dynamic-table-options.enabled=true

## Kerberos相关
# security.kerberos.login.contexts=Client,KafkaClient


## 高阶参数
## 窗口提前触发时间
# table.exec.emit.early-fire.enabled=true
# table.exec.emit.early-fire.delay=1s

## 当一个源在超时时间内没有收到任何元素时，它将被标记为临时空闲
# table.exec.source.idle-timeout=10ms

## 是否开启minibatch
## 可以减少状态开销。这可能会增加一些延迟，因为它会缓冲一些记录而不是立即处理它们。这是吞吐量和延迟之间的权衡
# table.exec.mini-batch.enabled=true
## 状态缓存时间
# table.exec.mini-batch.allow-latency=5s
## 状态最大缓存条数
# table.exec.mini-batch.size=5000

## 是否开启Local-Global 聚合。前提需要开启minibatch
## 聚合是为解决数据倾斜问题提出的，类似于 MapReduce 中的 Combine + Reduce 模式
# table.optimizer.agg-phase-strategy=TWO_PHASE

## 是否开启拆分 distinct 聚合
## Local-Global 可以解决数据倾斜，但是在处理 distinct 聚合时，其性能并不令人满意。
## 如：
SELECT day, COUNT (DISTINCT user_id)
FROM T
GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启
# table.optimizer.distinct-agg.split.enabled=true


## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。
# pipeline.operator-chaining=true',`gmt_modified` = now()
WHERE `task_type` = 0 AND `component_version` ='1.12' AND is_deleted = 0  AND project_id= -1;



UPDATE `rdos_stream_param_template`
SET `param` ='## 资源相关
parallelism.default=1
taskmanager.numberOfTaskSlots=1
jobmanager.memory.process.size=1g
taskmanager.memory.process.size=2g
##任务取消后保留hdfs上的checkpoint文件
execution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION',`gmt_modified` = now()
WHERE `task_type` = 1 AND `component_version` ='1.12' AND is_deleted = 0 AND project_id= -1;



UPDATE `rdos_stream_param_template`
SET `param` ='## 资源相关
parallelism.default=1
taskmanager.numberOfTaskSlots=1
jobmanager.memory.process.size=1g
taskmanager.memory.process.size=2g

## 时间相关
## 设置Flink时间选项，有ProcessingTime,EventTime,IngestionTime可选
## 默认为ProcessingTime
# pipeline.time-characteristic=EventTime

## Checkpoint相关
## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成
execution.checkpointing.interval=5min
## 状态恢复语义,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE
# execution.checkpointing.mode=EXACTLY_ONCE
##任务取消后保留hdfs上的checkpoint文件
execution.checkpointing.externalized-checkpoint-retention=RETAIN_ON_CANCELLATION

## Kerberos相关参数
# security.kerberos.login.contexts=Client,KafkaClient',`gmt_modified` = now()
WHERE `task_type` = 11 AND `component_version` ='1.12' AND is_deleted = 0  AND project_id= -1;
COMMIT;
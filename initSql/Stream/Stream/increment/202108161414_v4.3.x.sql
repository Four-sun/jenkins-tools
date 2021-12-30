BEGIN;
-- 任务环境参数模版
CREATE TABLE `rdos_stream_param_template`
(
    `id`                int(11) NOT NULL AUTO_INCREMENT,
    `task_type`         int(11) NOT NULL COMMENT '任务类型',
    `component_version` varchar(255) NOT NULL comment '组件版本',
    `param`             text         NOT NULL COMMENT '环境参数模版',
    `gmt_create`        datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
    `gmt_modified`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `is_deleted`        tinyint(1) NOT NULL DEFAULT '0' COMMENT '0正常 1逻辑删除',
    PRIMARY KEY (`id`)
) ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '任务环境参数模版表';

INSERT INTO `rdos_stream_param_template`(`task_type`, `component_version`, `param`, `gmt_create`, `gmt_modified`,
                                         `is_deleted`)
VALUES (0, '1.8', '## sql任务并发度设置
sql.env.parallelism=1

## 时间窗口类型（ProcessingTime或者EventTime）
time.characteristic=ProcessingTime

## 窗口提前触发时间，单位为秒(填写正整数即可)
# early.trigger=1

## ttl状态控制
## 最小过期时间,大于0的整数,如1d、1h(dD:天,hH:小时,mM:分钟,ss:秒)
# sql.ttl.min=1h
## 最大过期时间,大于0的整数,如2d、2h(dD:天,hH:小时,mM:分钟,ss:秒),需同时设置最小时间,且比最小时间大5分钟
# sql.ttl.max=2h

## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成
flink.checkpoint.interval=300000

## 设置checkpoint生成超时（以毫秒为单位），默认:10分钟
sql.checkpoint.timeout=600000

## 任务出现故障的时候一致性处理,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE
# sql.checkpoint.mode=EXACTLY_ONCE

## 最大并发生成 checkpoint 数量，默认：1 次
# sql.max.concurrent.checkpoints=1

## checkpoint 外存的清理动作
## true（任务结束之后删除checkpoint外部存储信息）
## false（任务结束之后保留checkpoint外部存储信息）
sql.checkpoint.cleanup.mode=false

## jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024

## taskManager 对应 slot的数量
slots=1

## logLevel: error,debug,info(默认),warn
logLevel=info

## Watermark发送周期，单位毫秒
# autoWatermarkInterval=200

## 设置输出缓冲区的最大刷新时间频率（毫秒）
# sql.buffer.timeout.millis=100

## 任务优先级, 值越小，优先级越高，范围:1-1000
job.priority=10

## kafka kerberos相关参数
## security.kerberos.login.use-ticket-cache=true
## security.kerberos.login.contexts=Client,KafkaClient
## security.kerberos.login.keytab=/opt/keytab/kafka.keytab
## security.kerberos.login.principal=kafka@HADOOP.COM
## zookeeper.sasl.service-name=zookeeper
## zookeeper.sasl.login-context-name=Client


## 异步访问维表是否开启连接池共享,开启则 1.一个tm上多个task共享该池, 2.一个tm上多个url相同的维表单/多个task共享该池 (默认false)
# async.side.clientShare=false
## 连接池中连接的个数,上面参数为true才生效(默认5)
# async.side.poolSize=5', now(), now(), 0),
       (1, '1.8', '## 任务优先级, 值越小，优先级越高，范围:1-1000
job.priority=10

## jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024

## taskManager数量
# container=1

## taskManager 对应 slot的数量
slots=1
', now(), now(), 0),
       (11, '1.8', '## per_job模式下jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## per_job模式下taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024
## per_job模式下启动的taskManager数量
# container=1

## per_job模式下每个taskManager 对应 slot的数量
slots=1

## 任务优先级, 范围:1-1000
job.priority=10

## checkpoint保存时间间隔
flink.checkpoint.interval=3600000

## kafka kerberos相关参数
## security.kerberos.login.use-ticket-cache=true
## security.kerberos.login.contexts=Client,KafkaClient
## security.kerberos.login.keytab=/opt/keytab/kafka.keytab
## security.kerberos.login.principal=kafka@HADOOP.COM
## zookeeper.sasl.service-name=zookeeper
## zookeeper.sasl.login-context-name=Client', now(), now(), 0),
       (0, '1.10', '## sql任务并发度设置
sql.env.parallelism=1

## 时间窗口类型（ProcessingTime或者EventTime）
time.characteristic=ProcessingTime

## 窗口提前触发时间，单位为秒(填写正整数即可)
# early.trigger=1

## ttl状态控制
## 最小过期时间,大于0的整数,如1d、1h(dD:天,hH:小时,mM:分钟,ss:秒)
# sql.ttl.min=1h
## 最大过期时间,大于0的整数,如2d、2h(dD:天,hH:小时,mM:分钟,ss:秒),需同时设置最小时间,且比最小时间大5分钟
# sql.ttl.max=2h

## 生成checkpoint时间间隔（以毫秒为单位），默认:5分钟,注释掉该选项会关闭checkpoint生成
flink.checkpoint.interval=300000

## 设置checkpoint生成超时（以毫秒为单位），默认:10分钟
sql.checkpoint.timeout=600000

## 任务出现故障的时候一致性处理,可选参数EXACTLY_ONCE,AT_LEAST_ONCE；默认为EXACTLY_ONCE
# sql.checkpoint.mode=EXACTLY_ONCE

## 最大并发生成 checkpoint 数量，默认：1 次
# sql.max.concurrent.checkpoints=1

## checkpoint 外存的清理动作
## true（任务结束之后删除checkpoint外部存储信息）
## false（任务结束之后保留checkpoint外部存储信息）
sql.checkpoint.cleanup.mode=false

## jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024

## taskManager 对应 slot的数量
slots=1

## logLevel: error,debug,info(默认),warn
logLevel=info

## Watermark发送周期，单位毫秒
# autoWatermarkInterval=200

## 设置输出缓冲区的最大刷新时间频率（毫秒）
# sql.buffer.timeout.millis=100

## 任务优先级, 值越小，优先级越高，范围:1-1000
job.priority=10

## kafka kerberos相关参数
## security.kerberos.login.use-ticket-cache=true
## security.kerberos.login.contexts=Client,KafkaClient
## security.kerberos.login.keytab=/opt/keytab/kafka.keytab
## security.kerberos.login.principal=kafka@HADOOP.COM
## zookeeper.sasl.service-name=zookeeper
## zookeeper.sasl.login-context-name=Client


## 异步访问维表是否开启连接池共享,开启则 1.一个tm上多个task共享该池, 2.一个tm上多个url相同的维表单/多个task共享该池 (默认false)
# async.side.clientShare=false
## 连接池中连接的个数,上面参数为true才生效(默认5)
# async.side.poolSize=5', now(), now(), 0),
       (1, '1.10', '## 任务优先级, 值越小，优先级越高，范围:1-1000
job.priority=10

## jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024

## taskManager数量
# container=1

## taskManager 对应 slot的数量
slots=1
', now(), now(), 0),
       (11, '1.10', '## per_job模式下jobManager配置的内存大小，默认1024（单位M）
# jobmanager.memory.mb=1024

## per_job模式下taskManager配置的内存大小，默认1024（单位M）
# taskmanager.memory.mb=1024
## per_job模式下启动的taskManager数量
# container=1

## per_job模式下每个taskManager 对应 slot的数量
slots=1

## 任务优先级, 范围:1-1000
job.priority=10

## checkpoint保存时间间隔
flink.checkpoint.interval=3600000

## kafka kerberos相关参数
## security.kerberos.login.use-ticket-cache=true
## security.kerberos.login.contexts=Client,KafkaClient
## security.kerberos.login.keytab=/opt/keytab/kafka.keytab
## security.kerberos.login.principal=kafka@HADOOP.COM
## zookeeper.sasl.service-name=zookeeper
## zookeeper.sasl.login-context-name=Client', now(), now(), 0),
       (0, '1.12', '## 资源相关
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
## 如：SELECT day, COUNT(DISTINCT user_id) FROM T GROUP BY day 如果 distinct key （即 user_id）的值分布稀疏，建议开启
# table.optimizer.distinct-agg.split.enabled=true

## Flink算子chaining开关。默认为true。排查性能问题时会暂时设置成false，但降低性能。
# pipeline.operator-chaining=true', now(), now(), 0),
       (1, '1.12', '## 资源相关
parallelism.default=1
taskmanager.numberOfTaskSlots=1
jobmanager.memory.process.size=1g
taskmanager.memory.process.size=2g', now(), now(), 0),
       (11, '1.12', '## 资源相关
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

## Kerberos相关参数
# security.kerberos.login.contexts=Client,KafkaClient', now(), now(), 0);
COMMIT;
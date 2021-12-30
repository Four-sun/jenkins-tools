FROM debian:buster-slim
LABEL maintainer="shaseng@dtstack.com"

ENV WORKSPACE=/opt/dtstack/DTSchedulex/EngineSql

COPY ./ ${WORKSPACE}/

WORKDIR ${WORKSPACE}/

RUN set -x && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib" > /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends default-mysql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
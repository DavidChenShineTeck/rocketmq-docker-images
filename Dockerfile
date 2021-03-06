#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This is maintained as the base image for namesrv and broker.
FROM centos:7

RUN yum install -y java-1.8.0-openjdk-headless unzip gettext nmap-ncat openssl\
 && yum clean all -y

ARG version

# Rocketmq version
ENV ROCKETMQ_VERSION 4.3.1

# Rocketmq home
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}

RUN mkdir -p \
 /data/logs \
 /data/store \
 /data/conf

# get the version
COPY version/rocketmq-${ROCKETMQ_VERSION}.zip /opt
RUN unzip /opt/rocketmq-${ROCKETMQ_VERSION}.zip -d ${ROCKETMQ_HOME} \
 && rm -rf /opt/rocketmq-${ROCKETMQ_VERSION}.zip \
 && rm -rf ${ROCKETMQ_HOME}/__MACOSX

WORKDIR  ${ROCKETMQ_HOME}

# add scripts
COPY scripts ${ROCKETMQ_HOME}/bin/

VOLUME /data

EXPOSE 10911
CMD  ["sh", "-c", ". ./play.sh; while sleep 10; do echo RocketMQ, GO ROCK; done"]

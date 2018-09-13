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

FROM nayuan/rocketmq:4.3.1

# add config
COPY config ${ROCKETMQ_HOME}/conf

EXPOSE 9876

RUN mv ${ROCKETMQ_HOME}/bin/runserver-customize.sh ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/mqnamesrv

CMD cd ${ROCKETMQ_HOME}/bin \
 && export JAVA_OPT=" -Duser.home=/data" \
 && if [ ! -d /data/logs ]; then mkdir /data/logs; fi \
  && if [ ! -d /data/store ]; then mkdir /data/store; fi \
  && if [ ! -d /data/conf ]; then mkdir /data/conf; fi \
  && if [ ! -f /data/conf/broker.properties ]; then cp ${ROCKETMQ_HOME}/conf/namesrv.properties /data/conf; fi \
 && sh mqnamesrv -c /data/conf/namesrv.properties
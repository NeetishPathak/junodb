#!/bin/bash
#  
#  Copyright 2023 PayPal Inc.
#  
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#  
#     http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  

cd /opt/juno

if [ ! -p ./log ]; then
    mkfifo ./log
fi

cp /opt/juno/config.toml /opt/juno/enabled_config.toml

if [ ! -z "$NUM_ZONES" ]; then
    sed -i s/NumZones.*$/NumZones=${NUM_ZONES}/g /opt/juno/enabled_config.toml
fi

if [ ! -z "$SS_HOSTS" ]; then
    sed -i s/SSHosts.*$/SSHosts=${SS_HOSTS}/g /opt/juno/enabled_config.toml
fi

"$@"

while true; do
    tail -f ./log
done


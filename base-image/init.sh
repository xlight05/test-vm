#!/bin/bash -e
# Copyright 2021 WSO2 Inc. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ----------------------------------------------------------------------------
# Installation script for the VM
# ----------------------------------------------------------------------------
set -e

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt-get install openjdk-8-jdk -y && sudo apt install gh
echo '#!/bin/sh' | sudo tee -a /etc/profile.d/10-perf-vm.sh
echo 'export PATH=$PATH:/base-image/utils/jtl-splitter/' | sudo tee -a /etc/profile.d/10-perf-vm.sh
echo 'export PATH=$PATH:/base-image/utils/payloads/' | sudo tee -a /etc/profile.d/10-perf-vm.sh
echo 'export PATH=$PATH:/base-image/utils/csv/' | sudo tee -a /etc/profile.d/10-perf-vm.sh
(cd /base-image/; ./configure-jmeter.sh -i /base-image -d)
chmod -R 777 /base-image
echo 'export PATH=$PATH:/base-image/' | sudo tee -a /etc/profile.d/10-perf-vm.sh
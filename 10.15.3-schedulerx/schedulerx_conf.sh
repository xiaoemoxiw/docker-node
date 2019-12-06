#!/bin/bash
cat > /opt/schedulerx2Agent/conf/agent.properties <<EOF
#create by yuxuewen
#email 8586826@qq.com
groupId=$ENV_GROUP_ID
endpoint=$ENV_ENDPOINT
namespace=$ENV_NAMESPACE
aliyunAccessKey=$ENV_ALIYUN_ACCESS_KEY
aliyunSecretKey=$ENV_ALIYUN_SECRET_KEY

EOF
MEM=$(awk '($1 == "MemTotal:"){print $2/1048576}' /proc/meminfo)
INT_MEN=${MEM%.*}
if [[ INT_MEN -gt 7 ]]; then
  /opt/schedulerx2Agent/bin/start-8g.sh
elif [[ INT_MEN -gt 3 ]]; then
  /opt/schedulerx2Agent/bin/start-4g.sh
else
  /opt/schedulerx2Agent/bin/start-2g.sh
fi



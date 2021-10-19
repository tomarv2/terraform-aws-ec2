#!/bin/bash

# Write ECS config file
cat << EOF > /etc/ecs/ecs.config
ECS_LOGFILE=/log/ecs-agent.log
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
ECS_LOGLEVEL=info
ECS_CLUSTER=${APP_TO_INSTALL}
EOF

## Install nfs-utils
yum update -y
yum install -y nmap
#yum install -y nfs-utils
#echo -e '<efs>.amazonaws.com:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' >> /etc/fstab
#mkdir /efs
#mount -a

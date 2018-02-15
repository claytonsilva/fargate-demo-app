#!/bin/bash
# tasks=($(aws ecs list-tasks  --cluster $CLUSTER --service $TASK | ./JSON.sh  -l | awk '{print $2}' |  cut  -d'/' -f 2 | cut -d'"' -f 1))
# for i  in "${tasks[@]}"
# do 
# 	aws ecs stop-task --region us-east-1 --cluster $CLUSTER --task $i
# 	sleep 120
# done
docker tag sample-app:latest $AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/sample-app:latest
docker push $AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/sample-app:latest

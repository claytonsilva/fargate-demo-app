#!/bin/bash
IMAGE="$AWS_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com\/$TASK:$TRAVIS_TAG"

docker tag $TASK:latest $IMAGE
docker push $IMAGE

cfg='task.json'

#role
# sed -i -- s/{{ROLE}}/$AWS_ROLE/g $cfg
# containerport
echo "change containerport"
sed -i -- s/{{CONTAINERPORT}}/$CONTAINERPORT/g $cfg
# image
echo "change $IMAGE"
sed -i -- s/{{IMAGE}}/$IMAGE/g $cfg
# task
echo "change task"
sed -i -- s/{{TASK}}/$TASK/g $cfg

# show file
more $cfg

aws ecs register-task-definition --cli-input-json file://$(pwd)/$cfg

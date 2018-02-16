#!/bin/bash
IMAGE_PREFIX="$AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com"

docker tag $TASK:latest $IMAGE_PREFIX/$TASK:$TRAVIS_TAG
docker push $IMAGE_PREFIX/$TASK:$TRAVIS_TAG

cfg='task.json'

cfg_tpl=$cfg.tpl

#region
sed -i -- s/{{REGION}}/$REGION/g $cfg_tpl
#role
sed -i -- s/{{AWS_ROLE}}/$AWS_ROLE/g $cfg_tpl
# containerport
sed -i -- s/{{CONTAINERPORT}}/$CONTAINERPORT/g $cfg_tpl
# image
sed -i -- s/{{IMAGE}}/"$IMAGE_PREFIX\/$TASK:$TRAVIS_TAG"/g $cfg_tpl
# task
sed -i -- s/{{TASK}}/$TASK/g $cfg_tpl
# taskgroup
sed -i -- s/{{TASKGROUP}}/$TASKGROUP/g $cfg_tpl

cp $cfg_tpl $cfg

#register new definition rev 
revision="$(aws ecs register-task-definition --region $REGION --cli-input-json file://$(pwd)/$cfg | jq '.taskDefinition.revision')"
#apply rolling update
aws ecs update-service --region $REGION --service $TASK --task-definition "$TASK:$revision"

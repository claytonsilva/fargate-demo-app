#!/bin/bash
IMAGE_PREFIX="$AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com"

docker tag $TASK:latest $IMAGE_PREFIX/$TASK:$TRAVIS_TAG
docker push $IMAGE_PREFIX/$TASK:$TRAVIS_TAG

ecs-deploy -r $REGION -c $TASK -n $TASK -i $IMAGE_PREFIX/$TASK:$TRAVIS_TAG

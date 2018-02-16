#waiting for pr https://github.com/silinternational/ecs-deploy/pull/129
#!/bin/bash
IMAGE_PREFIX="$AWS_ACCOUNT.dkr.ecr.$REGION.amazonaws.com"

docker tag $TASK:latest $IMAGE_PREFIX/$TASK:$TRAVIS_TAG
docker push $IMAGE_PREFIX/$TASK:$TRAVIS_TAG

ecs-deploy -c $CLUSTER -r $REGION -n $TASK -i $IMAGE_PREFIX/$TASK:$TRAVIS_TAG

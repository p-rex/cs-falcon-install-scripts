#!/bin/bash -x

#### Step 1 #########################
## Get falcon container sensor image. 
## If you have already pushed falcon container image to your ECR, just login to ECR and and go to step 2.


# Pull the latest falcon container image and set the image name to environmental variable.
export FALCON_CONTAINER_IMAGE=$(curl \
 https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
 | bash -s -- -t falcon-container -p $FALCON_PLATFORM_TYPE \
 | tail -n 1)

# Tag the sensor image.
docker tag $FALCON_CONTAINER_IMAGE $FALCON_CONTAINER_IMAGE_ECR

# login to ECR
aws ecr get-login-password --region $FALCON_ECR_REGION \
 | docker login --username AWS --password-stdin ${FALCON_AWS_ACCOUNT_ID}.dkr.ecr.${FALCON_ECR_REGION}.amazonaws.com

# Push the sensor image to ECR.
docker push $FALCON_CONTAINER_IMAGE_ECR



#### Step 2 #########################
# Run the task definition patching utilitiy

# Remove unnecessary parameters from the task definition.
export FALCON_TASK_DEF_JSON_STRING=$(cat $FALCON_TASK_DEF_PATH \
  | jq '. | del(.registeredAt,.registeredBy,.taskDefinitionArn,.compatibilities,.requiresAttributes,.revision,.status,nulls)')


# Set image pull token for ECR
export FALCON_IMAGE_PULL_TOKEN=$(echo "{\"auths\":{\"${FALCON_AWS_ACCOUNT_ID}.dkr.ecr.${FALCON_ECR_REGION}.amazonaws.com\":{\"auth\": \"$(echo AWS:$(aws ecr get-login-password)|base64 -w 0)\"}}}" | base64 -w 0) 


# Create task definition
docker run \
  --rm $FALCON_CONTAINER_IMAGE_ECR \
  -cid $FALCON_CID \
  -image $FALCON_CONTAINER_IMAGE_ECR \
  -pulltoken $FALCON_IMAGE_PULL_TOKEN \
  -ecs-spec "$FALCON_TASK_DEF_JSON_STRING" \
  --falconctl-opts "--tags=$FALCON_SENSOR_GROUPING_TAGS" \
  > taskdefinition_with_falcon.json



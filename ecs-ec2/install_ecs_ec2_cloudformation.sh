#!/bin/bash -x

#### Step 1 #########################
## Get falcon container sensor image. 
## If you have already pushed falcon container image to your ECR, just login to ECR and and go to step 2.


# Pull the latest falcon container image and set the image name to environmental variable.
export FALCON_SENSOR_IMAGE=$(curl \
 https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
 | bash -s -- -t falcon-sensor -p $FALCON_PLATFORM_TYPE \
 | tail -n 1)

# Tag the sensor image.
docker tag $FALCON_SENSOR_IMAGE $FALCON_SENSOR_IMAGE_ECR

# login to ECR
aws ecr get-login-password --region $FALCON_ECR_REGION \
 | docker login --username AWS --password-stdin ${FALCON_AWS_ACCOUNT_ID}.dkr.ecr.${FALCON_ECR_REGION}.amazonaws.com

# Push the sensor image to ECR.
docker push $FALCON_SENSOR_IMAGE_ECR



#### Step 2 #########################
# Run cloudfromation


# Get cloudformation template
cudl -LO \
https://raw.githubusercontent.com/CrowdStrike/aws-cloudformation-falcon-sensor-ecs/refs/heads/main/falcon-sensor-ecs-ec2/falcon-ecs-ec2-daemon.yaml


# Deploy sensor
  aws cloudformation deploy \
    --stack-name falcon-ecs-ec2-daemon-$ECS_EC2_CLUSTER_NAME \
    --template-file falcon-ecs-ec2-daemon.yaml \
    --parameter-overrides \
      "ECSClusterName=$ECS_EC2_CLUSTER_NAME" \
      "FalconCID=$FALCON_CID" \
      "FalconImagePath=$FALCON_SENSOR_IMAGE_ECR"
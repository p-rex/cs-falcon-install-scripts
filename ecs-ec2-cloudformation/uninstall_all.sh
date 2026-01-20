#!/bin/bash -x

# Download cleanup template
curl -LO https://raw.githubusercontent.com/CrowdStrike/aws-cloudformation-falcon-sensor-ecs/refs/heads/main/falcon-sensor-ecs-ec2/falcon-ecs-ec2-daemon-cleanup.yaml

# Delete the sensor daemon stack from the cluster.
aws cloudformation delete-stack \
    --stack-name falcon-ecs-ec2-daemon-$FALCON_ECS_EC2_CLUSTER_NAME


# After the daemon stack is removed, clean up the artifacts.
aws cloudformation deploy \
    --stack-name falcon-ecs-ec2-daemon-cleanup-$FALCON_ECS_EC2_CLUSTER_NAME \
    --template-file falcon-ecs-ec2-daemon-cleanup.yaml \
    --parameter-overrides \
        "ECSClusterName=$FALCON_ECS_EC2_CLUSTER_NAME" \
        "FalconImagePath=$FALCON_SENSOR_IMAGE_ECR"


# Delete the cleanup stack from the cluster.
aws cloudformation delete-stack \
    --stack-name falcon-ecs-ec2-daemon-cleanup-$FALCON_ECS_EC2_CLUSTER_NAME

# Delete cleanup template
rm falcon-ecs-ec2-daemon-cleanup.yaml
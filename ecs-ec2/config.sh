##------------------------------------------##
## General configuration
##------------------------------------------##

# CID  (Host setup and management > Sensor downloads)
export FALCON_CID=<CID_WITH_CHECKSUM>

# API Credential (Support and resources > API clients and keys)
export FALCON_CLIENT_ID=<CLIENT ID>
export FALCON_CLIENT_SECRET=<CLIENT_SECRET>


##------------------------------------------##
## Region
##------------------------------------------##

# US-1
# export FALCON_CLOUD_API=api.crowdstrike.com
# export FALCON_REGION=us-1
# export FALCON_CONTAINER_REGISTRY=registry.crowdstrike.com

# US-2
export FALCON_REGION=us-2
export FALCON_CLOUD_API=api.us-2.crowdstrike.com
export FALCON_CONTAINER_REGISTRY=registry.crowdstrike.com


##------------------------------------------##
## AWS Configuration
##------------------------------------------##
# AWS Account ID
export FALCON_AWS_ACCOUNT_ID=111111111111

# ECR Region
export FALCON_ECR_REGION=ap-northeast-1



# ECS Cluster name
export FALCON_ECS_EC2_CLUSTER_NAME=ecs_cluster


##------------------------------------------##
## container image configuration
##------------------------------------------##

# Platform type. x86_64 or aarch64
export FALCON_PLATFORM_TYPE=x86_64

# Set ECR repo and tag for the falcon sensor image. The image will be pushed to ECR.
export FALCON_SENSOR_IMAGE_ECR=<REPOSITORY>:<TAG>



##------------------------------------------##
## falcon sensor configuration
##------------------------------------------##

# Set falcon sensor tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_SENSOR_GROUPING_TAGS="ecs-ec2"

##------------------------------------------##
## General configuration
##------------------------------------------##

# CID
export FALCON_CID=<CID_WITH_CHECKSUM>

# API Credential
export FALCON_CLIENT_ID=<CLIENT ID>
export FALCON_CLIENT_SECRET=<CLIENT_SECRET>


# Region
# US-1
# export FALCON_CLOUD_API=api.crowdstrike.com
# export FALCON_REGION=us-1
# export FALCON_CONTAINER_REGISTRY=registry.crowdstrike.com

# US-2
export FALCON_REGION=us-2
export FALCON_CLOUD_API=api.us-2.crowdstrike.com
export FALCON_CONTAINER_REGISTRY=registry.crowdstrike.com



##------------------------------------------##
## container image configuration
##------------------------------------------##

# Set image name that you want to install falcon container sensor.
export FALCON_SOURCE_IMAGE=<REPOSITORY>:<TAG>

# Set image name that will be created after the falcon container sensor is installed.
export FALCON_TARGET_IMAGE=<REPOSITORY>:<TAG>


##------------------------------------------##
## falcon container sensor configuration
##------------------------------------------##

# Platform type. x86_64 or aarch64
export FALCON_PLATFORM_TYPE=x86_64

# Set serverless type. "ecsfargate" or "cloudrun"
export FALCON_PATCH_TYPE=ecsfargate

# Set falcon sensor tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_SENSOR_GROUPING_TAGS=""

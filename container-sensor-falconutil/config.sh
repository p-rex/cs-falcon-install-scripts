##------------------------------------------##
## CID
##------------------------------------------##
export FALCON_CID=<CID_WITH_CHECKSUM>

##------------------------------------------##
## API Key
##------------------------------------------##
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
## container image configuration
##------------------------------------------##

# Set source image name
export FALCON_SOURCE_IMAGE=<REPOSITORY>:<TAG>

# Set image name that has falcon container sensor
export FALCON_TARGET_IMAGE=<REPOSITORY>:<TAG>


##------------------------------------------##
## falcon container sensor configuration
##------------------------------------------##

# Set serverless type. "ecsfargate" or "cloudrun"
export FALCON_PATCH_TYPE=ecsfargate

# Set falcon sensor tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_SENSOR_GROUPING_TAGS=""

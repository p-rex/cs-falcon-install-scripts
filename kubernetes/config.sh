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
## Falcon sensor configuration
##------------------------------------------##

# set sensor mode. "bpf" or "kernel"
export FALCON_SENSOR_NODE_BACKEND=bpf

# Set sensor grouping tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_SENSOR_GROUPING_TAGS=""

# set true if GKE Autopilot
export FALCON_GKE_AUTOPILOT=false


##------------------------------------------##
## KAC configuration
##------------------------------------------##

# Set sensor grouping tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_KAC_GROUPING_TAGS="falconkac"


##------------------------------------------##
## IAR configuration
##------------------------------------------##
# set cluster name
export FALCON_K8S_CLUSTER_NAME=kubernetes-cluster

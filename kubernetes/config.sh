##------------------------------------------##
## CID
##------------------------------------------##
export FALCON_CID=<CID_WITH_CHECKSUM>

##------------------------------------------##
## API Credential
##------------------------------------------##
export FALCON_CLIENT_ID=<CLIENT_ID>
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
## Kubernetes configuration
##------------------------------------------##

# set sensor mode. "bpf" or "kernel"
export FALCON_SENSOR_NODE_BACKEND=bpf

# set falcon sensor tags. For multiple tags, use "\,". e.g., "tag1\,tag2\,tag3"
export FALCON_SENSOR_GROUPING_TAGS=""

# set true if GKE Autopilot
export FALCON_GKE_AUTOPILOT=false


##------------------------------------------##
## IAR configuration
##------------------------------------------##

# set cluster name
export FALCON_K8S_CLUSTER_NAME=kubernetes-cluster

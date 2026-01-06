#!/bin/bash -x


#######################################################
# Common settings for all falcon pods

# Add Helm repository
helm repo add crowdstrike https://crowdstrike.github.io/falcon-helm
helm repo update


# Get image pull token
# The script may display a Warning, and to avoid the warning line being set to an environment variable, the "tail" command is used to retrieve the last line.
export FALCON_IMAGE_PULL_TOKEN=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
 | bash -s -- --get-pull-token \
 | tail -n 1)


#######################################################
# Install falcon container injector

#Set Falcon repository
export FALCON_IMAGE_REPO=${FALCON_CONTAINER_REGISTRY}/falcon-container/${FALCON_REGION}/release/falcon-sensor

#Set image tag
export FALCON_IMAGE_TAG=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
 | bash -s -- -t falcon-container --list-tags \
 | jq -r '.tags[-1]')


# Create Namespace for injector
kubectl create namespace falcon-system

# Set label
# If you use k8s v1.22 or later, you can skip this line. For more details, search "NamespaceDefaultLabelName".
kubectl label namespace falcon-system kubernetes.io/metadata.name=falcon-system

# Install container sensor
# "container.image.pullSecrets.allNamespaces=true" creates k8s secret in all namespaces.
helm upgrade --install falcon-helm crowdstrike/falcon-sensor \
  --set node.enabled=false \
  --set container.enabled=true \
  --set falcon.cid="$FALCON_CID" \
  --set container.image.repository="$FALCON_IMAGE_REPO" \
  --set container.image.tag="$FALCON_IMAGE_TAG" \
  --set container.image.pullSecrets.enable=true \
  --set container.image.pullSecrets.registryConfigJSON="$FALCON_IMAGE_PULL_TOKEN" \
  --set container.image.pullSecrets.allNamespaces=true \
  --set falcon.tags=$FALCON_SENSOR_GROUPING_TAGS \
  -n falcon-system


#######################################################
# Install KAC

# Set Falcon repository
export FALCON_KAC_IMAGE_REPO=${FALCON_CONTAINER_REGISTRY}/falcon-kac/${FALCON_REGION}/release/falcon-kac

# Set image tag
export FALCON_KAC_IMAGE_TAG=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s | bash -s -- -t falcon-kac --list-tags | jq -r '.tags[-1]')

helm install falcon-kac crowdstrike/falcon-kac \
  -n falcon-kac --create-namespace \
  --set falcon.cid=$FALCON_CID \
  --set image.repository=$FALCON_KAC_IMAGE_REPO \
  --set image.tag=$FALCON_KAC_IMAGE_TAG \
  --set falcon.tags=$FALCON_KAC_GROUPING_TAGS \
  --set image.registryConfigJSON=$FALCON_IMAGE_PULL_TOKEN


  #######################################################
# Install IAR

# Set Falcon repositor
export FALCON_IAR_IMAGE_REPO=${FALCON_CONTAINER_REGISTRY}/falcon-imageanalyzer/${FALCON_REGION}/release/falcon-imageanalyzer

# Set image tag
export FALCON_IAR_IMAGE_TAG=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s | bash -s -- -t falcon-imageanalyzer --list-tags | jq -r '.tags[-1]')

# Install as Watcher mode
helm upgrade --install falcon-image-analyzer crowdstrike/falcon-image-analyzer \
  -n falcon-image-analyzer --create-namespace \
  --set crowdstrikeConfig.cid=$FALCON_CID \
  --set crowdstrikeConfig.clientID=$FALCON_CLIENT_ID \
  --set crowdstrikeConfig.clientSecret=$FALCON_CLIENT_SECRET \
  --set image.repository=$FALCON_IAR_IMAGE_REPO \
  --set image.tag=$FALCON_IAR_IMAGE_TAG \
  --set image.registryConfigJSON=$FALCON_IMAGE_PULL_TOKEN \
  --set deployment.enabled=true \
  --set daemonset.enabled=false \
  --set crowdstrikeConfig.clusterName=$FALCON_K8S_CLUSTER_NAME
  

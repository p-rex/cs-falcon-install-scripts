#!/bin/bash -x

# Create config.json for ACR access
TOKEN=$(az acr login --name $FALCON_ACR_NAME --expose-token --output tsv --query accessToken)

AUTH=$(echo -n "00000000-0000-0000-0000-000000000000:$TOKEN" | base64 -w 0)

cat > $FALCON_ACR_CONFIG_JSON_PATH << EOF
{
  "auths": {
    "$FALCON_ACR_NAME": {
      "auth": "$AUTH"
    }
  }
}
EOF



# Pull the latest falcon container image and set the image name to environmental variable.
export FALCON_CONTAINER_IMAGE=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/\
containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
| bash -s -- -t falcon-container -p $FALCON_PLATFORM_TYPE \
| tail -n 1)


# Create targate image
docker run --user 0:0 \
  -v $FALCON_ACR_CONFIG_JSON_PATH:/root/.docker/config.json \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --rm $FALCON_CONTAINER_IMAGE \
  falconutil patch-image \
  --image-pull-policy IfNotPresent \
  --cloud-service ACA \
  --source-image-uri $FALCON_SOURCE_IMAGE \
  --target-image-uri $FALCON_TARGET_IMAGE \
  --falcon-image-uri $FALCON_CONTAINER_IMAGE \
  --cid $FALCON_CID \
  --falconctl-opts \"--tags=$FALCON_SENSOR_GROUPING_TAGS\" \
  --resource-group $FALCON_AZR_RESOURCE_GRP_NAME \
  --subscription $FALCON_AZR_SUBSCRIPTION_ID


#!/bin/bash -x


# Pull source image
docker pull $FALCON_SOURCE_IMAGE


# Pull the latest falcon container image and set the image name to environmental variable.
export FALCON_CONTAINER_IMAGE=$(curl https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/\
containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh -s \
| bash -s -- -t falcon-container | tail -n 1)



# Create targate image
docker run --user 0:0 \
-v /var/run/docker.sock:/var/run/docker.sock \
--rm $FALCON_CONTAINER_IMAGE \
falconutil patch-image $FALCON_PATCH_TYPE \
--source-image-uri $FALCON_SOURCE_IMAGE \
--target-image-uri $FALCON_TARGET_IMAGE \
--falcon-image-uri $FALCON_CONTAINER_IMAGE \
--cid $FALCON_CID \
--falconctl-opts "--tags=$FALCON_SENSOR_GROUPING_TAGS" \
--image-pull-policy IfNotPresent \
--container $FALCON_CONTAINER_NAME



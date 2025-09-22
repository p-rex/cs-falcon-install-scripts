# About this script
- This script installs falcon container sensor to your container image using falconuti.



# Prerequisites
Please install these commands before run the script.
- curl
- jq
- docker

  

# Usage

1. Create API credential with the following scope.
```
Falcon Container Image : Read
Falcon Images Download : Read
```


2. Download **config.sh**.
```
curl -LO \
https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/container-sensor-falconutil-with-container-name/config.sh
```

3. Edit **config.sh**.

4. Set environmental variables.
```
source config.sh
```

5. docker login.  
Please login to your container registry so that you can run `docker pull` command in the next step.


6. Install sensor.
```
curl -s \
https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/container-sensor-falconutil-with-container-name/install_container_sensor_falconutil_with_container_name.sh \
| bash
```

7. Push image.  
Push created image to your container registry.


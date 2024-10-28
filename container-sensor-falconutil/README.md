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
Falcon Container Image : Read, Write
Falcon Images Download : Read
```





1. Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/container-sensor-falconutil/config.sh
```

2. Edit **config.sh**.

3. Set environmental variables.
```
source config.sh
```


4. Install sensor.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/container-sensor-falconutil/falconuti_install.sh \
| bash
```

5. Put image  
Put created image to your container registry.


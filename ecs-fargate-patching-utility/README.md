# About this script
- This script installs falcon container sensor to ECS Fargate using patching utility.

# Prerequisites
Please install these commands before run the script.
- curl
- jq
- docker

  

# Usage

1. Download **task definition json** from AWS.

2. Create API credential with the following scope in the Falcon console.
```
Falcon Container Image : Read
Falcon Images Download : Read
```

3. Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-fargate-patching-utility/config.sh
```

4. Edit **config.sh**.  


5. Set environmental variables.
```
source config.sh
```

6. Run script.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-fargate-patching-utility/install_container_sensor_patching_utility.sh \
 | bash
```

7. A file named **taskdefinition_with_falcon.json** will be created. Apply it to your ECS Task.
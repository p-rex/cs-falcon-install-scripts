# About this script
- This script installs falcon container sensor to ECS Fargate using patching utility.

# Prerequisites
Please install these commands before run the script.
- curl
- jq
- docker
- aws cli

  

# Usage
1. Create ECR repository for falcon container sensor.

2. Download **task definition json** from ECS task.

3. Create API credential with the following scope in the Falcon console. (Support and resources > API clients and keys)
```
Falcon Container Image : Read
Falcon Images Download : Read
```

4. Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-fargate-patching-utility/config.sh
```

5. Edit **config.sh**.  


6. Set environmental variables.
```
source config.sh
```

7. Run script.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-fargate-patching-utility/install_container_sensor_patching_utility.sh \
 | bash
```

8. **taskdefinition_with_falcon.json** is created in the working dir. Apply it to your ECS Task.
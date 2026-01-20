# About this script
- This script installs falcon container sensor to ECS EC2 using CloudFormaion.
- CloudFormation Template is here [https://github.com/CrowdStrike/aws-cloudformation-falcon-sensor-ecs](https://github.com/CrowdStrike/aws-cloudformation-falcon-sensor-ecs)

# Prerequisites
Please install these commands before run the script.
- curl
- jq
- docker
- aws cli

  

# Usage
1. Get Falcon CID from Falcon console.  
Host setup and management > Sensor downloads


2. Create API credential with the following scope in the Falcon console.  
Support and resources > API clients and keys
```
Falcon Container Image : Read
Falcon Images Download : Read
```


3. Create ECR repository for falcon sensor.

4. Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-ec2/config.sh
```

5. Edit **config.sh**.  


6. Set environmental variables.
```
source config.sh
```

7. Run script.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-ec2/install_ecs_ec2_cloudformation.sh \
 | bash
```


# Uninstall the sensor
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/ecs-ec2/uninstall_all.sh \
 | bash
```
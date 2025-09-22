# About this script
- This script is for EKS Fargate.
- This script installs Falcon sensor, KAC and IAR.
- Falcon sensor is installed as sidecar.
- IAC is installed as Watcher mode.
- Container images are pulled from CrowdStrike repository.

> [!Important]
> If the container images you want to protect are in ECR, install OIDC Controller and assign IAM role to the Service Account for Falcon Injector.
> https://github.com/CrowdStrike/Container-Security/blob/main/aws-eks/eks-implementation-guide.md

# Prerequisites
Please install these commands before run the script.
- curl
- jq
- helm
- kubectl
- eksctl



# Usage

1. Create API key with the following scope.
```
Falcon Container Image : Read, Write
Falcon Images Download : Read
Falcon Container CLI  : Write
```
> *Falcon Container CLI* is only for IAR.




2. Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/eks-fargate/config.sh
```

3. Edit **config.sh**.

4. Set environmental variables.
```
source config.sh
```


5. Install sensors.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/eks-fargate/install_eks_fargate.sh | bash
```


## Uninstall
Uninstall injector, KAC, IAR, and falcon-helm.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/eks-fargate/uninstall_all.sh | bash
```

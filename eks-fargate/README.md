# About this script
- This script is for EKS Fargate.
- This script installs Falcon sensor injector, KAC and IAR.
- Falcon sensor is installed as sidecar.
- IAC is installed as Watcher mode.
- Container images are pulled from CrowdStrike repository.


# Prerequisites
Please install these commands before run the script.
- curl
- jq
- helm
- kubectl
- eksctl

> [!Important]
> If your container images are in ECR, install OIDC Controller and assign IAM role to the Service Account for Falcon Injector.
> Look at Step 3 and 6 on this page.
> https://github.com/CrowdStrike/Container-Security/blob/main/aws-eks/eks-implementation-guide.md


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


5. Install Falcon container injector.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/eks-fargate/install_eks_fargate.sh | bash
```

> [!Important]
> At this point, **Falcon container injector** starts up, and the **Falcon container sensor** is not running. When a new POD is created, the Falcon sensor will be injected into the pod as a sidecar.


6. Deploy new pod  
Falcon container sensor is injected into the pod as a sidecar.


## Uninstall
Uninstall injector, KAC, IAR, and falcon-helm.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/eks-fargate/uninstall_all.sh | bash
```

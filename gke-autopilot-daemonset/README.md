# About this script
- This script is for GKE Autopilot.
- This script installs Falcon sensor, KAC and IAR.
- Falcon sensor is installed as Daemonset.
- IAC is installed as Watcher mode.
- Container images are pulled from CrowdStrike repository.


# Prerequisites
Please install these commands before run the script.
- curl
- jq
- helm
- kubectl


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
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_daemonset/config.sh
```

3. Edit **config.sh**.

4. Set environmental variables.
```
source config.sh
```


5. Install sensors.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_daemonset/install_daemonset.sh | bash
```

> [!IMPORTANT]
> The **AllowlistSynchronizer** may take some time to start up, which could cause the sensor installation to fail.  
> (This script does not have a status check to keep the script simple.)  
> If the sensor installation fails, please verify the **AllowlistSynchronizer** status with the following commands, and then run the `helm install falcon-sensor ~` command again (which is in the script).
```bash
# Ensure the AllowlistSynchronizer is running:
kubectl get allowlistsynchronizers

# Ensure the AllowlistSynchronizer has fetched the WorkloadAllowlist:
kubectl get workloadallowlists
```

# Uninstall
Uninstall Sensor, KAC, IAR, and falcon-helm.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_daemonset/uninstall_all.sh | bash
```

# About this script
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
- docker

> If these commands are set as aliases (e.g., "alias kubectl='microk8s kubectl'"), the script will not work. In that case, paste the script into the terminal and run it.
  

# Usage

Create API key with the following scope.
```
Falcon Container Image : Read, Write
Falcon Images Download : Read
Falcon Container CLI  : Write
```
> *Falcon Container CLI* is only for IAR.




Download **config.sh**.
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes/config.sh
```

Edit **config.sh**.

Set environmental variables.
```
source config.sh
```


Install sensors.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes/sensor-install-daemonset.sh | bash
```


# Uninstall
Uninstall Sensor, KAC, IAR, and falcon-helm.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes/uninstall_all.sh | bash
```

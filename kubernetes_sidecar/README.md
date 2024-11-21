# About this script
- This script installs Falcon sensor, KAC and IAR.
- Falcon sensor is installed as sidecar.
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
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_sidecar/config.sh
```

3. Edit **config.sh**.

4. Set environmental variables.
```
source config.sh
```


5. Install sensors.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_sidecar/install_sidecar.sh | bash
```


## Uninstall
Uninstall injector, KAC, IAR, and falcon-helm.
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes_sidecar/uninstall_all.sh | bash
```

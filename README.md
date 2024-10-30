# cs-falcon-install-scripts

CrowdStrike Falcon Sensorをコンテナ環境にインストールするためのスクリプト集です。

# コンセプト
### 1. できる限り最短の手順
最短の手順にするために、コンテナイメージは全てCrowdStrikeのリポジトリから直接取得する方法にしています。  
「一旦ECRに置きたい」「イメージタグを変更したい」といった場合は、本スクリプトの内容を参考にカスタマイズしてください。  
なお、イメージ取得/イメージタグ取得/認証情報取得には全て[falcon-container-sensor-pullスクリプト](https://github.com/CrowdStrike/falcon-scripts/tree/main/bash/containers/falcon-container-sensor-pull) を活用しています。

### 2. 必要な設定は全て環境変数に入れる
必要な設定は全て事前に **config.sh** で指定するようにしています。これにより可変の部分が分かりやすくなっています。

### 3. if、forなどの制御構文やfunctionは使用しない
制御構文を使用していないため、コマンドを並べただけになっています。  
これにより、そのまま手順として見ていただくことができますし、必要な部分のみコピー&ペーストでの使用もできるようになっています。


# 使用方法
各環境ごとに以下の3つのファイルを用意しています。
シェルスクリプトとして実行しても構いませんし、必要な部分をターミナルにコピー&ペーストしても構いません。

#### config.sh
環境変数の設定です。まず初めにこのファイルに環境変数を設定し、ターミナルに読み込ませてください。

#### install_*.sh
インストール用のスクリプトです。

#### uninstall_all.sh
アンインストール用のスクリプトです。


# 注意点
- 各スクリプトのREADMEに記載のアプリケーションをインストールしておいてください。(Docker等)
- kubectlを使用しますので、コンテキスト（アクセス先）が正しく対象のk8s clusterとなっているか事前にご確認ください。


# 対応環境

## AWS
- EKS EC2
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes)
- EKS Fargate
    - [Sidecar](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/eks-fargate)
- ECS Fargate
    - [falconutil](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/container-sensor-falconutil)
    - Patching Utility - TBD
- ECS EC2
    - TBD


## Google Cloud
- GKE Standard
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes)
- GKE Autopilot
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes)
- Cloud Run
    - TBD

## Azure
TBD

## On-premise k8s
- Microk8s
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes)

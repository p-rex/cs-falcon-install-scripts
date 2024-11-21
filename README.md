# cs-falcon-install-scripts

CrowdStrike Falcon Sensorをコンテナ環境にインストールするためのスクリプト集です。

# コンセプト
### 1. 関連ツールは全てインストール
Falcon sensorだけではなく、KAC、IARもインストールできます。不要な部分は削除してご利用ください。

### 2. できる限り最短の手順
最短の手順にするために、コンテナイメージは全てCrowdStrikeのリポジトリから最新バージョンを直接取得する方法にしています。  
「一旦ECRに置きたい」「古いバージョンを使用したい」といった場合は、本スクリプトの内容を参考にカスタマイズしてください。  
なお、イメージ取得/イメージタグ取得/認証情報取得には全て[falcon-container-sensor-pullスクリプト](https://github.com/CrowdStrike/falcon-scripts/tree/main/bash/containers/falcon-container-sensor-pull) を活用しています。

### 3. 必要な設定は全て事前に環境変数に指定
必要な設定は全て **config.sh** で指定するようにしています。これにより可変の部分が分かりやすくなっています。

### 4. 制御構文は使用しない
if、forなどの制御構文を使用しておらず、コマンドを並べただけになっています。  
これにより、そのまま手順としても見ていただくことができますし、必要な部分のみコピー&ペーストでの使用もできるようになっています。  
エラー処理も含まれていません。しかし失敗したとしてもインストールに失敗するだけです。やり直す場合は、一旦uninstall_all.shを実行してください。


# 使用方法
各環境ごとに以下の3つのファイルを用意しています。
シェルスクリプトとして実行しても構いませんし、必要な部分をターミナルにコピー&ペーストしても構いません。

#### <ins>config.sh</ins>
環境変数の設定です。まず初めにこのファイルで環境変数を指定し、shellに読み込ませてください。

#### <ins>install_*.sh</ins>
インストール用のスクリプトです。

#### <ins>uninstall_all.sh</ins>
アンインストール用のスクリプトです。


### 注意点
- 各スクリプトのREADMEに記載のあるアプリケーションを事前にインストールしておいてください(helm等)。CloudShellの利用が良いです。
- kubectlを使用しますので、コンテキスト（アクセス先）が正しく対象のk8s clusterとなっているかを事前にご確認ください。


# 対応環境

## AWS
- EKS EC2
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- EKS Fargate
    - [Sidecar](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/eks-fargate)
- ECS Fargate
    - [falconutil](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/container-sensor-falconutil)
    - Patching Utility - TBD
- ECS EC2
    - TBD


## Google Cloud
- GKE Standard
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- GKE Autopilot
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- Cloud Run
    - TBD

## Azure
- AKS
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)

## On-premise k8s
- Microk8s
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
    - [Sidecar](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_sidecar)

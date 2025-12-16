# cs-falcon-install-scripts

CrowdStrike Falcon Sensorをコンテナ環境にインストールするためのスクリプト集です。  
本資料は参考資料です。正式なインストール手順については、管理コンソールのマニュアルをご確認ください。


# コンセプト
### 1. 関連ツールは全てインストール
Falcon sensorだけではなく、KAC、IARもインストールできます。不要な部分は削除してご利用ください。

### 2. できる限り最短の手順
最短の手順にするために、コンテナイメージは全てCrowdStrikeのリポジトリから最新バージョンを直接取得する方法にしています。  
「一旦ECRに置く」「古いバージョンを使用する」といった場合は、本スクリプトの内容を参考にカスタマイズしてください。  
なお、イメージ取得/イメージタグ取得/認証情報取得には全て[falcon-container-sensor-pull](https://github.com/CrowdStrike/falcon-scripts/tree/main/bash/containers/falcon-container-sensor-pull) を利用しています。

> [!Important]
> 本スクリプトでは、CrowdStrikeリポジトリから直接コンテナイメージ取得するためにAPIキーを使用しています。
> しかし、APIキーを多くの方に共有するのは避けてください。誤ってAPIキーに多くの権限を与えてしまうと、そこがセキュリティホールになります。
> 多数の部署で CrowdStrikeのコンテナイメージを利用する場合は、一旦ECR, GAR, ACRなどにイメージをPushし、それを共有されることをお勧めします。

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
環境変数は全て **FALCON** から始まるようにしています。`env | grep FALCON` で設定確認しやすくするためです。

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
    - [Patching Utility](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/ecs-fargate-patching-utility)
- ECS EC2
    - TBD


## Google Cloud
- GKE Standard
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- GKE Autopilot
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- Cloud Run
    - [falconutil](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/container-sensor-falconutil-with-container-name)

## Azure
- AKS
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
- Azure Container Instances
    - [falconutil](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/azure-container-instances)
- Azure Container Apps
    - [falconutil](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/azure-container-apps)

## On-premise k8s
- MicroK8s
    - [Daemonset](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_daemonset)
    - [Sidecar](https://github.com/p-rex/cs-falcon-install-scripts/tree/main/kubernetes_sidecar)
> MicroK8sでは **microk8s kubectl**, **microk8s helm** コマンドを使用しますので、スクリプトを書き換えるか、aliasを作成してスクリプトをc&pしてください。


# 参考情報
## falcon-container-sensor-pull 使用方法
[falcon-container-sensor-pull](https://github.com/CrowdStrike/falcon-scripts/tree/main/bash/containers/falcon-container-sensor-pull) の基本的な使用方法を説明します。

### <ins>事前準備</ins>
以下のScopeのAPIクライアント/キーを作成します。
```
Falcon Container Image : Read
Falcon Images Download : Read
```

作成したAPIクライアント/キーを環境変数を設定します。
```
export FALCON_CLIENT_ID=<CLIENT ID>
export FALCON_CLIENT_SECRET=<CLIENT_SECRET>
```

### <ins>重要なオプション</ins>
#### -t
イメージの種類を指定します。

| 種類 | オプション |  
| ---- | ---- |
| ノードセンサー | falcon-sensor |
| コンテナセンサー　| falcon-container |
| Kubernetes Admission Controller(KAC) | falcon-kac |
| イメージアナライザー | falcon-imageanalyzer |

後述のコマンド例では `falcon-sensor` の例のみ記載しております。

#### --list-tags
イメージタグ一覧（全バージョンのタグ）を取得します。

#### -p
platformの指定です。
マルチアーキテクチャ対応のイメージをpullする場合は、 `x86_64` または `aarch64` を指定します。  


#### -v
バージョン指定です。コンテナイメージのタグを指定します。


### <ins>コマンド例</ins>
#### イメージタグ一覧の取得
```
curl -s https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh \
 | bash -s -- --list-tags -t falcon-sensor
```


#### 最新イメージをpull
```
curl -s https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh \
 | bash -s -- -t falcon-sensor -p x86_64
```


#### 指定バージョンのイメージをpull ( -vでイメージタグを指定してください)
```
curl -s https://raw.githubusercontent.com/CrowdStrike/falcon-scripts/main/bash/containers/falcon-container-sensor-pull/falcon-container-sensor-pull.sh \
 | bash -s -- -t falcon-sensor -p x86_64 -v 7.24.0-17706-1.falcon-linux.Release.US-1
```
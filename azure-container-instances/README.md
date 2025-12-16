# 概要
- このスクリプトは**Azure container instances**用です。
- falconutilを用いて、falcon container sensorをコンテナイメージに組み込みます。

  


# 前提条件
以下のコマンドが必要です。 
- curl
- jq
- docker
- azure cli

  

# 使用方法

1. 以下のスコープを持ったAPIキーを作成します。(Support and resources > API clients and keys)
```
Falcon Container Image : Read
Falcon Images Download : Read
```

2.  **config.sh** をダウンロードします。
```
curl -LO https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/azure-container-instances/config.sh
```

3. **config.sh** を編集します。

4. 環境変数を読み込みます。
```
source config.sh
```

5. センサーインストール。
```
curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/azure-container-instances/install_aci.sh \
| bash
```

6. 作成されたコンテナイメージをACRにPushしてご利用ください。
# docker-images-vnc-os

- os（Ubuntu） の Docker イメージ
- VNC と noVNC を使用してリモートデスクトップ環境を提供
    - GUIアプリケーションにブラウザを介してアクセスできる

[Docker Hub](https://hub.docker.com/r/takeshitayy/vnc-os/tags)

## 開発について

```
docker-images-vnc-os
|-- scripts
|   |-- tests                    ... dokcer コンテナ でのテスト関連
|   |   |-- access               ... 対象の dokcer コンテナ へのアクセス
|   |   |   `-- ubuntu22.04.ps1
|   |   |-- down.ps1             ... compose.yml に定義したコンテナを削除
|   |   |-- start.ps1            ... compose.yml に定義したコンテナを起動
|   |   `-- stop.ps1             ... compose.yml に定義したコンテナを停止　　　
|   |-- ubuntu                   ... docker images のビルド, プッシュ関連
|   |   |-- 22.04
|   |   |   |-- __config.ps1
|   |   |   |-- build.ps1
|   |   |   `-- push.ps1
|   |   `-- __config.ps1
|   `-- __config.ps1
|-- tests                        ... テストするときの コンテナの定義
|   |-- .env
|   `-- compose.yml
|-- ubuntu                       ... docker イメージ の定義
|   |-- 22.04
|   |   `-- Dockerfile
|   `-- vnc
|       `-- start.sh             ... コンテナでの vnc の起動スクリプト
`-- README.md
```

### docker イメージ

#### 設定

- docker イメージ の名称の設定

    ./scripts/__config.ps1 で行う
    ```
    $global:repositoryName = "takeshitayy/vnc-os"
    ```
    - 設定したものが Docker Hub のリポジトリ名になる

#### 操作

- ビルド
    ```
    ./scripts/ubuntu/22.04/build.ps1
    ```

    ローカルに docker イメージ がビルドされる
    - イメージ名は `takeshitayy/vnc-os` になる
    - タグは、`ubuntu22.04`, `ubuntu22.04_yyyymm` になる

- プッシュ
    ```
    ./scripts/ubuntu/22.04/push.ps1
    ```

    ローカルの docker イメージ が Docker Hub にプッシュされる
    - イメージ名は `takeshitayy/vnc-os` になる
    - タグは、`ubuntu22.04`, `ubuntu22.04_yyyymm` になる

### コンテナでのテスト

#### 設定

- コンテナ群 の名称の設定

    ./tests/.env で行う
    ```
    COMPOSE_PROJECT_NAME=takeshitayy_vnc-os
    ```
    - 起動したコンテナ群の名称になる

#### テストの実施

1. `./tests/compose.yml` にテスト対象のコンテナを定義
    ```
    services:
    ubuntu22.04:
        image: takeshitayy/vnc-os:ubuntu22.04
        ports:
        - 1080:6080
    ```
    - ローカルにビルドされた docker イメージ を指定する
    - コンテナを複数定義する場合は port の `1080` を重複しないように定義する

1. コンテナ の起動
    ```
    ./scripts/tests/start.ps1
    ```

    - `./tests/compose.yml` に定義したすべてのコンテナが起動

1. 動作を確認する
    - ブラウザ で GUI にアクセスして動作を確認する

        http://localhost:1080/vnc.html?resize=remote&clip=true

        - ./tests/compose.yml` に設定した port でアクセスする

    - コンテナに接続して動作を確認する

        ```
        ./scripts/tests/access/ubuntu22.04.ps1
        ```

1. コンテナを停止する
    ```
    ./scripts/tests/stop.ps1
    ```

1. コンテナを削除する
    ```
    ./scripts/tests/down.ps1
    ```

### 新しいイメージの追加

1. Dockerfile の追加

    ./`distribution`/`version`/Dockerfile を追加する

1. ビルド, プッシュ スクリプトの追加

    ./scripts/`distribution`/`version`/ にスクリプトを追加する
    - ./scripts/`distribution`/__config.ps1 に distribution の情報を設定
    - ./scripts/`distribution`/`version`/__config.ps1 に version の情報を設定

1. テスト用のコンテナの定義

    `./tests/compose.yml` にテスト対象のコンテナを定義
    ```
    services:
    {distribution}{version}:
        image: takeshitayy/vnc-os:{distribution}{version}
        ports:
        - {任意のポート}:6080
    ```

1. コンテナアクセス用の スクリプトの追加

    ./scripts/tests/access/`distribution``version`.ps1 を追加する

# amsl_ros_docker_ws

## 概要
本リポジトリは、ROS (1/2)をDockerコンテナ上で開発・実行するための環境を提供する。[Setup ROS 2 with VSCode and Docker](https://docs.ros.org/en/rolling/How-To-Guides/Setup-ROS-2-with-VSCode-and-Docker-Container.html)を参考にして作成した、各ディストリビューション向けの`Dockerfile`や`docker-compose.yml`を用意してある。GUIにも対応し、rviz等OpenGLアプリケーションも実行できる。vscodeユーザであれば、そのまま`devcontainer`として利用することもできる。ホストのディレクトリのマウントやDocker volumeの活用により、ホストの再起動後などにも速やかに環境を復旧できる。

## 動作確認済環境
- Ubuntu 20.04 (x86_64, NVIDIA GPU)

## 依存
- make
- docker
- nvidia-container-runtime (必要な場合)

## 事前準備
ディレクトリ構成を次のようにしておく。`<ROS workspace>`は任意のディレクトリ。
```
<ROS workspace>
└─ src
  ├─ package_1
  ├─ package_2
  ...
```

## セットアップ
```
git clone git@github.com:amslabtech/amsl_ros_docker_ws.git
cd amsl_ros_docker_ws
make install TARGET_WS=<ROS_workspace> ROS_DISTRO=noetic NVIDIA_DOCKER=false
```

セットアップ後、ディレクトリ構成は以下のようになる。
```
<ROS workspace>
├─ cache
│ └─ ROS_DISTRO
│   ├─ build
│   ├─ install
│   └─ log
└─ src
  ├─ .devcontainer
  │ ├─ devcontainer.json
  │ ├─ Dockerfile
  │ └─ docker-compose.yml
  ├─ package_1
  ├─ package_2
  ...
```

## 使い方
### devcontainerの使い方
`.devcontainer`のあるディレクトリ(`<ROS workspace>/src`)で`code .`すると、vscode起動時に`Reopen in container`のポップアップが表示される。それを実行すれば、Docker imageをビルドし、コンテナを実行、vscodeからコンテナに接続できる。

### docker composeの使い方
`<ROS workspace>/src`で`docker compose -f .devcontainer/docker-compose.yml up`すれば上記と同様のコンテナが立ち上がる。


## パッケージのビルド
上記のように起動したコンテナ内では、パッケージのビルドに[`colcon`](https://colcon.readthedocs.io/en/released/index.html)を使う。`colcon`はcatkinパッケージでもamentパッケージでもpure cmakeパッケージでも自動判別して適切にビルドしてくれる。そのため対象のパッケージがROS 1でもROS 2でも同じコマンドでビルドできる。コンテナ内では`cb`というエイリアスが定義されているので、活用すると良い。
なお、`colcon`コマンドは`<ROS workspace>`ディレクトリで実行する必要がある。

代表的なコマンドを以下に示す。
- `cb`
  - ワークスペース全体をビルド
- `cb --packages-select package_1`
  - `package_1`をビルド
- `colcon test --pacakges-select package_1`
  - `package_1`のテストを実行

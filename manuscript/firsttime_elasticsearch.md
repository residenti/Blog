# はじめてのElastic Search

## Elastic Searchの概要

[Elastic Search](https://www.elastic.co/jp/products/elasticsearch)はElastic社が開発しているOSSの全文検索エンジン(\*1)で、検索エンジン界隈では1番の人気を誇る。
内部では[Apache Lucene(アパッチ ルシーン)](https://ja.wikipedia.org/wiki/Apache_Lucene)が提供する超高速全文検索をフル活用していて、スケーラブル，スキーマレス，マルチテナントを特長としている。
RESTでアクセスができ、最近SQLも使えるようになったらしい。

全文検索の他、リアルタイムデータ分析、ログ解析などが行える関連製品があり、それらはElastic Stackと呼ばれている。

| 製品名         | 機能            |
|:--------------|:-------------- |
| Elasticsearch | ドキュメントの保存/検索 |
| Kibana        | データの可視化 |
| Logstash      | データソースからデータの取り込み/変換 |
| Beats         | データソースからデータの取り込み |
| X-Pack        | セキュリティ/モニタリング/ウォッチ/レポート/グラフの機能を拡張 |

\*1・・・全文検索エンジンとは、大量のドキュメントから目的の単語を含むドキュメントを高速に抽出するもの。

## 使ってみる

今回はKibanaと組み合わせてElastic Searchを簡単に使ってみる。
KibanaはElasticsearchのデータを分析/可視化するツール。

### 環境

- OS: macOS Mojave 10.14.4
- Homebrew: 2.1.3
  - Homebrew/homebrew-core (git revision fd1ef4; last commit 2019-05-25)
  - Homebrew/homebrew-cask (git revision 16d50; last commit 2019-05-26)
- elasticsearch: stable 6.8.0, HEAD

### インストール

さっそくElastic Searchをインストールしようとしたところエラー、どうやらJava1.8が必須らしい。
```
$ brew install elasticsearch
elasticsearch: Java 1.8 is required to install this formula.
Install AdoptOpenJDK 8 with Homebrew Cask:
  brew cask install homebrew/cask-versions/adoptopenjdk8
Error: An unsatisfied requirement failed this build.
```

ということで、先にJava1.8のインストールをする。
```
$ brew cask install homebrew/cask-versions/adoptopenjdk8
==> Tapping homebrew/cask-versions
Cloning into '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask-versions'...
remote: Enumerating objects: 197, done.
remote: Counting objects: 100% (197/197), done.
remote: Compressing objects: 100% (193/193), done.
remote: Total 197 (delta 9), reused 27 (delta 1), pack-reused 0
Receiving objects: 100% (197/197), 84.04 KiB | 333.00 KiB/s, done.
Resolving deltas: 100% (9/9), done.
Tapped 168 casks (215 files, 322.7KB).
==> Satisfying dependencies
==> Downloading https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_mac_hotspot_8u212b03.pkg
==> Downloading from https://github-production-release-asset-2e65be.s3.amazonaws.com/140418865/07e4b900-61d1-11e9-96f2-868c40733c49?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credent
######################################################################## 100.0%
==> Verifying SHA-256 checksum for Cask 'adoptopenjdk8'.
==> Installing Cask adoptopenjdk8
==> Running installer for adoptopenjdk8; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are ignored.
Password:
installer: Package name is AdoptOpenJDK
installer: Installing at base path /
installer: The install was successful.
🍺  adoptopenjdk8 was successfully installed!
```

Elastic Searchをインストールする。

```
$ brew install elasticsearch
==> Downloading https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.8.0.tar.gz
######################################################################## 100.0%
==> /usr/local/Cellar/elasticsearch/6.8.0/bin/elasticsearch-keystore create
==> Caveats
Data:    /usr/local/var/lib/elasticsearch/
Logs:    /usr/local/var/log/elasticsearch/elasticsearch_NRintaro.log
Plugins: /usr/local/var/elasticsearch/plugins/
Config:  /usr/local/etc/elasticsearch/

To have launchd start elasticsearch now and restart at login:
  brew services start elasticsearch
Or, if you don't want/need a background service you can just run:
  elasticsearch
==> Summary
🍺  /usr/local/Cellar/elasticsearch/6.8.0: 133 files, 103.1MB, built in 36 seconds
```

`brew info`でインストールできたかと情報をざっと確認する。

```
$ brew info elasticsearch
elasticsearch: stable 6.8.0, HEAD
Distributed search & analytics engine
https://www.elastic.co/products/elasticsearch
/usr/local/Cellar/elasticsearch/6.8.0 (133 files, 103.1MB) *
  Built from source on 2019-05-26 at 11:12:52
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/elasticsearch.rb
==> Requirements
Required: java = 1.8 ✔
==> Options
--HEAD
	Install HEAD version
==> Caveats
Data:    /usr/local/var/lib/elasticsearch/
Logs:    /usr/local/var/log/elasticsearch/elasticsearch_NRintaro.log
Plugins: /usr/local/var/elasticsearch/plugins/
Config:  /usr/local/etc/elasticsearch/

To have launchd start elasticsearch now and restart at login:
  brew services start elasticsearch
Or, if you don't want/need a background service you can just run:
  elasticsearch
==> Analytics
install: 11,218 (30 days), 34,571 (90 days), 119,042 (365 days)
install_on_request: 10,540 (30 days), 32,271 (90 days), 109,720 (365 days)
build_error: 0 (30 days)
```

info見ると`/usr/local/Cellar/elasticsearch/6.8.0/bin`配下に`elasticsearch`コマンドがあるので、次のコマンドで起動する。
毎度フルパスを指定するのが面倒だったので、後で`bash_profile`にパスを通した。

```
$ /usr/local/Cellar/elasticsearch/6.8.0/bin/elasticsearch
OpenJDK 64-Bit Server VM warning: Cannot open file logs/gc.log due to No such file or directory
{大量のログ}
```

警告出てるけど一旦スルー(調べても良くわからなかったので)して、動作確認のため9200番ポートに接続する。
デフォルトが9200番ポートらしい。ちゃんと値が返却されたので大丈夫そう。

```
$ curl http://localhost:9200/
{
  "name" : "5QKo5zz",
  "cluster_name" : "elasticsearch_NRintaro",
  "cluster_uuid" : "8T3f3VlrSQKrgWfODLC7lQ",
  "version" : {
    "number" : "6.8.0",
    "build_flavor" : "oss",
    "build_type" : "tar",
    "build_hash" : "65b6179",
    "build_date" : "2019-05-15T20:06:13.172855Z",
    "build_snapshot" : false,
    "lucene_version" : "7.7.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

`elasticsearch`コマンドがインストールできたので、次にKibanaを[ダウンロード](https://www.elastic.co/jp/downloads/kibana)して起動する。
めっちゃエラー出た笑 引越しの準備しないといけないので一旦ここまで。

```
$ cd path_to_kibana-dir
$ ./bin/kibana
{大量のログ}
```

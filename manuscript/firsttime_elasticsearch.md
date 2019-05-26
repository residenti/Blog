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
バージョン7.1.0をインストールした。

```
$ cd path_to_kibana-dir
$ ./bin/kibana

{大量のログ}
log   [10:21:30.117] [error][status][plugin:xpack_main@7.1.0] Status changed from yellow to red - This version of Kibana requires Elasticsearch v7.1.0 on all nodes. I found the following incompatible nodes in your cluster: v6.8.0 @ 127.0.0.1:9200 (127.0.0.1)
```

どうやらバージョンが7.1.0のElasticsearchが必要らしかったので、`brew`でこのバージョンのElasticsearchをインストールしようと試みたがうまくいかずハマりそうだったので、`brew`を止めて`wget`でzipをダウンロードして`tar`で解凍して使うようにした。

まずは`brew`でインストールしたElasticsearchをアンインストールしとく。

```
$ brew uninstall elasticsearch
Uninstalling /usr/local/Cellar/elasticsearch/6.8.0... (133 files, 103.1MB)
```

elasticsearchの7.0.0をインストール。

```
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-darwin-x86_64.tar.gz
--2019-05-26 20:39:16--  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-darwin-x86_64.tar.gz
artifacts.elastic.co (artifacts.elastic.co) をDNSに問いあわせています... 151.101.110.222
artifacts.elastic.co (artifacts.elastic.co)|151.101.110.222|:443 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 200 OK
長さ: 339093778 (323M) [application/x-gzip]
`elasticsearch-7.0.0-darwin-x86_64.tar.gz' に保存中

elasticsearch-7.0.0-darwin-x86_64.tar.gz     100%[============================================================================================>] 323.38M  3.71MB/s 時間 80s

2019-05-26 20:40:37 (4.05 MB/s) - `elasticsearch-7.0.0-darwin-x86_64.tar.gz' へ保存完了 [339093778/339093778]

$ tar -xzf elasticsearch-7.0.0-darwin-x86_64.tar.gz
```

日本語検索プラグインkuromojiもインストールする。

```
$ cd elasticsearch-7.0.0
$ bin/elasticsearch-plugin install analysis-kuromoji
-> Downloading analysis-kuromoji from elastic
[=================================================] 100%  
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by org.bouncycastle.jcajce.provider.drbg.DRBG (file:/Users/NRintaro/Documents/Program/environment/Private/Elasticsearch/elasticsearch-7.0.0/lib/tools/plugin-cli/bcprov-jdk15on-1.61.jar) to constructor sun.security.provider.Sun()
WARNING: Please consider reporting this to the maintainers of org.bouncycastle.jcajce.provider.drbg.DRBG
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
-> Installed analysis-kuromoji
```

elasticsearchを起動する。

```
$ bin/elasticsearch
{大量のログ}
```

動作確認でhttp://localhost:9200/へ接続する。

```
$ curl http://localhost:9200/
{
  "name" : "lime.local",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "eBVO6KLfRnea3Gn0hxAmeg",
  "version" : {
    "number" : "7.0.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "b7e28a7",
    "build_date" : "2019-04-05T22:55:32.697037Z",
    "build_snapshot" : false,
    "lucene_version" : "8.0.0",
    "minimum_wire_compatibility_version" : "6.7.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

kibanaの7.0.0をインストール。

```
$ wget https://artifacts.elastic.co/downloads/kibana/kibana-7.0.0-darwin-x86_64.tar.gz
--2019-05-26 20:35:59--  https://artifacts.elastic.co/downloads/kibana/kibana-7.0.0-darwin-x86_64.tar.gz
artifacts.elastic.co (artifacts.elastic.co) をDNSに問いあわせています... 151.101.110.222
artifacts.elastic.co (artifacts.elastic.co)|151.101.110.222|:443 に接続しています... 接続しました。
HTTP による接続要求を送信しました、応答を待っています... 200 OK
長さ: 172021559 (164M) [application/x-gzip]
`kibana-7.0.0-darwin-x86_64.tar.gz' に保存中

kibana-7.0.0-darwin-x86_64.tar.gz            100%[============================================================================================>] 164.05M  4.38MB/s 時間 42s      

2019-05-26 20:36:42 (3.89 MB/s) - `kibana-7.0.0-darwin-x86_64.tar.gz' へ保存完了 [172021559/172021559]

$ tar -xzf kibana-7.0.0-darwin-x86_64.tar.gz
```

elasticsearchを起動する。

```
$ bin/kibana
```

ブラウザからhttp://localhost:5601/へ接続し、kibanaの管理画面が表示されたので大丈夫そう。

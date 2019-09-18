# DApps開発環境の構築

macOSでの開発環境の構築方法。
利用するツールの一覧は下記の通り。

・Homebrew
・Docker
・Geth
・Ganache
・Node.js(npm)
・Truffle

Homebrewとか既にインストール済みのものもあるので、ここには新たにインストールしたツールについてのみ手順を記載する。
今回インストールしたツール一覧は下記の通り。

・Geth
・Ganache
・Truffle

## Geth
GethとはEthereum（イーサリアム）が提供しているクライアントソフトで、Go Ethereumの略称です。
できること
- マイニング
- 資金移動
- スマートコントラクト
- ブロック履歴の表示

インストール方法はいくつかあるが、今回はHomebrewでインストールする。
まずは、Homebrewのパッケージカタログを最新版に更新して、Ethereumリポジトリをパッケージカタログに追加する。

```
$ brew update
Alerady up-to-date.

$ brew tap ethereum/ethereum
==> Tapping ethereum/ethereum
Cloning into '/usr/local/Homebrew/Library/Taps/ethereum/homebrew-ethereum'...
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 9 (delta 2), reused 1 (delta 0), pack-reused 0
Unpacking objects: 100% (9/9), done.
Warning: Aleth (formerly cpp-ethereum) has been removed from Homebrew. Please install binary releases from https://github.com/ethereum/aleth/releases.
Tapped 4 formulae (28 files, 18.0KB).
```

次に、Gethをインストールする。

```
$ brew install ethereum
==> Downloading https://homebrew.bintray.com/bottles/ethereum-1.9.3.mojave.bottle.tar.gz
==> Downloading from https://akamai.bintray.com/ff/ff6330010cc5feb2dbe25643d40f0583492d505aed2ffc48f7cfcacb41960479?__gda__=exp=1568598835~hmac=de6fb6c72464cf935d57703c6d31254d7a
######################################################################## 100.0%
==> Pouring ethereum-1.9.3.mojave.bottle.tar.gz
🍺  /usr/local/Cellar/ethereum/1.9.3: 19 files, 327.2MB
==> `brew cleanup` has not been run in 30 days, running now...
Removing: /Users/residenti/Library/Caches/Homebrew/libevent--2.1.10.mojave.bottle.tar.gz... (782.3KB)
Removing: /Users/residenti/Library/Caches/Homebrew/oniguruma--6.9.2.mojave.bottle.tar.gz... (422.2KB)
Removing: /usr/local/Cellar/openssl/1.0.2r... (1,795 files, 12.1MB)
Removing: /Users/residenti/Library/Caches/Homebrew/wget--1.20.3_1.mojave.bottle.tar.gz... (1.4MB)
Removing: /Users/residenti/Library/Logs/Homebrew/ncurses... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/tmux... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/oniguruma... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/libevent... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/jq... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/openssl... (64B)
Removing: /Users/residenti/Library/Logs/Homebrew/telnet... (64B)
Pruned 0 symbolic links and 2 directories from /usr/local
```

最後に、Gethが正しくインストールされたかを確認する。
```
$ geth version
Geth
Version: 1.9.3-stable
Architecture: amd64
Protocol Versions: [63]
Network Id: 1
Go Version: go1.12.9
Operating System: darwin
GOPATH=
GOROOT=/usr/local/Cellar/go/1.12.9/libexec[]
```

## Ganache

[Ganache公式サイト](https://www.trufflesuite.com/ganache)からダウンロードしてインストールする。
[DOWNLOAD(MACOS)]をクリックするとGanache-x.x.x.dmgがダウンロードされるので、それをダブルクリックしてインストールする。
2019/0916時点の最新バージョンは2.1.1だった。

## Truffle

npm install コマンドを使って-gオプション付きでインストールする。

まずは、インストールできるtruffleのバージョンを確認する。
```
$ npm info truffle versions

[
  '0.0.1',
  '0.0.2',
  '0.0.3',

  〜省略〜

  '5.0.36',
  '5.1.0-ens-events.1'
]
```

次に、truffleをグローバル(/usr/local/bin)にインストールする。
バージョンを確認したものの、結局最新版をインストールすることにした。

```
$ npm install -g truffle
/Users/residenti/.nodebrew/node/v12.8.1/bin/truffle -> /Users/residenti/.nodebrew/node/v12.8.1/lib/node_modules/truffle/build/cli.bundled.js

> truffle@5.0.36 postinstall /Users/residenti/.nodebrew/node/v12.8.1/lib/node_modules/truffle
> node ./scripts/postinstall.js

- Fetching solc version list from solc-bin. Attempt #1
- Downloading compiler. Attempt #1
+ truffle@5.0.36
added 27 packages from 439 contributors in 22.828s
residenti@lime:Desktop  $ truffle version
Truffle v5.0.36 (core: 5.0.36)
Solidity v0.5.8 (solc-js)
Node v12.8.1
Web3.js v1.2.1
```

最後に、正しくインストールできたかを確認する。

```
$ truffle version
Truffle v5.0.36 (core: 5.0.36)
Solidity v0.5.8 (solc-js)
Node v12.8.1
Web3.js v1.2.1
```

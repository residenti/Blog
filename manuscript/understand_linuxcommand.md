# test -r ~/.bashrc && . ~/.bashrc を読み解く
post: 2019/01/09, update: 2019/01/09

最近PCの初期化にともないセットアップをしていました。その中で.bash_profileを編集している時に表題の行を見つけて「？(おそらく.bashrcを読み込んでいるのだろうけどtestってなんだ???)」となったので、この行で使われているLinxuコマンドについて調べ動作を理解してみました。これはその書き留め。

```bashrc
test -r ~/.bashrc && . ~/.bashrc
```

この行で使われているLinuxコマンドは3つ。

1: [test](https://shellscript.sunone.me/if_and_test.html#test-%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)は評価結果に従い、真(0)か偽(1)を返すコマンドで、オプションの-rは渡したfile(ここでは~/.bashrc)が読み取り可能ならば真となる。

2: [&&](https://tech.nikkeibp.co.jp/it/article/COLUMN/20060224/230604/)は1つ目のコマンドが正常終了した場合に2つ目のコマンドを実行するコマンド。

3: . (= [source](https://eng-entrance.com/linux-command-source))は渡したfile(ここでは~/.bashrc)に記載されテイルコマンドを実行するコマンド。

よって、この行の動作は「~/.bashrcが読み取り可能ならば、~/.bashrc内に記載されているコマンドを実行する」となる。とりあえずなるほど。

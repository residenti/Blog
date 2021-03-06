# [Git] Permanently added the RSA host key for IP address 'xx.xxx.xx.xx' to the list of known hosts.

githubからpullしたら、以下の様なメッセージが出力された。

```bash
$ git pull
Warning: Permanently added the RSA host key for IP address 'xx.xxx.xx.xx' to the list of known hosts.
```
なんだこれは？一応pull自体はできてたので、警告だしスルーでもいい気はしたけど、気になるので調べてみたところ[こちら](https://www.kaoriya.net/blog/2016/07/04/)の記事が見つかった。

どうやらこの警告メッセージの意味は、`~/.ssh/known_hosts`にgithub.comとしてIPアドレスが追加登録されたよってことらしい。
実際に、このファイルを開いて中身をみてみたら警告に表示されていたIPアドレスと[フィンガープリント](https://wa3.i-3-i.info/word16574.html)らしきものがファイルの最後の行に追加されていた。
参考にしたサイトでは、フィンガープリントは最初の行だけで、2行目以降はIPアドレスのみと説明されていたけど、どうなんだろう。

ちなみに、このメッセージが自然に出てこなくなるのはgithubが使ってる全てのIPアドレスが登録されたらだそうで、参考サイトによると 192.30.252.0/22 で1024個もあるそう。

対応として`~/.ssh/known_hosts`の中にある`github.com`を探して、

```
github.com,192.30.252.11 ssh-rsa AAAA・・・
```

ここのIPアドレスの箇所をワイルドカードを使い次のように書き換えると警告が出力されなくなる。

```
github.com,192.30.252.*,192.30.253.*,192.30.254.*,192.30.255.* ssh-rsa AAAA・・・
```

参考サイトを噛み砕いた内容の記事だけど、まぁ。

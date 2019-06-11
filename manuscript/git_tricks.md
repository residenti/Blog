# [Git] 小技集

地味に使う小技を載せていく。

## 複数行のコミットコメントを付与する

これは2通りのやり方がある。

### 1. -F- オプションとヒアドキュメントを組み合わせる

```
$ git commit -F- <<EOM
> コメント1行目
> コメント2行目
> コメント3行目
> EOM
```

### 2. -m オプションを複数付ける

```
$ git commit -m "コメント1行目" -m "コメント2行目" -m "コメント3行目"
```

## 特定のgitリポジトリでuserとemailを変える

```
$ git config --local user.name 名前
$ git config --local user.email メールアドレス
```

上記のコマンドでプロジェクトのconfigに設定が追加される。

プロジェクトのconfigは`project/.git/config`にあるので、直接ここを編集してもOK。

```
# project/.git/config

[user]
name = userName
email = sample@gmail.com
```

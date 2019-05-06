# CSSのキャッシュによりデザインが更新されないのを防ぐ
post: 2018/12/13, update: 2019/05/04

この記事は当ブログのCSSファイルを修正しサーバーにアップした後、サイトを更新してもデザインが適応されないという経験をしたときの対応をメモしたもの。

## 方法1. スーパーリロード
スーパーリロードについては[こちら](http://os0x.hatenablog.com/entry/20110617/1308280740)を読んだ。自分はMacでChrome(バージョン: 70.0.3538.110)を使っているので「command + shift + r」でスーパーリロードした。

## 方法2. CSSファイルの指定の後ろにクエリを加える
下記のコードのようにCSSファイルの指定の後ろにクエリ(20181213000000)を加えることでスーパーリロードをかけなくても自動で更新されるようになる。

```html
<link rel="stylesheet" type="text/css" href="./assets/stylesheets/index.css?20181213000000">
```

ただ、対象のCSSファイルが多いと変更箇所が増えて面倒くさくなりそう。とりあえずはこれで対応して、必要になったら別のやり方見つけて対応しよう。その際はここに追記してく。
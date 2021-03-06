# [Clean Architecture　達人に学ぶソフトウェアの構造と設計] 第2部 構成要素から始めよ: プログラミングパラダイム
post: 2019/04/30, update: 2019/05/01

ここで言うパラダイムとは、プログラミングの方法のこと。
本部にはいつ・どのプログラミング構造を使うべきかについての説明が書かれている。

## はじめに

最近[Clean Architecture　達人に学ぶソフトウェアの構造と設計](https://www.amazon.co.jp/dp/B07FSBHS2V/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)を読み始めたが、そこそこ難しくさーっと読み進めても全然頭に入ってこないので、理解の助けとしてメモを取る事にした。

本書は7部構成なので、メモは部毎に取る予定。
ただ、第1部はイントロダクションだったのでメモ無し。
そのため、メモは第2部からになる。

## 第3章 パラダイムの概要

本章では、3つのパラダイムの概要が説明されている。

・構造化プログラミング
・オブジェクト指向プログラミング
・関数型プログラミング

### 構造化プログラミング

本章では、構造化プログラミングを次のように要約している。

> 構造化プログラミングは、直接的な制御の移行に規律を課すものである。

これは次のように解釈できる、
直接的な制御の移行・・・制限のないジャンプ(goto文の使用)
規律を課す・・・制限のないジャンプをif/then/elseやdo/while/untilといった構文に置き代える

*補足*
今日の構造化プログラミングには[3つの解釈](https://ja.wikipedia.org/wiki/%E6%A7%8B%E9%80%A0%E5%8C%96%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)が存在していて、この本で言う所の構造化プログラミングは、wikipediaでは[構造化定理](https://ja.wikipedia.org/wiki/%E6%A7%8B%E9%80%A0%E5%8C%96%E5%AE%9A%E7%90%86)にあたるらしい。
[goto文とは｜goto文はなぜ禁止されるのか【goto文と教養】](https://marycore.jp/coding/why-goto-statement-is-bad/)

### オブジェクト指向プログラミング

本章では、オブジェクト指向プログラミングを次のように要約している。

> オブジェクト指向プログラミングは、間接的な制御の移行に規律を課すものである。

全然分からん。。これどう解釈すれば良いんだろう。
とりあえず、この一文をいくつかの塊に分けてなんとなく思いつくものを当てはめると、

まず、「間接的な制御の以降」が指しているのは、文章読む感じだと関数ポインタが具体的なものっぽいかな。
「間接的」は、間接参照を指したり。
ただ、構造化プログラミングの要約に「直接的な制御の移行」って書かれてるから、これの反対はとか考えれば良いのかな、、、
現時点では、理解が難しそうなので一旦飛ばして進む。

*追記*
第5章オブジェクト指向プログラミングに答えが記載されていた。

> 関数へのポインタを明示的にしようして、ポリモーフィズムの振る舞いを生み出す時の問題は、関数へのポインタが危険であることだ。
> ポインタを初期化するときは「ポインタを経由して関数を呼び出す」という規約を覚えておく必要がある。
> OO言語はこうした規約を排除することで、関数へのポインタの危険性を回避している。

これを踏まえてもう一度要約を見てみると、

> オブジェクト指向プログラミングは、間接的な制御の移行に規律を課すものである。

これは次のように解釈できる、
間接的な制御の移行・・・ポインタを経由して関数を呼び出す
規律を課す・・・ポインタ経由での関数呼び出しをプログラマーが行えなくする

*補足*
[スタックフレーム(コールスタック)](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%BC%E3%83%AB%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)は、プログラムで実行中の[サブルーチン](https://wa3.i-3-i.info/word1500.html)に関する情報を格納する[スタック](https://ja.wikipedia.org/wiki/%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)のこと。スタックフレームを使う目的はいくつかあるが、主な目的は実行中サブルーチンの処理を完了して呼び出し側に戻るときに、どこに戻ればよいかを覚えておくこと。
[ポインタ](https://qiita.com/lrf141/items/a3e96b315dd4f08508a9)
[関数ポインタ](http://wisdom.sakura.ne.jp/programming/c/c54.html)
[アドレス演算子と間接演算子](http://www-watt.mech.eng.osaka-u.ac.jp/~tasai/ptrdoc/node5.html)

### 関数型プログラミング

本章では、関数型プログラミングを次のように要約している。

> 関数型プログラミングは、代入に規律を課すものである。

これは次のように解釈できる、
代入規律を課す・・・変数の値を変更する方法を厳しく制限する

これは、言われていることは分かるけど、実際にそれを実践する方法がぱっと思い浮かばない。
実際に書いてみて初めて理解ができる気がする。

*補足*
[ラムダ計算式](https://tarao.hatenablog.com/entry/20100208/1265605429)
[関数型プログラミングはまず考え方から理解しよう](https://qiita.com/stkdev/items/5c021d4e5d54d56b927c)

### まとめ

これらのパラダイムは、プログラマに何をすべきかではなく、何をすべきではないかを伝えている。
言い換えるとこれら3つのパラダイムはプログラマーからgoto文、関数ポインタ、代入を奪っている。

モジュールのアルゴリズムの基盤
=> 構造化プログラミング
=> 機能

アーキテクチャの境界を超えるための仕組み
=> ポリモーフィズム(オブジェクト指向)
=> コンポーネントの分離

データの配置やアクセスに規律を課す
=> 関数型言語
=> データ管理

## 第4章 構造化プログラミング

### 証明

移動中に読んだためメモ無し。

### 有害宣言

移動中に読んだためメモ無し。

### 機能分解

移動中に読んだためメモ無し。

### 正式に証明できない

移動中に読んだためメモ無し。

### 救済のための科学

移動中に読んだためメモ無し。

### テスト

移動中に読んだためメモ無し。

### まとめ

移動中に読んだためメモ無し。

## 第5章 オブジェクト思考プログラミング

### カプセル化とは?

移動中に読んだためメモ無し。

### 継承とは?

移動中に読んだためメモ無し。

### ポリモーフィズムとは?

移動中に読んだためメモ無し。

### ポリモーフィズムのパワー

移動中に読んだためメモ無し。

### 依存関係逆転

移動中に読んだためメモ無し。

### まとめ

移動中に読んだためメモ無し。

## 第6章 関数型プログラミング

### 整数の二乗

移動中に読んだためメモ無し。

### 不変性とアーキテクチャ

移動中に読んだためメモ無し。

### 可変性の分離

移動中に読んだためメモ無し。

### イベントソーシング

記憶容量が増えマシンが高速になれば、変更可能な状態を持つ必要性は薄くなっていく。
ここでは顧客の口座残高を記録する銀行アプリを例に、非関数型と関数型チックなサンプルコードを書いてみた。

``` sample.rb
# 口座残高(円)を保存する変数
account_balance

# 1,000円の入金
account_balance = account_balance + 1,000

# 500円の入金
account_balance = account_balance + 500

# 300円の出金
account_balance = account_balance - 300
```

上記のサンプルコードでは、口座残高は入出金の取引が実行されると都度変更されている。

次は、口座残高を取引の都度保存するのではなく、取引のみを保存する方針でサンプルコードを書いてみる。

``` sample.rb
# 1,000円の入金
deposit_1 = 1,000

# 500円の入金
deposit_2 = 500

# 300円の出金
withdrawal_1 = -300
```

この場合、残高を知りたい時は、これまでに保存してある全ての取引を合計すれば良い。

```
# 口座残高
deposit_1 + deposit_2 + withdrawal_1
```

この仕組みでは、1つめのサンプルのような口座残高を保存するための可変変数(account_balance)は必要ない。
このように状態(口座残高)ではなく、取引(トランザクション)を保持する戦略をイベントソーシングと言う。(これの実現を可能としているのは、十分な記憶容量と十分な処理能力を兼ね備えたマシンが存在するおかげでもある)

> さらに重要なのは、こうしたデータストアには削除も更新も必要が無い。その結果、アプリケーションはCRUDにはならず、CRだけになる。また、並行更新の問題も発生しない。十分な記憶容量と十分な処理能力があれば、アプリケーションを完全に不変にできる。したがって、完全に関数型になる。


### まとめ

> ●構造化プログラミングは、直接的な制御の移行に規律を課すものである。
> ●オブジェクト指向プログラミングは、間接的な制御の移行に規律を課すものである。
> ●関数型プログラミングは、代入に規律を課すものである。

これら3つのパラダイム(プログラミングの方法)は、プログラマーがコードを書く際に何らかの制限をかけていてる。
つまり、何をすべきではないかを教えてくれている。

また、ソフトフェアは急速に進捗する技術ではなく、本質は1946年にAlan Turingが初めて電子計算機用のコードを書いた時から変化していない。
それは、ソフトフェア(コンピュータプログラムの本質)は、「順次」「選択」「反復」と「間接参照」で構成されているということ。

第2部はここまで。続きは第3部用のメモに書いていく。

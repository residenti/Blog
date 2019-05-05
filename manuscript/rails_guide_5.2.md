# Railsガイド(5.2対応)

最近になって、もう一度きちんとRailsについて体系的に学びたくなったので、[Railsガイド 5.2対応 電子書籍版 (EPUB/PDF)](https://railsguides.jp/options.html)を購入。Kindleに変換してそっちで読もうと思っていたのに、何故か変換すると英語になるし目次が使えないので、色々試したが結果、諦めてKindle for  macで読むことに。これならわざわざ購入しなくてもRailsガイドの公式ページ見れば良かった感が拭い切れないけど、いくつか便利な機能が使えるし良しとしたい。。。ここには、Railsガイドを読み進めるにあたり気になった内容を記載しておく。

## 第1章 Railsをはじめよう

### 1.9 セキュリティ

#### 1.9.1 BASIC 認証

`http_basic_authenticate_with`メソッドは、特定のメソッドに認証したユーザー以外が実行できないようにする。
例えば、以下の場合ならindex,showメソッド以外のメソッドを実行するためには、認証が必要となる。

```ruby
class ArticlesController < ApplicationController

  http_basic_authenticate_with name : "dhh", password : "secret ", except : [:index , :show ]

  def index
    @articles = Article .all
  end

  # (省 略)

end
```

### 1.11 設定の落とし穴

> Rails での無用なトラブルを避けるための最も初歩的なコツは、外部データを常に UTF-8 で保存しておくことです。このとおりにしないと、Ruby ライブラリや Rails はネ イティブデータをたびたび UTF-8 に変換しなければならず、しかも場合によっては失敗 します。外部データを常に UTF-8 にしておくことをぜひお勧めします。

## 第2章 Active Record の基礎

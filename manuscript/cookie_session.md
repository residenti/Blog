# [リテラシー] ざっくり Cookie と Session
お互いの関係を整理するために書き出す。

## Cookie
Webサイトへアクセスしてきたユーザに情報を送信し、ユーザのPCにデータを保存する仕組み。

Cookie を使うことでより効率的にWebサイトを利用できるようになる。  
例えば、ログインページで過去に入力したログインIDやパスワードの自動保管といった機能はこの Cookie という仕組みにより実現されている。

Cookie は Chrome や Safari など、各ブラウザごとに実装されている機能で上述の通りサーバーから送られてきた情報を保存する。  
ただしCookie の利用はブラウザの設定で拒否することも可能。

次回ユーザがWebサイトにアクセスした際に Cookie によって保存されている情報をサーバーへ送信する。  
ログインページの例だと、ログインIDとパスワードが Cookie に保存されており、次回アクセス時に Cookie からこの値が取得される。

## Session
Webサイトにアクセスしているユーザが複数ページにまたがるアクセスをした場合に、同じユーザであることを判断する仕組み。

例えば、とあるサイトでIDとパスワードを入力してログインをした後に、同じサイト上の様々なページへアクセスすると常に**ログイン済みの同じユーザ**として扱われるとき、ほとんどの場合でこのセッションの仕組みが利用されている。

セッションでは**セッションID**という値を発行し、このセッションIDをサーバとユーザのPCに保存する。  
そしてユーザが同じサイト上の別ページへアクセスする際に、PCに保存されているセッションIDをサーバへ送信することで、サーバは**ログイン済みの同じユーザ**かを判断できる。

＊ユーザのPCにセッションIDを保存するために Cookie が利用されている。
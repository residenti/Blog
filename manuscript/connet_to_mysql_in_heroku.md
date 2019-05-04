# HerokuのMySQLに接続する
post: 2019/05/02, update: 2019/05/02

herokuのMySQLに接続するために必要となる情報を取得する。

```bashrc
$ heroku config | grep CLEARDB_DATABASE_URL
CLEARDB_DATABASE_URL:
mysql://HOGE:FUGA@FUGA.cleardb.net/heroku_PIYO?reconnect=true
```

上記の情報を元にMySQLへ接続する。

```bashrc
$ mysql -u  HOGE -h FUGA.cleardb.net heroku_PIYO -p
Enter password: FUGA
```

毎度忘れちゃうのでメモしといた。
以上。

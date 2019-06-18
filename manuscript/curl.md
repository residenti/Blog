# curlで複数パラメータのGETを投げる

ついつい忘れて毎回ググっているのでメモしておく。
curlコマンドで「&」を使う際は、エスケープまたは、「"」で括る。

```
curl -X GET https://sample.com?hoge=1\&fuga=2\&piyo=3
```

# Railsアプリケーションでメールを送信する

気付けば久方ぶりのブログ更新になります。
今回は最近開発している[APIサービス](https://github.com/residenti/lalalalunch-api)で、アカウント登録完了時にアクセストークンをメールで送信する機能を実装したので、そのメモです。

## Action Mailer

Action Mailerを使うと簡単にメールを送ることができました。
実装したのは、メイラークラスとビュー、それからメール送信用の設定です。
メイラークラス?となりましたが、コントローラーの役割に近く感じたので、一旦そういうものだと理解しています。

ちなみに、メイラーはActionMailer::Baseを継承していて、app/mailerに配置され、app/viewsにあるビューと結び付けられます。

## メイラーを生成する

gnerateコマンドでメイラーを生成すると、ビューのディレクトリとテストも同時に作成されます。

```
$ bin/rails g mailer ConfirmationMailer
Running via Spring preloader in process 57787
  create  app/mailers/confirmation_mailer.rb
  invoke  erb
  create    app/views/confirmation_mailer
  invoke  test_unit
  create    test/mailers/confirmation_mailer_test.rb
  create    test/mailers/previews/confirmation_mailer_preview.rb
```
＊application_mailer.rb がない場合は、その辺りの必要なファイルも生成されます。

```ruby
# app/mailers/confirmation_mailer.rb
class ConfirmationMailer < ApplicationMailer
end
```

## メイラーにアクションを定義する

まずはメイラーに「アクション」と呼ばれるメソッドを定義します。
メールを送信したいコントローラーで、定義したアクションを呼び出すことでメールを送信できます。また、メールの本文は、先ほどのgenerateコマンドで生成された`app/views/confirmation_mailer`ディレクトリ配下で定義します。

今回は、アカウント登録完了時に呼び出すのでregistration_completedアクションを定義してみます。

```ruby
# app/mailers/confirmation_mailer.rb
class ConfirmationMailer < ApplicationMailer
  default from: 'lalalalunch.api@gmail.com'

  def registration_completed
    @user = params[:user]
    mail(to: @user.email, subject: '【らららランチAPI】ユーザー登録手続き完了')
  end
end
```

アクションで使える全てのオプションは[Action Mailerの全メソッド](https://railsguides.jp/action_mailer_basics.html#action-mailer%E3%81%AE%E5%85%A8%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89)に載ってます。

コントローラー同様、アクションで定義したインスタンス変数(`@user`)はビューで利用できます。

## メールの本文を定義する

`app/views/confirmation_mailer`配下に、メール本文を定義するビューファイルを作成し、本文を定義します。

```html
# app/views/confirmation_mailer/registration_completed.html.erb
<p><%= @user.userid %> 様</p>

<p>らららランチAPIをご利用いただきありがとうございます。</p>

<p>ユーザー登録が完了しました。</p>
<p>アクセスキーは</p>
<p><%= @user.access_token %></p>
<p>になります。</p>
<p>利用期限はマイページからご確認ください。</p>
```

＊ このビューファイルは`app/views/layouts/mailer.html.erb`にレンダリングされます。

```html
# app/views/layouts/mailer.html.erb
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
      /* Email styles need to be inline */
    </style>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

このレイアウトの指定は`app/mailer/application_mailer.rb`で定義されています。

```ruby
# app/views/layouts/mailer.html.erb
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
```

また、HTMLに対応していない人でもメールが見れるように、テキストメールも作成しておきます。

```txt
# app/views/confirmation_mailer/registration_completed.text.erb
<%= @user.userid %> 様

らららランチAPIをご利用いただきありがとうございます。

ユーザー登録が完了しました。
アクセスキーは
<%= @user.access_token %>
になります。
利用期限はマイページからご確認ください。
```

HTML形式のメールに加え、テキスト形式のメールも作成しておくことで、[multipart/alternative形式](http://fuji3.main.jp/common/tips/mail_m_p.html)のメールを自動生成します。
これは、mailerメソッドが呼び出されると、2種類のテンプレートが存在するかをチェックして行ってくれる。

## メールの設定をする
## メールを送信する

# 自動コーデアプリ『Miller』

# 1.アプリ概要
登録したアイテムを綺麗め度・暑さ度に基づいてコーデを自動生成するwebアプリケーションです。

私は洋服が大好きで、いろんなジャンルの洋服を着ます。服を着ていく中で、以下のような困りごとがありました。  


* 会う人や用事によって、コーデを考えるのが面倒。
* 持っているアイテムを把握できずに、埋もれてしまう。  
* コーデのバリエーションがもっと欲しい。  


これらの困りごとを解決したい、という思いでアプリを作成しました。


綺麗め度と暑さ度について説明します。  
* 1綺麗め度:アイテムのフォーマル度合いを指します。1から9の値で評価し、最大の9にスーツあたりが該当すると思います。
* 暑さ度:アイテムがどれくらい暖かいのかを指します。1から9の値で評価し、最大の9に厚手のダウンジャケットあたりが該当します。


# 2.使用技術
### フロントエンド
* HTML
* CSS, Sass
* javascript

### バックエンド
* Ruby
* Ruby on Rails
* MySQL

### API
* Cloud Vsion API
* Open Weather API

### インフラ
* Docker
* Dcoker-compose
* AWS EC2

### その他
* Git/Github
* VSCode


# 3.インフラ構成図,デプロイの流れ

# 4.ER図
<img width="732" alt="ER" src="https://github.com/taishi0411/coord_app/assets/106446066/bf494341-6528-41fa-8d6d-7a1fdf7c89fb">



itemテーブルのclor_differenceカラムは、画像の占める割合が一番大きい色のrgb(red,green,blue)の最大と最小値の差を保持します。アイテム登録時にCloud Vision APIにて画像の占める割合が一番大きい色をjson形式でrgb(red,green,blue)として取得します。  

rgb(red,green,blue)の中で、最大値と最小値の差をccolor_differenceメソッドで計算しccolor_differenceカラムに格納します。  


rgbの最小値と最大値の差が小さいほどモノトーン(黒or白)に近づきます。反対にrgbの最小値と最大値の差が大きいほど有彩色に近づきます。有彩色なアイテムほどcolor_defference(最大255)が大きくなります。  


# 5.アプリの特徴
### コーデ機能
選択した綺麗め度にコーデ全体の平均綺麗め度が近づくように、選択した暑さ度にトップス,アウター,パンツの暑さ度の平均が近付くようにアイテムを取り出します。帽子、メガネ、靴、バッグはランダムで取出します。同じ値を入力してコーデを組むと、先ほどとは違うコーデを提案するようにしています。気温が16以下or暑さ度を６以上にするとコーデにアウターが反映されるようになっています。 

<img width="1906" alt="clean1_heat1" src="https://github.com/taishi0411/coord_app/assets/106446066/b699ccf8-aba3-4d9d-9f52-a9d856498ed4">


綺麗め度高めで暑さ度を高めにした時のコーデです。  

<img width="1906" alt="clean9_heat9" src="https://github.com/taishi0411/coord_app/assets/106446066/c8efdaa7-4742-4419-9531-351256986337">


  
  
### 差し色モード
差し色コーデ：モノトーンのコーデに派手なアイテムを一つ取り入れて、アクセントを出すコーデのことです。

差し色モードにチェックを入れると差し色コーデになります。

color_differeceの低いコーデの中に一つcolor_differeceの高いアイテムを取り出します。

<img width="1906" alt="color_select" src="https://github.com/taishi0411/coord_app/assets/106446066/5d6de789-92d2-4623-90e9-51177fb08e41">  


    
### クローゼット
アイテムをジャンル別で表示します。

<img width="1906" alt="item_index" src="https://github.com/taishi0411/coord_app/assets/106446066/eba72f69-12b7-4aa3-870c-344ee7e50306">



### 天気表示
新規登録で登録した都道府県の天気および気温をOpen wether APIで取得して表示します。気温が16以下になるとアウターがコーデに組まれます。  

<img width="373" alt="weather" src="https://github.com/taishi0411/coord_app/assets/106446066/9b98b591-2568-4fe0-ab10-9e0f6c254f2b">



# 6.アプリの機能一覧
### メイン機能
* コーデ機能
* 差し色機能
* 天気表示機能
* アイテム登録
* アイテム編集
* アイテム表示機能(クローゼット)


### 認証機能
* ユーザ登録
* プロフィール編集
* ログイン、ログアウト
* 退会

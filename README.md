## アプリケーション名
Investment Beginner

## アプリケーション概要
実際の米国銘柄を用いて意見を交換したり、自身の登録銘柄の損益を確認したりできる投資初心者向けのアプリです。

## URL
https://investment-beginner.onrender.com

## テスト用アカウント
* Basic認証パスワード：2222
* Basic認証ID：admin
* メールアドレス：
* パスワード：

## 利用方法
#### 意見交換
1.　トップページから（一覧ページ）のヘッダーからユーザー新規登録を行います。
2.　投稿フォームに必要事項（銘柄、公開の是非、自由記述）を入力して投稿します。
3.　詳細ページにあるコメントフォームから投稿を行い、他のユーザーと交流を図ります。
#### 登録銘柄の損益の確認
1.　マイページにあるお気に入り銘柄登録ページから登録を行います。

## アプリケーションを作成した背景
2024年より新NISAが始まります。しかし日本では現在約6割の人が投資未経験だと言われています。
投資を行わない主な理由としては「投資は怖いものである」というイメージが先行していることと、
誰に相談したらいいかわからないというこの2点が挙げられることが多いです。
そのため実際の米国株を用いて損益を体験でき、また匿名で意見交換をする場を作りたいと考えてこのアプリを開発しました。

## 洗い出した要件
https://docs.google.com/spreadsheets/d/1LrMc9M8SaW0UH-OBIKf0yl92f7NsPhGk0Yp8lzTX5C8/edit#gid=982722306

## 実装した機能についての画像やGIFおよびその説明

## 実装予定の機能
株価チャートの表示機能

## データベース設計
[![Image from Gyazo](https://i.gyazo.com/083b8fa4f4bdf43743702ea0ddfd68c1.png)](https://gyazo.com/083b8fa4f4bdf43743702ea0ddfd68c1)

## 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/1d4b3f74f5c445e28764ea2af1155bfd.png)](https://gyazo.com/1d4b3f74f5c445e28764ea2af1155bfd)

## 開発環境
* フロントエンド
* バックエンド
* インフラ
* テスト
* テキストエディタ
* タスク管理

## ローカルでの操作方法
以下のコマンドを順に実行してください。
% git clone https://github.com/yuri-lily/investment_beginner.git
% cd investment_beginner
% bundle install
% yarn install

## 工夫したポイント

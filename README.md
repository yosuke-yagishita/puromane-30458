# アプリケーション名
ぷろまね

# アプリケーション概要
- ユーザーの新規登録機能
- 複数人によるプロジェクト管理機能
- プロジェクトメンバーの編集機能
- タスクの作成機能
- タスクの編集機能
- タスクの計画日及び完了日の表への出力
- 自信の登録したタスクの一覧表示

# URL
- 54.64.201.212

# Basic認証
- ID:admin
- pass:2222

# テスト用アカウント
## ユーザー１
- Nickname:yamada
- Email:yamada@yamada
- Password:111111
## ユーザー2
- Nickname:sato
- Email:sato@sato
- Password:111111

# 利用方法
「ぷろまね」はページに遷移すると自動でログインページへ移動します。まだ、ユーザー登録が完了していないユーザーはサインアップページに移動してユーザー登録を行います。ユーザー登録が完了したらトップページに移動します。

![388eae21481128de73964bfae97869d5](https://user-images.githubusercontent.com/71483117/98781207-56078000-2439-11eb-8f24-436c1618bee9.gif)

トップページでは、新規プロジェクト作成というボタンを押すことでプロジェクト作成ページに移動します。プロジェクト名を入力してプロジェクト作成ボタンを押すことでログインしているユーザーが参加するプロジェクトを作成できます。プロジェクト作成時にプロジェクトメンバーを選択すれば、選択したプロジェクトメンバーもプロジェクトに参加させることができます。

プロジェクトを作成するとトップページにプロジェクトが表示されます。表示されたプロジェクトのメンバー編集を押すことでプロジェクトメンバーの編集、プロジェクトの表を押すことでプロジェクトの詳細へ移動することができます。

プロジェクトの詳細では、タスク名を記入してからタスクの作成ボタンを押すことでタスクの作成が行えます。作成されたタスクの計画日は今日から起算して７日間分が表で表示されます。

![8d91c207ef5181e77a2e22980635e2a4](https://user-images.githubusercontent.com/71483117/98784153-07101980-243e-11eb-82da-55cf2cdb1d23.gif)

また、詳細ページからメンバーの編集ページへの遷移やプロジェクトの終了が行えます。

プロジェクトの詳細ページのタスクの編集ボタンを押すことでタスクの編集が行え、完了日を入力することで計画日と同様に表で表示されます。プロジェクトから削除したいタスクはタスクの編集ページから削除することができます。
![604363f549ce75e65a2c341671e364f8](https://user-images.githubusercontent.com/71483117/98784436-75ed7280-243e-11eb-9ee7-3ce1b98be4ab.gif)

# 目指した課題解決
業務管理を行う人が誰がいつまでに何をやらないと目標を達成できないのか可視化する

# 洗い出した要件
- 複数人が同時に編集できるプロジェクトを作る
- スプレッドシート形式で業務内容を一覧表示する
- 業務内容を列、日付を行で表示して交わる場所に状態を示すシンボルマークを表示する
- 業務内容に担当者を紐づける
- プロジェクトを作成した人はプロジェクトへの招待権限を持ち、招待権限の付与も行える
- ユーザーが登録したタスクの一覧を表示する

# 実装予定の機能
ユーザーの招待権限の機能を実装します。方法としてはproject_usersテーブルにadministratorというカラムをboolean型で設定してプロジェクトメンバーの編集機能に権限の条件分岐を設定します。

# ER図
- ![Image from Gyazo](https://i.gyazo.com/1244aa120edc17eaf22c8d9e0a1aed5f.png)
# ローカルでの動作方法
- ruby 2.6.5
- Rails 6.0.3.4
- Bundler version 2.1.4
- bundle install
- rails g devise:install



# テーブル設計

## users テーブル

| Column      | Type   | OOptions    |
| ----------- | ------ | ----------- |
| nickname    | string | null: false |
| email       | string | null: false |
| password    | string | null: false |
| family_name | string | null: false |
| first_name  | string | null: false |


### Association

- has_many :project_users
- has_many :projects, through: :project_users
- has_many :tasks

## projects テーブル

| Column | Type   | Options    |
| ------ | ------ | ---------- |
| title  | string | null: false|

### Association

- has_many :project_users
- has_many :users, through: project_users
- has_many :tasks

## project_users テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| project | references | null: false, foreign_key: true |

### Association

- belongs_to :project
- belongs_to :user

## tasks テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| task_name           | string     | null: false                    |
| person_in_charge    | string     |                                |
| plan                | date       | null: false                    |
| deadline            | date       |                                |
| user                | references | null: false, foreign_key: true |
| project             | references | null: false, foreign_key: true |

### Association
- belongs_to :project
- belongs_to :user
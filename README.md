# テーブル設計

## users テーブル

| Column      | Type   | OOptions     |
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
| name   | string | null: false|

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

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| task_name        | string     |                                |
| person_in_charge | string     |                                |
| plan             | date       |                                |
| deadline         | date       |                                |
| user             | references | null: false, foreign_key: true |
| room             | references | null: false, foreign_key: true |

### Association
- belongs_to :project
- belongs_to :user
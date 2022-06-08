# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ------------|
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_day          | date   | null: false |

### Association

- has_many :products

##  productsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| description         | string     | null: false                    |
| category            | string     | null: false                    |
| status              | string     | null: false                    |
| cost                | string     | null: false                    |
| area                | string     | null: false                    |
| arrival             | string     | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchase_history

##  purchase_historiesテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| user            | references | null: false, foreign_key: true |
| product         | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :Shipping_address

## Shipping_addressesテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| Prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| Building_name    | string     | null: false                    |
| phone_number     | string     | null: false                    |
| product          | references | null: false, foreign_key: true |
| purchase_history | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_history
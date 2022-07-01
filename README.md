#テーブル設計

## users

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| user                  | string     | null: false,                   |
| email                 | string     | null: false,                   |
| password              | string     | null: false,                   |
| encrypted_password    | string     | null: false,                   |
| family_name           | string     | null: false,                   |
| first_name            | string     | null: false,                   |
| family_kana           | string     | null: false,                   |
| first_kana            | string     | null: false,                   |
| birthday              | date       | null: false,                   |

- has_many :items
- has_many :orders
- has_one :order


## items

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| image                 | string       | null: false,                   |
| name                  | string       | null: false,                   |
| explain               | text         | null: false,                   |
| category              | string       | null: false,                   |
| condition             | string       | null: false,                   |
| shipping_cost         | integer      | null: false,                   |
| sender_area           | string       | null: false,                   |
| delivery_days         | string       | null: false,                   |
| price                 | integer      | null: false,                   |
| commission fee        | integer      | null: false,                   |
| benefit               | integer      | null: false,                   |
| user_id                  | reference    | null: false, foreign_key: true |

- belongs_to :user
- has_one :order


## Orders

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| user_id               | reference    | null: false, foreign_key: true |
| item_id               | reference    | null: false, foreign_key: true |
| shipping_id           | reference    | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :shipping


## shipping

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | integer      | null: false,                   |
| prefecture            | string       | null: false,                   |
| city_town             | string       | null: false,                   |
| address_2             | string       | null: false,                   |
| address_1             | string       | null: false,                   |
| tel                   | integer      | null: false,                   |
| item_id               | reference    | null: false, foreign_key: true |
| user_id               | reference    | null: false, foreign_key: true |


- belongs_to :order
- belongs_to :user

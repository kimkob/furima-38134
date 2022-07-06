#テーブル設計

## users

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| nickname              | string     | null: false,                   |
| email                 | string     | null: false, unique: true      |
| encrypted_password    | string     | null: false,                   |
| family_name           | string     | null: false,                   |
| first_name            | string     | null: false,                   |
| family_kana           | string     | null: false,                   |
| first_kana            | string     | null: false,                   |
| birthday              | date       | null: false,                   |

- has_many :items
- has_many :orders


## items

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| name                  | string       | null: false                    |
| explain               | text         | null: false                    |
| category_id           | integer      | null: false                    |
| condition_id          | integer      | null: false                    |
| shipping_cost_id      | integer      | null: false                    |
| prefecture_id         | integer      | null: false                    |
| shipping_time_id      | integer      | null: false                    |
| price                 | integer      | null: false                    |
| user                  | reference    | null: false, foreign_key: true |

- belongs_to :user
- has_one :order


## orders

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| user                  | reference    | null: false, foreign_key: true |
| item                  | reference    | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :shipping


## shipping

| Column                | Type         | Options                        |
| --------------------- | ------------ | ------------------------------ |
| post_code             | string       | null: false                    |
| prefecture_id         | integer      | null: false                    |
| city_town             | string       | null: false                    |
| address_2             | string       | null: false                    |
| address_1             | string       |                                |
| tel                   | integer      | null: false                    |
| order                 | reference    | null: false, foreign_key: true |

- belongs_to :order

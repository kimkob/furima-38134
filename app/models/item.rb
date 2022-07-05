class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40}
  validates :explain, presence: true, length: { maximum: 1000}
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :sender_area_id, presence: true
  validates :delibery_days_id, presence: true
  validates :price, presence: true

end
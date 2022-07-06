class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_time


  validates :image, presence: true
  validates :name, presence: true
  validates :explain, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1}
  validates :condition_id, presence: true, numericality: { other_than: 1}
  validates :shipping_cost_id, presence: true, numericality: { other_than: 1}
  validates :prefecture_id, presence: true, numericality: { other_than: 1}
  validates :shipping_time_id, presence: true, numericality: { other_than: 1}
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 300, less_than: 9999999 }

end

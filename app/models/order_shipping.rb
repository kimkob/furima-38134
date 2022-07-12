class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_town, :address_2, :address_1, :tel, :user_id, :item_id

  with_options presence: true do
    validates :post_code,     format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city_town,     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :address_2
    validates :tel,           format: { with: /\A\d{10,11}\z/ }
    validates :item_id
    validates :user_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(post_code: post_code, prefecture_id: prefecture_id, city_town: city_town, address_2: address_2, address_1: address_1, tel: tel, order_id: order.id )
  end
end
class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_town, :address_2, :address_1, :tel, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code,     format: { with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true }
    validates :city_town
    validates :address_2
    validates :tel, format: { with: /\A\d{10,11}\z/, allow_blank: true }
    validates :item_id
    validates :user_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(post_code: post_code, prefecture_id: prefecture_id, city_town: city_town, address_2: address_2,
                    address_1: address_1, tel: tel, order_id: order.id)
  end
end

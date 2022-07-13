FactoryBot.define do
  factory :order_shipping do
    post_code { '123-4567' }
    prefecture_id { 9 }
    city_town { '横浜市' }
    address_2 { '横浜１−１−１' }
    address_1 { '' }
    tel { '01234567890' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end

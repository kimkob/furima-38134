FactoryBot.define do
  factory :user do
    nickname                { Faker::Name }
    email                   { 'a1' + Faker::Internet.free_email }
    password                { '1234qwer' }
    password_confirmation   { password }
    family_name             { '山田' }
    first_name              { '鉄お' }
    family_kana             { 'ヤマダ' }
    first_kana              { 'テツオ' }
    birthday                { Faker::Date.birthday }
  end
end

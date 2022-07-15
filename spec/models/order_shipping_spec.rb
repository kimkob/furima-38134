require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '購入情報保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, item_id: @item.id, user_id: @user.id)
    end

    context '内容に問題がない場合' do
      it '全て正しく入力済かつtoken有り' do
        expect(@order_shipping).to be_valid
      end
      it 'address_1が空欄でも登録可' do
        @order_shipping.address_1 = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある' do
      it 'Postcode未記入' do
        @order_shipping.post_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'Postcodeハイフン無い' do
        @order_shipping.post_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'Prefecture未選択' do
        @order_shipping.prefecture_id = '1'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'city_town未記入' do
        @order_shipping.city_town = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('市区町村を入力してください')
      end
      # address_2#
      it 'address_2未記入' do
        @order_shipping.address_2 = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('番地を入力してください')
      end
      it 'tel未記入' do
        @order_shipping.tel = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'tel ハイフン付き' do
        @order_shipping.tel = '090-0000-0000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'tel 10桁未満' do
        @order_shipping.tel = '012345678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'tel 12桁以上' do
        @order_shipping.tel = '012345678901'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'itemへの紐付きなし' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Itemを入力してください')
      end
      it 'userへの紐付きなし' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Userを入力してください')
      end
      it 'tokenなし' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
    end
  end
end

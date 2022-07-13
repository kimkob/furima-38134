require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '購入情報保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, item_id: @item.id, user_id: @user.id)
    end

    context '内容に問題がない場合' do
      it '全て正しく入力済' do
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
        expect(@order_shipping.errors.full_messages).to include( "Post code can't be blank" )
      end
      it 'Postcodeハイフン無い' do
        @order_shipping.post_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Post code is invalid" )
      end
      it 'Prefecture未選択' do
        @order_shipping.prefecture_id = '1'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Prefecture must be other than 1" )
      end
      it 'city_town未記入' do
        @order_shipping.city_town = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "City town can't be blank" )
      end
      #address_2#
      it 'address_2未記入' do
        @order_shipping.address_2 = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Address 2 can't be blank" )
      end
      it 'tel未記入' do
        @order_shipping.tel = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Tel can't be blank" )
      end
      it 'tel ハイフン付き' do
        @order_shipping.tel = '090-0000-0000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Tel is invalid" )
      end
      it 'tel 10桁未満' do
        @order_shipping.tel = '012345678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Tel is invalid" )
      end
      it 'tel 12桁以上' do
        @order_shipping.tel = '012345678901'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Tel is invalid" )
      end
      it 'itemへの紐付きなし' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "Item can't be blank" )
      end
      it 'userへの紐付きなし' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include( "User can't be blank" )
      end






    end
  end
end

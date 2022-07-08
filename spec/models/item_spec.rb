require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品可能' do
      it '全て正しく入力されている' do
        expect(@item).to be_valid
      end
    end

    context '商品出品不可能' do
      # image#
      it 'imageが空欄' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      # name#
      it 'nameが空欄' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが41文字以上' do
        @item.name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end
      # explain#
      it 'explainが空欄' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end
      it 'explainが1001文字以上' do
        @item.explain = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('Explain is too long (maximum is 1000 characters)')
      end
      # category#
      it 'category未選択' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      # condition#
      it 'condition未選択(id = 1)' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      # shipping_cost#
      it 'shipping_cost未選択(id = 1)' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end
      # prefecture#
      it 'prefecture未選択(id = 1)' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      # shipping_time#
      it 'shipping_time未選択(id = 1)' do
        @item.shipping_time_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping time must be other than 1')
      end
      # price#
      it '300円未満' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 300')
      end
      it '10,000,000円以上' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 9999999')
      end
      it '半角数字以外で入力' do
        @item.price = 'aAａＡ１!あ亜アｱ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      # user紐づき#
      it 'userが紐付いていない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

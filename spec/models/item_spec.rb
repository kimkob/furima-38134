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
      it '商品画像が空欄' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を入力してください')
      end
      # name#
      it '商品名が空欄' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it '商品名が41文字以上' do
        @item.name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      # explain#
      it '商品説明が空欄' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it '商品説明が1001文字以上' do
        @item.explain = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end
      # category#
      it 'カテゴリー未選択' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      # condition#
      it '商品状態未選択(id = 1)' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      # shipping_cost#
      it '送料負担未選択(id = 1)' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      # prefecture#
      it '都道府県未選択(id = 1)' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      # shipping_time#
      it '発送時期未選択(id = 1)' do
        @item.shipping_time_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      # price#
      it '300円未満' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲にしてください')
      end
      it '10,000,000円以上' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲にしてください')
      end
      it '半角数字以外で入力' do
        @item.price = 'aAａＡ１!あ亜アｱ'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲にしてください')
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

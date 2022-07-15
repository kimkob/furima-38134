require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録不可' do
      # nickname#
      it 'ニックネーム必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      # email#
      it 'email必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'email一意性' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailが@を含む' do
        @user.email = 'testtesttest'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      # password#
      it 'password必須' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it '数字のみpasswordは登録不可' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '英字のみpasswordは登録不可' do
        @user.password = 'qwerty'
        @user.password_confirmation = 'qwerty'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it '全角passwordは登録不可' do
        @user.password = '1q2w３４'
        @user.password_confirmation = '1q2w３４'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは6文字以上' do
        @user.password = '1234q'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordとpassword_confirmationが一致' do
        @user.password_confirmation = '123456q'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      # Name#
      it 'family_name必須' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)を入力してください')
      end
      it 'first_name必須' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)を入力してください')
      end
      it 'family_kana必須' do
        @user.family_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)カナを入力してください')
      end
      it 'first_kana必須' do
        @user.first_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)カナを入力してください')
      end
      it 'family_nameが半角文字だと登録不可' do
        @user.family_name = 'テストa1!'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)は不正な値です')
      end
      it 'first_nameが半角文字なら登録不可' do
        @user.first_name = '哲夫a1!'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)は不正な値です')
      end
      it 'family_kanaが全角カタカナのみ登録可' do
        @user.family_kana = 'ｫa1!ａ１！鉄お'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)カナは不正な値です')
      end
      it 'first_kanaは全角カタカナのみ登録可' do
        @user.first_kana = 'ｫa1!ａ１！鉄お'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)カナは不正な値です')
      end

      # birthdya#
      it 'birthday必須' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end

    context '新規登録可能' do
      it '全て正しく入力されている' do
        expect(@user).to be_valid
      end
    end
  end
end

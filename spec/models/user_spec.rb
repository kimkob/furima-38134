require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録不可' do
      it 'nickname必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Nickname can't be blank" )
      end
      it 'email必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Email can't be blank" )
      end
      it 'email一意性' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include( "Email has already been taken" )
      end
      it 'emailが@を含む' do
        @user.email = 'testtesttest'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Email is invalid" )
      end
      it 'password必須' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password can't be blank" )
      end
      it 'passwordは6文字以上' do
        @user.password = '1234q'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password is too short (minimum is 6 characters)" )
      end
      it 'passwordとpassword_confirmationが一致' do
        @user.password_confirmation = '123456q'
        @user.valid?
        expect(@user.errors.full_messages).to include( "Password confirmation doesn't match Password" )
      end
      it 'birthday必須' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include( "Birthday can't be blank" )
      end



      context '新規登録可能' do
        it '全て正しく入力されている' do
          expect(@user).to be_valid
        end
        it 'passwordは半角英数字混合で登録可' do
          @user.password = '12345q'
          @user.password_confirmation = '12345q'
          expect(@user). to be_valid
        end
        it 'family_nameが全角なら登録可' do
          @user.family_name = 'テスト'
          expect(@user).to be_valid
        end
        it 'first_nameが全角なら登録可' do
          @user.first_name = '哲夫'
          expect(@user).to be_valid
        end
        it 'family_kanaは全角カタカナなら登録可' do
          @user.family_kana = 'テスト'
          expect(@user).to be_valid
        end
        it 'first_kanaは全角カタカナなら登録可' do
          @user.first_kana = 'テツオ'
          expect(@user).to be_valid
        end
       end
    end
  end
end

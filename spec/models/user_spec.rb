require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録不可' do
      #nickname#
        it 'nickname必須' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include( "Nickname can't be blank" )
        end
        
      #email#
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

      #password#
        it 'password必須' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include( "Password can't be blank" )
        end
        it '数字のみpasswordは登録不可' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include( "Password is invalid" )
        end
        it '英字のみpasswordは登録不可' do
          @user.password = 'qwerty'
          @user.password_confirmation = 'qwerty'
          @user.valid?
          expect(@user.errors.full_messages).to include( "Password is invalid" )
        end
        it '全角passwordは登録不可' do
          @user.password = '1q2w３４'
          @user.password_confirmation = '1q2w３４'
          @user.valid?
          expect(@user.errors.full_messages).to include( "Password is invalid" )
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

      #Name#
        it 'family_name必須' do
          @user.family_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include( "Family name can't be blank" )
        end
        it 'first_name必須' do
          @user.first_name =''
          @user.valid?
          expect(@user.errors.full_messages).to include( "First name can't be blank" )
        end
        it 'family_kana必須' do
          @user.family_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include( "Family kana can't be blank" )
        end
        it 'first_name必須' do
          @user.first_kana =''
          @user.valid?
          expect(@user.errors.full_messages).to include( "First kana can't be blank" )
        end
        it 'family_nameが半角文字だと登録不可' do
          @user.family_name = 'テストa1!'
          @user.valid?
          expect(@user.errors.full_messages).to include( "Family name is invalid" )
        end
        it 'first_nameが半角文字なら登録不可' do
          @user.first_name = '哲夫a1!'
          @user.valid?
          expect(@user.errors.full_messages).to include( "First name is invalid" )
        end
        it 'family_kanaが全角カタカナのみ' do
          @user.family_kana = 'ｫa1!ａ１！鉄お'
          @user.valid?
          expect(@user.errors.full_messages).to include( "Family kana is invalid" )
        end
        it 'first_kanaは全角カタカナのみ登録可' do
          @user.first_kana = 'ｫa1!ａ１！鉄お'
          @user.valid?
          expect(@user.errors.full_messages).to include( "First kana is invalid" )
        end

      #birthdya#
        it 'birthday必須' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include( "Birthday can't be blank" )
        end



      context '新規登録可能' do
        it '全て正しく入力されている' do
          expect(@user).to be_valid
        end
        
       end
    end
  end
end

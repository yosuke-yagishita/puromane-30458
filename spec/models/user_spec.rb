require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '値が正しく存在すれば登録できること' do
        expect(@user).to be_valid
      end
      it 'emailに＠が含まれていれば登録できること' do
        @user.email = 'a@a'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数字であれば登録できること' do
        @user.password = 'Abc123'
        @user.password_confirmation = 'Abc123'
        expect(@user).to be_valid
      end
    end

    context '新規登録が出来ないとき' do
      it 'nicknameが空だと登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")  
      end
      it 'family_nameが空だと登録できないこと' do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")  
      end
      it 'first_nameが空だと登録できないこと' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")  
      end
      it 'emailが空だと登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")  
      end
      it 'emailに@が無いと登録できないこと' do
        @user.email = 'email'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")  
      end
      it '重複したemailでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'password が空だと登録できないこと' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")  
      end
      it 'passwordが全角文字だと登録できないこと' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be full-width characters")  
      end
      it 'passwordが特殊文字では登録できないこと' do
        @user.password = '!!!!!!'
        @user.password_confirmation = '!!!!!!'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be full-width characters")  
      end
      it 'passwordは6文字以上の入力がないと登録できないこと' do
        @user.password = 'abc45'
        @user.password_confirmation = 'abc45'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")  
      end
      it 'passwordは確認用含めて２回入力しないと登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")  
      end
      it 'passwordとpassword_confirmationが一致しないと登録できないこと' do
        @user.password = 'abc123'
        @user.password_confirmation = 'ABC123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")  
      end
    end
  end
end
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての情報が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emaiは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが英数混合でないと登録できない' do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが英字のみであると登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it 'passwordが全角文字が含まれていると登録できない' do
        @user.password = 'ａbcdefg'
        @user.password_confirmation = 'ａbcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'first_nameに半角文字が含まれていると登録できない' do
        @user.first_name = '山田a'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前が不正な値です。全角文字で入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'last_nameに半角文字が含まれていると登録できない' do
        @user.last_name = '太郎a'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字が不正な値です。全角文字で入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カタカナ)を入力してください")
      end
      it 'first_name_kanaのフリガナは全角（カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'aiueo'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カタカナ)が不正な値です。全角カタカナで入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カタカナ)を入力してください")
      end
      it 'last_name_kanaのフリガナは全角（カタカナ）でなければ登録できない' do
        @user.last_name_kana = 'aiueo'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カタカナ)が不正な値です。全角カタカナで入力してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end

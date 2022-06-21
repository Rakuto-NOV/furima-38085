require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @item_form = FactoryBot.build(:item_form, user_id: user.id, item_id: item.id)
    sleep 0.1
  end
  context '内容に問題がない場合' do
    it 'tokenと住所情報等が適切に入力されていれば購入できる' do
      expect(@item_form).to be_valid
    end
    it '建物名は空でも購入できる' do
      @item_form.building_name = nil
      expect(@item_form).to be_valid
    end
  end
  context '内容に問題がある場合' do
    it '郵便番号が空だと購入できない' do
      @item_form.post_code = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("Post code can't be blank")
    end
    it '郵便番号がハイフンなしだと購入できない' do
      @item_form.post_code = 1_111_111
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Post code Input correctly')
    end
    it '郵便番号が全角文字だと購入できない' do
      @item_form.post_code = '１１１−１１１'
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Post code Input correctly')
    end
    it '都道府県が未選択だと購入できない' do
      @item_form.prefecture_id = 1
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Prefecture Select')
    end
    it '市区町村が空だと購入できない' do
      @item_form.city = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("City can't be blank")
    end
    it '番地が空だと購入できない' do
      @item_form.address = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("Address can't be blank")
    end
    it '電話番号が空だと購入できない' do
      @item_form.phone_number = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号が10桁未満だと購入できない' do
      @item_form.phone_number = 123456789
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
    it '電話番号が12桁以上だと購入できない' do
      @item_form.phone_number = 123456789012
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
    it '電話番号がハイフンありだと購入できない' do
      @item_form.phone_number = 1234 - 567 - 890
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
    it '電話番号が全角数字だと購入できない' do
      @item_form.phone_number = '１２３４５６７８９０'
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
    it 'トークンが生成されないと購入できない' do
      @item_form.token = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("Token can't be blank")
    end
    it 'ユーザーが紐付いていなければ投稿できない' do
      @item_form.user_id = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("User can't be blank")
    end
    it '商品が紐付いていなければ投稿できない' do
      @item_form.item_id = nil
      @item_form.valid?
      expect(@item_form.errors.full_messages).to include("Item can't be blank")
    end
  end
end

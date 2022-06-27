require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品情報入力' do
    context '商品情報ができる場合' do
      it '全ての情報が正しく存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品情報の入力がうまく行かない時' do
      it '商品画像が空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーが未選択です")
      end
      it '商品の状態が未選択だと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態が未選択です")
      end
      it '配送料の負担が未選択だと出品できない' do
        @item.cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担が未選択です")
      end
      it '発送元の地域が未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域が未選択です")
      end
      it '発送までの日数が未選択だと出品できない' do
        @item.arrival_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数が未選択です")
      end
      it '販売価格が空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '販売価格が300未満だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end
      it '販売価格が10000000以上だと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end
      it '販売価格が全角数字だと出品できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("ユーザーを入力してください")
      end
    end
  end
end

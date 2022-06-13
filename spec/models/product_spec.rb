require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end
  describe '商品情報入力' do
    context '商品情報ができる場合' do
      it '全ての情報が正しく存在すれば出品できる' do
        expect(@product).to be_valid
      end
    end
    context '商品情報の入力がうまく行かない時' do
      it '商品画像が空だと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空だと出品できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空だと出品できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it '商品の状態が未選択だと出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it '配送料の負担が未選択だと出品できない' do
        @product.cost_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Cost can't be blank")
      end
      it '発送元の地域が未選択だと出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が未選択だと出品できない' do
        @product.arrival_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Arrival can't be blank")
      end
      it '発送までの日数が未選択だと出品できない' do
        @product.arrival_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Arrival can't be blank")
      end
      it '販売価格が空だと出品できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が300未満だと出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '販売価格が10000000以上だと出品できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '販売価格が全角数字だと出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end

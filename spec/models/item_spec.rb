# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての値が正しく存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が添付されていないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが未選択（idが1）だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category can\'t be blank')
      end

      it '商品の状態が未選択（idが1）だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition can\'t be blank')
      end

      it '配送料の負担が未選択（idが1）だと出品できない' do
        @item.postage_type_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage type can\'t be blank')
      end

      it '発送元の地域が未選択（idが1）だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture can\'t be blank')
      end

      it '発送までの日数が未選択（idが1）だと出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day can\'t be blank')
      end

      it '価格が空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300円未満だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が半角数字以外を含むと出品できない（例：全角数字）' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '価格が英数字混合だと出品できない' do
        @item.price = '1000a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '価格が半角英字のみだと出品できない' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'ユーザーが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

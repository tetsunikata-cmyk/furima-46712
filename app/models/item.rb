class Item < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage_type
  belongs_to :prefecture
  belongs_to :shipping_day

  # 必須項目のバリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
  end

  # ActiveHash（「---」＝ id:1 を選べないようにする）
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :postage_type_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  # 価格の範囲・整数チェック
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            },
            allow_blank: true
end

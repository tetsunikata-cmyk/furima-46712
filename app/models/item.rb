class Item < ApplicationRecord
  belongs_to :user
   # 画像は ActiveStorage を使う
  has_one_attached :image

  # ActiveHash を使うカラム（あとでファイルを作る）
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to :category
  # belongs_to :condition
  # belongs_to :postage_type
  # belongs_to :prefecture
  # belongs_to :shipping_day
end

class OrderAddress
  
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address,
                :building, :phone_number, :token, :user_id, :item_id

  # =========================
  # バリデーション
  # =========================

  # presence: true をまとめてかけるグループ
  with_options presence: true do
  
    validates :postal_code, format: {
      with: /\A\d{3}-\d{4}\z/,
      message: 'is invalid. Include hyphen(-)'
    }

    # 市区町村・番地・電話番号・token・user_id・item_id はとにかく必須
    validates :city
    validates :address
    validates :phone_number, format: {
      with: /\A\d{10,11}\z/,
      message: 'is invalid'
    }
    validates :token
    validates :user_id
    validates :item_id
  end

  # 都道府県（ActiveHash）：1（---）は選べないように
  validates :prefecture_id, numericality: {
    other_than: 1,
    message: "can't be blank"
  }

  # building は任意なのでバリデーション不要

  # =========================
  # DB保存処理
  # =========================
  def save
    # ① 購入情報を orders テーブルに保存
    order = Order.create(user_id: user_id, item_id: item_id)

    # ② 住所情報を addresses テーブルに保存
    Address.create(
      postal_code:   postal_code,
      prefecture_id: prefecture_id,
      city:          city,
      address:       address,
      building:      building,
      phone_number:  phone_number,
      order_id:      order.id
    )
  end
end
FactoryBot.define do
  factory :item do
    name              { 'テスト商品' }
    description       { 'これはテスト用の商品説明です' }
    category_id       { 2 } # --- 以外
    condition_id      { 2 }
    postage_type_id   { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }
    price             { 1000 }

    association :user

    after(:build) do |item|
      # public/images/test_image.png が必要！
      item.image.attach(
        io: File.open(Rails.root.join('public/images/test_image.png')),
        filename: 'test_image.png'
      )
    end
  end
end

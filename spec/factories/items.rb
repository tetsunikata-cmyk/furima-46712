FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    category_id { 1 }
    condition_id { 1 }
    postage_type_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    price { 1 }
    user { nil }
  end
end

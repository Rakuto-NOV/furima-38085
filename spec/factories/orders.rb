FactoryBot.define do
  factory :order do
    association :user
    association :item
    association :shipping_address
  end
end

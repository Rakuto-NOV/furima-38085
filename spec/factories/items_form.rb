FactoryBot.define do
  factory :item_form do
    token         { 'tok_abcdefghijk00000000000000000' }
    post_code     { '111-1111' }
    prefecture_id { 2 }
    city          { '市区町村' }
    address       { '番地' }
    building_name { '建物' }
    phone_number { '0000000000' }
    # association :user
    # association :item
    # association :shipping_address
  end
end

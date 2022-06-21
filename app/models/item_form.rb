class ItemForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  # バリデーション
  with_options presence: true do
    validates :user_id, :item_id, :city, :address, :token
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'Input correctly' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                           building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :arrival
  has_one_attached :image
  belongs_to :user
  has_one    :order

  validates :image, :name, :description, :category_id, :status_id, :cost_id, :prefecture_id, :arrival_id, :price,
            presence: true
  validates :category_id, :status_id, :cost_id, :prefecture_id, :arrival_id,
            numericality: { other_than: 1, message: "が未選択です" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
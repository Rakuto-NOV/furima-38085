class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

 validates :nickname, presence: true
 validates :last_name, presence: true
 validates :first_name, presence: true
 validates :last_name_kana, presence: true
 validates :first_name_kana, presence: true
 validates :birth_day, presence: true
 validates :password, format: { with: VALID_PASSWORD_REGEX, message: "Password No alphanumeric mixture"}

 has_many :products
 has_many :purchase_histories
end

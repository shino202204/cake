class Customer < ApplicationRecord
  has_many :cart_items
  has_many :addresses
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def address_display
    '〒' + postal_code + ' ' + address
  end
end

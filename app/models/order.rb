class Order < ApplicationRecord
  # 支払方法 0:クレジットカード, 1:銀行振込
  enum payment_method: {credit_card: 0, transfer: 1}

  # アソシエーション
  belongs_to :customer

  def order_display
    '〒' + postal_code + ' ' + address
  end
end

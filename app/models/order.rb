class Order < ApplicationRecord
  # 支払方法 0:クレジットカード, 1:銀行振込
  enum payment_method: {credit_card: 0, transfer: 1}
  # 注文ステータス 0:入金待ち, 1:入金, 2:製作中, 3:発送準備中, 4:発送済み
  enum status: {awaiting_payment: 0, payment_confirmation: 1, under_manufacture: 2, preparing_to_ship: 3, shipped: 4}

  # アソシエーション
  belongs_to :customer
  has_many :order_details

  def order_display
    '〒' + postal_code + ' ' + address + '' + name
  end
end

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

  def order_confirm
    '〒' + postal_code + ' ' + address
  end

  # 支払方法
  def return_payment_method
    result = ''
    if payment_method == 'credit_card'
      result = Order.payment_methods_i18n[:credit_card]
    elsif payment_method == 'transfer'
      result = Order.payment_methods_i18n[:transfer]
    end
    return result
  end

  # 注文ステータス
  def return_status
    result = ''
    if status == 'awaiting_payment'
      result = Order.statuses_i18n[:awaiting_payment]
    elsif status == 'payment_confirmation'
      result = Order.statuses_i18n[:payment_confirmation]
    elsif status == 'under_manufacture'
      result = Order.statuses_i18n[:under_manufacture]
    elsif status == 'preparing_to_ship'
      result = Order.statuses_i18n[:preparing_to_ship]
    elsif status == 'shipped'
      result = Order.statuses_i18n[:shipped]
    end
    return result
  end
end

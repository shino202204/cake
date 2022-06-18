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

  # 支払方法
  def return_payment_method
    if payment_method == 'credit_card'
      payment_method = Order.payment_methods_i18n[:credit_card]
    elsif status == 'transfer'
      payment_method = Order.payment_methods_i18n[:transfer]
    else
    end
    return payment_method
  end

  # 注文ステータス
  def return_status
    if status == 'awaiting_payment'
      status = Order.statuses_i18n[:awaiting_payment]
    elsif status == 'payment_confirmation'
      status = Order.statuses_i18n[:payment_confirmation]
    elsif status == 'under_manufacture'
      status = Order.statuses_i18n[:under_manufacture]
    elsif status == 'preparing_to_ship'
      status = Order.statuses_i18n[:preparing_to_ship]
    elsif status == 'shipped'
      status = Order.statuses_i18n[:shipped]
    else
    end
    return status
  end
end

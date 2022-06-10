class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @main_address = current_customer.address
    # @main_address = current_customer.address.address_display
    # @main_address = Address.find_by(customer_id: current_customer.id)
  end

  def confirm
    puts 'confirmアクションに到達しました'
    # ユーザーのカートアイテム情報
    @cart_items = current_customer.cart_items.all
    @total_payment = 0
    @shipping_cost = 800
  end

  def complete
  end

  def index
  end

  def show
  end
end
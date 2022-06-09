class Public::OrdersController < ApplicationController
  def new
    @main_address = current_customer.address
    # @main_address = current_customer.address.address_display
    # @main_address = Address.find_by(customer_id: current_customer.id)
  end

  def confirm
    puts 'confirmアクションに到達しました'
  end

  def complete
  end

  def index
  end

  def show
  end
end

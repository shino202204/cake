class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @main_address = current_customer.address_display
    # @main_address = current_customer.address.address_display
    # @main_address = Address.find_by(customer_id: current_customer.id)
  end

  def confirm
    puts 'confirmアクションに到達しました'
    # ユーザーのカートアイテム情報
    @cart_items = current_customer.cart_items.all
    @total_payment = 0
    @shipping_cost = 800

    @order = Order.new(order_params)

    select_address = params[:order][:select_address]
    puts "選択された住所の数値は#{select_address}です"

    if select_address == '0'
      puts 'メイン住所が選択されました'
      # 自身の住所が選択された場合
      # 上記パラメータで取得した「新しいお届け先」の情報を書き換える
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif select_address == '1'
      puts '登録済み住所が選択されました'
      # 登録済み住所が選択された場合
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end

    # 支払方法
    @payment_method = ''
    if @order.payment_method == 'credit_card'
      @payment_method = Order.payment_methods_i18n[:credit_card]
    elsif @order.payment_method == 'transfer'
      @payment_method = Order.payment_methods_i18n[:transfer]
    end

    # binding.pry #追記する
  end

  def create
    # 確認用
    puts 'createアクションに到達しました'
    puts "注文者は#{current_customer.last_name + current_customer.first_name}です"
    puts "配送先は#{params[:order][:postal_code]}です"
    puts "配送先は#{params[:order][:address]}です"
    puts "配送先は#{params[:order][:name]}です"
    puts "送料は#{params[:order][:shipping_cost]}です"
    puts "請求額は#{params[:order][:total_payment]}です"
    puts "支払方法は#{params[:order][:payment_method]}です"


    # 注文(Order)モデルに注文内容を保存
    @order = Order.new

    if params[:order][:payment_method] == 'クレジットカード'
      puts "登録する値は0です"
      @order.payment_method = 0
      # params[:order][:payment_method] = 0
    elsif params[:order][:payment_method] == '銀行振込'
      puts "登録する値は1です"
      @order.payment_method = 1
    end

    binding.pry #追記する

    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      puts "注文idは直前でsaveしたインスタンスのidを登録します"
      puts "注文者のカートには#{cart_item.item.name}があります"
      puts "商品idは#{cart_item.item.id}です"
      puts "税込価格は#{cart_item.item.with_tax_price}です"
      puts "数量は#{cart_item.amount}です"
    end

    render :complete
  end


  def complete
    puts 'completeアクションに到達しました'
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end
end

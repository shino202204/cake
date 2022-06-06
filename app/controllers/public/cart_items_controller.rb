class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total_payment = 0
  end

  def create
    # @cart_item = CartItem.new(cart_item_params)
    # if current_customer.cartitems.find_by(item_id: cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      flash[:notice] = "CartItem was successfully created."
      redirect_to cart_items_path
    else
      render :index
    end

    # ログインユーザのカート情報
    cart_items = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    # 追加商品がカート内に存在する場合
    if cart_items != nil
      # 指定した数量を追加する
    else
      # 新規作成する
    end
  end

  def destroy_all
    puts "destroy_allメソッドに到達しました"
    if current_customer.cart_items.destroy_all
      flash[:notice] = "CartItem was successfully destroyed."
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.item_id == '0'
      puts "カートを空にします"
      render :index
    else
      puts "destroyメソッドに到達しました"
      @cart_items = CartItem.all
      @total_payment = 0
      render :index
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

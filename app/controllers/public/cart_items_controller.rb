class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
    @cart_items = CartItem.all
    @total_payment = 0
  end

  def create
    # ログインユーザのカート情報
    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
    # 追加商品がカート内に存在する場合
    if cart_item != nil
      # 指定した数量を追加する
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      flash[:notice] = "CartItem was successfully updated."
      redirect_to cart_items_path
    # 存在しなかった場合
    else
      # 新規作成する
      @cart_item = CartItem.new(cart_item_params)
      if @cart_item.save
        flash[:notice] = "CartItem was successfully created."
        redirect_to cart_items_path
      else
        render :index
      end
    end
  end

  def update
    puts "updateアクションに到達しました"
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "CartItem was successfully updated."

    @cart_items = CartItem.all
    @total_payment = 0
    redirect_to cart_items_path
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
    puts "destroyメソッドに到達しました"
    puts "カートidは#{params[:id]}です"
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "CartItem was successfully destroyed."

    @cart_items = CartItem.all
    @total_payment = 0
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

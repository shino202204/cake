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

  # def destroy

  # end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end

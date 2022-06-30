class Public::ItemsController < ApplicationController
  def index
    # @items = Item.all
    # 販売中のみ取得
    @items = Item.where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end

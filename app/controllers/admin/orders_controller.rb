class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    puts "注文ステータスのupdateアクションです"
    puts "受け取ったパラメータは#{params[:order][:status]}です"
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    render :show
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

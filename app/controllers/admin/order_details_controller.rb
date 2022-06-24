class Admin::OrderDetailsController < ApplicationController
  def update
    puts "order_detailsのupdateアクションです"

    # @order = Order.find(params[:id])
    # @order_details = OrderDetail.where(order_id: @order.id)
    # render 'admin/orders/show'

    # パラメータ取得
    puts "受け取った製作パラメータは#{params[:order_detail][:making_status]}です"

    redirect_to admin_order_path
    # redirect_to root_path
  end

  # private

  # def order_detail_params
  #   params.require(:order_detail).permit(:making_status)
  # end
end

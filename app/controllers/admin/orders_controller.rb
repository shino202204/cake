class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    puts "注文ステータスのupdateアクションです"
    puts "受け取った受注パラメータは#{params[:order][:status]}です"
    puts "受け取った製作パラメータは#{params[:order_detail][:making_status]}です"
    # パラメータを取得
    @status = params[:order][:status]
    # 注文(Order)を取得
    @order = Order.find(params[:id])
    # 注文詳細（OrderDetail）を取得
    @order_details = OrderDetail.where(order_id: @order.id)

    # 注文の受注ステータスが入金確認（1）の場合
    if @status == 1
      @order.update(status: 1)
      # 紐づく注文詳細の製作ステータスを製作待ち（1）へ更新
      @order_details.each do |order_detail|
        order_detail.update(making_status: 1)
      end
    end
    render :show
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

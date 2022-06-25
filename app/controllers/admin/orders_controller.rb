class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    puts "注文ステータスのupdateアクションです"
    puts "受け取った受注パラメータは#{params[:order][:status]}です"

    # パラメータを取得
    @status = params[:order][:status]
    puts "製作パラメータは#{@status}です"
    # 注文(Order)を取得
    @order = Order.find(params[:id])
    # 注文詳細（OrderDetail）を取得
    @order_details = OrderDetail.where(order_id: @order.id)

    # 注文ステータスが入金確認（1）
    if @status.to_i == 1
      @order.update(status: 1)
      puts"注文ステータスを入金確認にしました"
      # 紐づく注文詳細の製作ステータスを製作待ち（1）へ更新
      @order_details.each do |order_detail|
        order_detail.update(making_status: 1)
      end
    end

    # 注文ステータスが発送済み（4）
    if @status.to_i == 4
      @order.update(status: 4)
      puts"注文ステータスを発送済みにしました"
    end

    render :show
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

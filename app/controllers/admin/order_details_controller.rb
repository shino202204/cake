class Admin::OrderDetailsController < ApplicationController
  def update
    # 確認用
    puts "order_detailsのupdateアクションです"
    puts "受け取った製作パラメータは#{params[:order_detail][:making_status]}です"
    puts "受け取ったorder_detailのidは#{params[:id]}です"

    # Orderのidを取得
    @order_id = OrderDetail.find(params[:id]).order_id
    puts "注文idは#{@order_id}です"

    # 注文と注文詳細を取得
    @order = Order.find(@order_id)
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)

    # 製作ステータスを更新
    @making_status = params[:order_detail][:making_status]
    puts "製作ステータスは#{@making_status}です"

    # 製作中
    if @making_status.to_i == 2
      @order_detail.update(making_status: 2)
      flash[:notice] = "製作ステータスを更新しました"
      # 注文ステータスを製作中に更新
      if @order.status != 2
        @order.update(status: 2)
      end
    end
    # 製作完了
    if @making_status.to_i == 3
      @order_detail.update(making_status: 3)
      flash[:notice] = "製作ステータスを更新しました"
    end

    # 製作ステータスが全て「製作完了」の場合、
    # 注文ステータスを「発送準備中」にする。
    puts "全レコード数は#{@order_details.count}です"
    puts "製作完了のレコード数は#{@order_details.where(making_status: 3).count}です"
    all_count = @order_details.count
    completion_count = @order_details.where(making_status: 3).count

    if all_count == completion_count
      puts "注文ステータスを発送準備中にします"
      @order.update(status: 3)
      flash[:notice] = "注文・製作ステータスを更新しました"
    end

    # 注文履歴詳細に遷移
    render 'admin/orders/show'
  end

  # private

  # def order_detail_params
  #   params.require(:order_detail).permit(:making_status)
  # end
end

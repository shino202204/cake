class Admin::OrderDetailsController < ApplicationController
  def update
    puts "order_detailsのupdateアクションです"
    # render :admin_order_path
    redirect_to admin_order_path
    # redirect_to root_path
  end
end

class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:notice] = "Customer was successfully updated."
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    # 確認用
    puts "withdrawアクションです"
    puts "受け取ったパラメータは#{params[:is_deleted]}です"
    # パラメータ取得
    param = params[:is_deleted]
    # 会員情報を取得
    customer = Customer.find(current_customer.id)

    # 退会フラグを更新
    if customer.is_deleted == true
      puts "既に退会処理済みです"
      render :unsubscribe
    elsif customer.is_deleted == false
      # customer.is_deleted = true
      customer.update(is_deleted: true)
      puts "退会フラグを立てました"
      reset_session
      redirect_to root_path
    else
      puts "値が不正です"
    end

  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end

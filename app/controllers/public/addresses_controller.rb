class Public::AddressesController < ApplicationController
  def index
    puts "indexアクションへ到達しました"
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
    # @addresses = Address.all
  end

  def create
    address = Address.new(address_params)
    @addresses = Address.all
    if address.save
      flash[:notice] = "Address was successfully created."
      redirect_to addresses_path
    else
      render :index
    end
  end

  def edit
    puts "editアクションへ到達しました"
    @address = Address.find(params[:id])
  end

  def update
    puts "updateアクションへ到達しました"
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "Address was successfully updated."
      redirect_to addresses_path
    else
      render :edit
    end

  end

  def destroy
    puts "destroyメソッドに到達しました"
    puts "アドレスidは#{params[:id]}です"
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = "Address was successfully destroyed."

    @addresses = Address.all
    @address = Address.new
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :customer_id)
  end
end

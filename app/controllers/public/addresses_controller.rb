class Public::AddressesController < ApplicationController
  def index
    puts "indexアクションへ到達しました"
    @address = Address.new
    @addresses = Address.all
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
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name, :customer_id)
  end
end

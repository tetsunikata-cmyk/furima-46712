class OrdersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_item

  before_action :redirect_if_invalid_user_or_sold_out

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      # 決済処理（Payjp）はここにあとで書く → pay_item
      # pay_item

      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:order_address)
          .permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(
            user_id: current_user.id,
            item_id: @item.id,
            token: params[:token]
          )
  end

  def redirect_if_invalid_user_or_sold_out
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

  # def pay_item
  #   # ここにあとで Payjp の処理を書いて、token を使って決済する
  # end
end
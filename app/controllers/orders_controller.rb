class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index,:create]
  before_action :move_to_index, only: [:index,:create]

  def index
    @order_shipping = OrderShipping.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city_town, :address_2, :address_1, :tel ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.order.present? || (current_user.id == @item.user_id)
      redirect_to root_path 
    end
  end

end

class OrdersController < ApplicationController
#  before_action :authenticate_user!, only: [:create]

  def index
    @order_shipping = OrderShipping.new
    @item = Item.find(params[:item_id])
  end

  def create
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
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city_town, :address_2, :address_1, :tel, :item_id ).merge(user_id: current_user.id)
  end

end

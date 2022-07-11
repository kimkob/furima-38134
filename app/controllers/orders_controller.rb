class OrdersController < ApplicationController
#  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
  end

  def create
#    @order = Order.new(order_params)
#    if @oder.valid?
#      @order.save
#      return redirect_to root_path
#    else
#      render :index
#    end
  end

  private

#  def order_params
#    params.require(:order).merge(user_id: current_user.id, item_id: params[:item_id])
#  end

end

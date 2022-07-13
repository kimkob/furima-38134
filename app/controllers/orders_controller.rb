class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  before_action :item_set, onpy: [:index, :create, :move_to_index]

  def index
    @order_shipping = OrderShipping.new
    item_set
  end

  def create
    item_set
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_set
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city_town, :address_2, :address_1, :tel).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def move_to_index
    item_set
    redirect_to root_path if @item.order.present? || (current_user.id == @item.user_id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end

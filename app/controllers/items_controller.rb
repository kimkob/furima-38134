class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end


  private

#  def itame_params
#    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
end

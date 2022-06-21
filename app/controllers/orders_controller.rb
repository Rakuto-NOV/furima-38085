class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(order_params)
    if @item_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @item_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:item_form).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end


  def move_to_index
    redirect_to root_path if @item.order.present? || current_user == @item.user
  end
end

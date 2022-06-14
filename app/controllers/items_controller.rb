class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :status_id, :cost_id, :prefecture_id, :arrival_id, :price,
                                    :image).merge(user_id: current_user.id)
  end
end

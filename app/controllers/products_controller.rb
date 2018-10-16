class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id,
                                    :condition_id, :negotiation, :price,
                                    :photo)
  end
end

class ProductsController < ApplicationController
  def show
    id = params[:id]
    @product = Product.find(id)
  end
end

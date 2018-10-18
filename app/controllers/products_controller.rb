class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :verify_user_product, only: %i[edit update destroy]

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
      flash[:success] = 'Produto editado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = 'Produto apagado com sucesso'
    redirect_to root_path
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

  def verify_user_product
    redirect_to root_path unless @product.user.eql? current_user
  end
end

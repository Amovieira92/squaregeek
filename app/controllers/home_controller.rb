class HomeController < ApplicationController
  def index
    return @products = Product.all unless search_params
    @products = Product.where('title like :kw or description like :kw',
                              kw: search_params)
  end

  private

  def search_params
    "%#{params[:key_word]}%"
  end
end

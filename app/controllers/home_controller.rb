class HomeController < ApplicationController
  # before_action: search_params
  def index
    key_word = params[:key_word]
    if key_word.nil?
      @products = Product.all
    else
      key_word = "%#{key_word}%"
      @products = Product.where('title like :kw or description like :kw',
                                kw: key_word)
    end
  end

  private

  def search_params
    params[:key_word]
  end
end

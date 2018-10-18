require 'rails_helper'

describe ProductsController, type: :request do
  it 'delete successfully' do
    product = create(:product)

    sign_in(product.user)
    delete "/products/#{product.id}"

    expect(Product.find_by(id: product.id)).to eq nil
  end

  it 'delete not allowed' do
    product = create(:product)
    delete "/products/#{product.id}"

    product.reload
    expect(product.persisted?).to eq true
  end
end

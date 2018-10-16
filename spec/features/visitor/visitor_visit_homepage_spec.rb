require 'rails_helper'

feature 'visitor visit home page' do
  scenario 'successfully' do
    visit root_path
    product = Product.create(title: 'HQ do Batman: Knight Fall', description: 'Rara HQ do Batman em ótimo estado de conservação')
    within '.product' do
      expect(page).to have_content(product.title)
      expect(page).to have_content(product.description)
    end
  end
end

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

  scenario 'and view products details' do
    category = Category.create()
    product = Product.create(title: 'HQ do Batman: Knight Fall', description: 'Rara HQ do Batman em ótimo estado de conservação', 
                              category: category, price: '1000,00', photo: , condition:,  )
    
    visit root_path
    
    click_on product.title

    expect(current_path).to eq product_path
    expect(page).to have.css('h3', text: 'HQ do Batman: Knight Fall')
    expect(page).to have.css('li', text: 'Rara HQ do Batman em ótimo estado de conservação')
    expect(page).to have.css('li', text: '')
    expect(page).to have.css('li', text: '')
    expect(page).to have.css('li', text: '')


  end

  scenario '' do
    second_product = Product.create(title: 'Coletânea DVD StarWars', description: 'Todos os oito filmes em bom estado')
    third_product = Product.create(title: 'NFS Most Wanted - PC', description: 'Raríssimo jogo de carro')
    fourst_product = Product.create(title: 'R2D2', description: 'Brinquedo em lego de 35 centímetros em ótimo estado')
  end
end 


require 'rails_helper'

feature 'Visitor search product' do
  scenario 'successfully' do
    movie_category = Category.create(name: 'Filmes')
    hq_category = Category.create(name: 'HQs')
    toy_category = Category.create(name: 'Brinquedos')

    condition = Condition.create(name: 'Conservado')

    first_product = Product.create(title: 'A morte do Superman',
                                   description: 'Animação clássica de 1999',
                                   category: movie_category, price: '30,00',
                                   condition: condition, negotiation: :both)

    second_product = Product.create(title: 'A morte do Superman',
                                    description: 'HQ clássica de 1999',
                                    category: hq_category, price: '50,00',
                                    condition: condition, negotiation: :sale)

    third_product = Product.create(title: 'HQ do Batman: Knight Fall',
                                  description: 'Rara HQ do Batman',
                                  category: hq_category, price: '1000,00',
                                  condition: condition, negotiation: :trade)
   
    fourth_product = Product.create(title: 'Robô megazord',
                                    description: 'Robô megazord lego',
                                    category: toy_category, price: '500,00',
                                    condition: condition, negotiation: :both)

    visit root_path

    within('div#busca') do
      fill_in 'Buscar por palavra-chave', with: 'superman'
      click_on 'Buscar'
    end

    expect(current_path).to eq: root_path

    expect(page).to have_css('h5', text: first_product.title)
    expect(page).to have_css('p', text: first_product.description)

    expect(page).to have_css('h5', text: second_product.title)
    expect(page).to have_css('p', text: another_product.description,
                                  class: 'card-text')
  end
end

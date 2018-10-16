require 'rails_helper'

feature 'visitor visit home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Bem vindo ao Square Geek')
  end

  scenario 'and view some products on home page' do
    category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Bom estado')

    product = Product.create(title: 'HQ do Batman: Knight Fall',
                             description: 'Rara HQ do Batman bem conservada',
                             category: category, price: '1000,00',
                             condition: condition, negotiation: :trade)

    another_product = Product.create(title: 'Robô megazord',
                                     description: 'Robô megazord lego',
                                     category: category, price: '500,00',
                                     condition: condition, negotiation: :both)

    visit root_path

    expect(page).to have_css('h5', text: product.title,
                                   class: 'card-title')
    expect(page).to have_css('p', text: product.description,
                                  class: 'card-text')

    expect(page).to have_css('h5', text: another_product.title,
                                   class: 'card-title')
    expect(page).to have_css('p', text: another_product.description,
                                  class: 'card-text')
  end

  scenario 'and view product details' do
    category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Bom estado')

    product = Product.create(title: 'HQ do Batman: Knight Fall',
                             description: 'Rara HQ do Batman bem conservada',
                             category: category, price: '1000,00',
                             condition: condition, negotiation: :trade)

    visit root_path
    click_on product.title

    expect(page).to have_css('h1', text: product.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: product.description)
    expect(page).to have_css('h3', text: 'Categoria')
    expect(page).to have_css('p', text: product.category.name)
    expect(page).to have_css('h3', text: 'Preço')
    expect(page).to have_css('p', text: 'R$ 1.000,00')
    expect(page).to have_css('h3', text: 'Condição')
    expect(page).to have_css('p', text: product.condition.name)
    expect(page).to have_css('h3', text: 'Negociação')
    expect(page).to have_css('p', text: 'Troca')
  end
end

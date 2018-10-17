require 'rails_helper'

feature 'visitor visit home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Bem vindo ao Square Geek')
  end

  scenario 'and view one product on home page' do
    category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Bom estado')

    product = Product.create(title: 'HQ do Batman: Knight Fall',
                             description: 'Rara HQ do Batman bem conservada',
                             category: category, price: '1000,00',
                             condition: condition, negotiation: :trade,
                             photo: File.new(Rails.root.join('spec', 'support',
                                                    'knightfall.jpg')))

    visit root_path
    within '#card-product1' do
      expect(page).to have_css("//img[@src*='knightfall.jpg']")
      expect(page).to have_css('h5', text: product.title, class: 'card-title')
      expect(page).to have_css('p', text: 'Troca', class: 'card-text')
      expect(page).to have_css('p', text: 'R$ 1.000,00', class: 'card-text')
    end
  end

  scenario 'and view product list on home page' do
    category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Bom estado')

    product = Product.create(title: 'HQ do Batman: Knight Fall',
                             description: 'Rara HQ do Batman bem conservada',
                             category: category, price: '1000,00',
                             condition: condition, negotiation: :trade,
                             photo: File.new(Rails.root.join('spec', 'support',
                                                    'knightfall.jpg')))

    another_product = Product.create(title: 'Robô megazord',
                                     description: 'Robô megazord lego',
                                     category: category, price: '500,00',
                                     condition: condition, negotiation: :both,
                                     photo: File.new(Rails.root.join('spec',
                                                                      'support',
                                                                      'megazord_lego_leproso.jpg')))

    visit root_path

    within '#card-product1' do
      expect(page).to have_css("//img[@src*='knightfall.jpg']") 
      expect(page).to have_css('h5', text: 'HQ do Batman: Knight Fall')
      expect(page).to have_css('p', text: 'Troca')
      expect(page).to have_css('p', text: 'R$ 1.000,00')
    end

    within '#card-product2' do
      expect(page).to have_css("//img[@src*='megazord_lego_leproso.jpg']") 
      expect(page).to have_css('h5', text: 'Robô megazord')
      expect(page).to have_css('p', text: 'Troca e Venda')
      expect(page).to have_css('p', text: 'R$ 500,00')
    end
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

  scenario 'and back to home page after view product details' do
    category = Category.create(name: 'HQs')

    condition = Condition.create(name: 'Bom estado')

    product = Product.create(title: 'HQ do Batman: Knight Fall',
                             description: 'Rara HQ do Batman bem conservada',
                             category: category, price: '1000,00',
                             condition: condition, negotiation: :trade)

    visit root_path
    click_on product.title

    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end 
end

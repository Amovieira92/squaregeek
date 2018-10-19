require 'rails_helper'

feature 'Visitor search product' do
  scenario 'successfully' do
    movie_category = Category.create!(name: 'Filmes')
    hq_category = Category.create!(name: 'HQs')
    toy_category = Category.create!(name: 'Brinquedos')
    condition = Condition.create!(name: 'Conservado')
    user = create(:user)

    first_product = Product.create!(
      title: 'A morte do Superman',
      description: 'Animação clássica de 1999',
      category: movie_category, price: '30,00',
      condition: condition, negotiation: :both, user: user,
      photo: File.new(Rails.root.join('spec', 'support',
                                      'filme_morte_do_superman.jpg'))
    )

    second_product = Product.create!(
      title: 'A morte do Superman',
      description: 'HQ clássica de 1999',
      category: hq_category, price: '50,00',
      condition: condition, negotiation: :sale, user: user,
      photo: File.new(Rails.root.join('spec', 'support',
                                      'hq_morte_do_superman.jpg'))
    )

    third_product = Product.create!(
      title: 'HQ do Batman: Knight Fall',
      description: 'Rara HQ do Batman',
      category: hq_category, price: '1000,00',
      condition: condition, negotiation: :trade, user: user,
      photo: File.new(Rails.root.join('spec', 'support', 'knightfall.jpg'))
    )

    fourth_product = Product.create!(
      title: 'Robô megazord',
      description: 'Robô megazord lego',
      category: toy_category, price: '500,00',
      condition: condition, negotiation: :both, user: user,
      photo: File.new(Rails.root.join('spec', 'support', 'megazord_lego.jpg'))
    )

    visit root_path

    within('div#busca') do
      fill_in 'Buscar por palavra-chave', with: 'superman'
      click_on 'Buscar'
    end

    expect(current_path).to eq(root_path)

    expect(page).to have_css('h5', text: first_product.title)
    expect(page).to have_css('p', text: 'Troca')
    expect(page).to have_css('p', text: 'R$ 30,00')
    expect(page).to have_css("img[@src*='filme_morte_do_superman.jpg']")

    expect(page).to have_css('h5', text: second_product.title)
    expect(page).to have_css('p', text: 'Venda')
    expect(page).to have_css('p', text: 'R$ 50,00')
    expect(page).to have_css("img[@src*='hq_morte_do_superman.jpg']")

    expect(page).not_to have_css('div', id: '#card-product3')
    expect(page).not_to have_css('h5', text: third_product.title)
    expect(page).not_to have_css("img[@src*='knightfall.jpg']")

    expect(page).not_to have_css('div', id: '#card-product4')
    expect(page).not_to have_css('h5', text: fourth_product.title)
    expect(page).not_to have_css("img[@src*='megazord_lego.jpg']")
  end

  scenario 'and search for nil results' do
    hq_category = Category.create(name: 'HQs')
    toy_category = Category.create(name: 'Brinquedos')
    condition = Condition.create(name: 'Conservado')
    user = create(:user)

    third_product = Product.create!(
      title: 'HQ do Batman: Knight Fall',
      description: 'Rara HQ do Batman',
      category: hq_category, price: '1000,00',
      condition: condition, negotiation: :trade, user: user,
      photo: File.new(Rails.root.join('spec', 'support', 'knightfall.jpg'))
    )

    fourth_product = Product.create!(
      title: 'Robô megazord',
      description: 'Robô megazord lego',
      category: toy_category, price: '500,00',
      condition: condition, negotiation: :both, user: user,
      photo: File.new(Rails.root.join('spec', 'support', 'megazord_lego.jpg'))
    )

    visit root_path

    within('div#busca') do
      fill_in 'Buscar por palavra-chave', with: 'superman'
      click_on 'Buscar'
    end

    expect(page).to have_content('Não houve resultados para esta busca')
    expect(current_path).to eq(root_path)

    expect(page).not_to have_css('div', id: '#card-product3')
    expect(page).not_to have_css('h5', text: third_product.title)
    expect(page).not_to have_css("img[@src*='knightfall.jpg']")

    expect(page).not_to have_css('div', id: '#card-product4')
    expect(page).not_to have_css('h5', text: fourth_product.title)
    expect(page).not_to have_css("img[@src*='megazord_lego.jpg']")
  end
end

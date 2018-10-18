require 'rails_helper'

feature 'user register product' do
  scenario 'successfully' do
    create(:category, name: 'HQs')
    create(:condition, name: 'Conservado')
    product = create(:product)

    login_as product.user, scope: :user
    visit root_path
    click_on product.title
    click_on 'Editar'
    fill_in 'Título', with: 'HQ Batman: Knight Fall'
    fill_in 'Descrição', with: 'HQ da queda do homem morcego'
    select 'HQs', from: 'Categoria'
    select 'Conservado', from: 'Condição'
    choose 'Troca'
    fill_in 'Preço', with: '1000,00'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'knightfall.jpg')
    click_on 'Editar'

    expect(page).to have_content('Produto editado com sucesso')
    expect(page).to have_css('h1', text: 'HQ Batman: Knight Fall')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'HQ da queda do homem morcego')
    expect(page).to have_css('h3', text: 'Categoria')
    expect(page).to have_css('p', text: 'HQs')
    expect(page).to have_css('h3', text: 'Preço')
    expect(page).to have_css('p', text: '1.000,00')
    expect(page).to have_css('h3', text: 'Condição')
    expect(page).to have_css('p', text: 'Conservado')
    expect(page).to have_css('h3', text: 'Negociação')
    expect(page).to have_css('p', text: 'Troca')
    expect(page).to have_css("img[@src*='knightfall.jpg']")
  end

  scenario 'and leave empty fields' do
    create(:category, name: 'HQs')
    create(:condition, name: 'Conservado')
    product = create(:product)

    login_as product.user, scope: :user
    visit root_path
    click_on product.title
    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Editar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Preço não pode ficar em branco')
  end

  scenario 'and can\'t edit products from other user' do
    product = create(:product)
    user = create(:user)

    login_as user, scope: :user
    visit product_path(product)

    expect(page).not_to have_link 'Editar produto'
  end

  scenario 'and can\'t edit products from other user via link' do
    product = create(:product)
    user = create(:user)

    login_as user, scope: :user
    visit edit_product_path(product)

    expect(current_path).to eq root_path
  end
end

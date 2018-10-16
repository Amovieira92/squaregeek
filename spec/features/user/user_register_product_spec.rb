require 'rails_helper'

feature 'user register product' do
  scenario 'successfully' do
    Category.create(name: 'HQs')
    Category.create(name: 'Brinquedos')

    Condition.create(name: 'Ótimo estado')
    Condition.create(name: 'Conservado')

    visit root_path

    click_on 'Anunciar produto'

    attach_file 'Foto', Rails.root.join('spec', 'support', 'knightfall.jpg')
    fill_in 'Título', with: 'HQ Batman: Knight Fall'
    fill_in 'Descrição', with: 'HQ da queda do homem morcego'
    select 'HQs', from: 'Categoria'
    select 'Conservado', from: 'Condição'
    choose 'Troca'
    fill_in 'Preço', with: '1000,00'
    click_on 'Anunciar'

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
    expect(page).to have_css("//img[@src*='knightfall.jpg']")
  end
end

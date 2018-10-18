require 'rails_helper'

feature 'User delete product' do
  scenario 'successfully' do
    product = create(:product)

    login_as product.user, scope: :user
    visit root_path
    click_on product.title
    click_on 'Apagar'

    expect(page).to have_content('Produto apagado com sucesso')
  end

  scenario 'can\'t view button if not allowed' do
    product = create(:product)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on product.title

    expect(page).not_to have_link('Apagar')
  end
end

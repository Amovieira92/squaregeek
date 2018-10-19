require 'rails_helper'

feature 'user send proposal' do
  scenario 'successfully' do
    product = create(:product)
    user = create(:user)

    sign_in user
    visit root_path
    click_on product.title
    click_on 'Negociar'

  end
end

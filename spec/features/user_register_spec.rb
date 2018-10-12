require 'rails_helper'

feature 'User register' do 
  scenario 'successfully' do
    
    visit root_path
    click_on 'Cadastrar-se'

    within 'form' do
      fill_in 'Nome', with: 'Pedro Alvares Cabral'
      fill_in 'Email', with: 'pedro@cabral.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Telefone', with: '1194213-1500'
      click_on 'Cadastrar'
    end

    user = User.last
    expect(user.name).to eq('Pedro Alvares Cabral')
    expect(user.email).to eq('pedro@cabral.com')
    expect(user.password).to eq('123456')
    expect(user.phone).to eq('1194213-1500')

    expect(page).to have_content('You have signed up successfully')

  end

  scenario 'and blank field' do
    
    visit root_path
    click_on 'Cadastrar-se'
    
    within 'form' do
      fill_in 'Nome', with: ''
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      fill_in 'Telefone', with: ''
      click_on 'Cadastrar'
    end

    expect(page).to have_content('Invalid Email or password')

  end
end
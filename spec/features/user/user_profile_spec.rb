require 'rails_helper'

feature 'User profile' do
  scenario 'User is not signed in' do
    visit my_profile_path
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and enter my profile page' do
    user = create(:user, name: 'joao', email: 'joao@email.com',
                         password: '123456', city: 'Sao Paulo',
                         state: 'Sao Paulo', phone: '123456')
    visit root_path

    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Entrar'
    end

    click_on 'Perfil'

    expect(current_path).to eq(my_profile_path)
    expect(page).to have_selector("input[value='#{user.name}']")
    expect(page).to have_selector("input[value='#{user.email}']")
    expect(page).to have_selector("input[value='#{user.city}']")
    expect(page).to have_selector("input[value='#{user.state}']")
    expect(page).to have_link 'Editar'
  end

  scenario 'and edit profile' do
    user = create(:user, name: 'joao', email: 'joao@email.com',
                         password: '123456', city: 'Sao Paulo',
                         state: 'Sao Paulo', phone: '123456')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Entrar'
    end

    click_on 'Perfil'
    click_on 'Editar'

    fill_in 'Nome', with: 'José Carlos'
    fill_in 'Senha Atual', with: '123456'
    click_on 'Salvar'

    click_on 'Perfil'

    user.reload
    expect(page).to have_selector("input[value='#{user.name}']")
    expect(page).to have_selector("input[value='#{user.email}']")
    expect(page).to have_selector("input[value='#{user.city}']")
    expect(page).to have_selector("input[value='#{user.state}']")
  end

  scenario 'and try to edit profile with blank fields' do
    user = create(:user, name: 'joao', email: 'joao@email.com',
                         password: '123456', city: 'Sao Paulo',
                         state: 'Sao Paulo', phone: '123456')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within 'form' do
      click_on 'Entrar'
    end
    click_on 'Perfil'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Senha Atual', with: '123456'
    click_on 'Salvar'
    expect(page).to have_content('Please review the problems below:')
  end
end

require 'rails_helper'

feature 'User approve proposals' do
  scenario 'successfully' do
    user_joao = create(:user, name: 'joao', email: 'joao@email.com',
                              password: '123456', city: 'Sao Paulo',
                              state: 'Sao Paulo', phone: '123456')

    user_maria = create(:user, name: 'Maria', email: 'maria@email.com',
                               password: '123456', city: 'Sao Paulo',
                               state: 'Sao Paulo', phone: '123456')

    product_joao = create(:product, title: 'HQs do batman muito legal',
                                    user: user_joao)

    product_maria = create(:product, title: 'Batman', user: user_maria)

    proposal = create(:proposal, sender: user_joao,
                                 receiver: user_maria,
                                 offered: product_joao,
                                 desired: product_maria,
                                 status: :pending,
                                 negotiation: :trade,
                                 date: Time.zone.today)
    login_as(user_maria)
    visit root_path
    click_on 'Propostas'
    click_on proposal.id
    click_on 'Aceitar'

    expect(page).to have_content(user_joao.name)
    expect(page).to have_content(user_joao.email)
    expect(page).to have_content(user_joao.city)
    expect(page).to have_content(user_joao.phone)
  end

  scenario 'and cant accept proposal that is not pending' do
    user_joao = create(:user, email: 'joao@email.com')
    user_maria = create(:user, email: 'maria@email.com')

    product_maria = create(:product)

    proposal = create(:proposal, sender: user_joao,
                                 receiver: user_maria,
                                 desired: product_maria,
                                 negotiation: :sale,
                                 date: Time.zone.today,
                                 status: :accepted)
    login_as(user_maria)
    visit proposal_path(proposal)
    expect(page).not_to have_link('Aceitar')
  end

  scenario 'and dont see proposal that he is not related' do
    user_jose = create(:user, email: 'jose@email.com')
    user_joao = create(:user, email: 'joao@email.com')
    user_maria = create(:user, email: 'maria@email.com')

    product_maria = create(:product, user: user_maria)

    proposal = create(:proposal, sender: user_joao,
                                 receiver: user_maria,
                                 desired: product_maria,
                                 negotiation: :sale,
                                 date: Time.zone.today,
                                 status: :accepted)

    login_as(user_jose, scope: :user)
    visit proposal_path(proposal)
    expect(current_path).to eq root_path
  end

  scenario 'and is not signed in' do
    user_joao = create(:user, email: 'joao@email.com')
    user_maria = create(:user, email: 'maria@email.com')

    product_maria = create(:product)

    proposal = create(:proposal, sender: user_joao,
                                 receiver: user_maria,
                                 desired: product_maria,
                                 negotiation: :sale,
                                 date: Time.zone.today)

    visit proposal_path(proposal)
    expect(current_path).to eq new_user_session_path
  end
end

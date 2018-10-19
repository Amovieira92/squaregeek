require 'rails_helper'

feature 'User view proposals' do
  scenario 'view received proposals' do
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
                                 date: '2018-12-10')
    login_as(user_maria)
    visit root_path
    click_on 'Propostas'
    expect(page).to have_css('h1', text: 'Propostas recebidas')
    expect(page).to have_link(proposal.date)
    expect(page).to have_css('h2', text: product_joao.title)
    expect(page).to have_css('h2', text: product_maria.title)
    expect(page).to have_css('h2', text: proposal.status)
  end

  scenario 'and view sent proposals' do
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
                                 date: '2018-12-10')
    login_as(user_joao)
    visit root_path
    click_on 'Propostas'
    expect(page).to have_content('Propostas enviadas')
    expect(page).to have_link(proposal.date)
    expect(page).to have_css('h2', text: product_maria.title)
    expect(page).to have_css('h2', text: product_joao.title)
    expect(page).to have_css('h2', text: proposal.status)
  end

  scenario 'and dont see proposals from other user' do
    user_joao = create(:user, name: 'joao', email: 'joao@email.com',
                              password: '123456')
    user_maria = create(:user, name: 'Maria', email: 'maria@email.com')
    user_carlos = create(:user, name: 'Carlos', email: 'carlos@email.com')
    product_maria = create(:product, title: 'HQ', user: user_maria)
    product_carlos = create(:product, title: 'Batman', user: user_carlos)
    create(:proposal, sender: user_carlos,
                      receiver: user_maria,
                      offered: product_carlos,
                      desired: product_maria,
                      status: :pending,
                      negotiation: :trade,
                      date: '2018-12-10')
    login_as(user_joao)
    visit root_path
    click_on 'Propostas'

    expect(page).to have_content('Você não possuí nenhuma proposta.')
  end

  scenario 'and view sale proposal' do
    user_maria = create(:user, name: 'Maria', email: 'maria@email.com')
    user_carlos = create(:user, name: 'Carlos', email: 'carlos@email.com')
    product_maria = create(:product, title: 'HQ', user: user_maria, price: 100)
    proposal = create(:proposal, sender: user_carlos,
                                 receiver: user_maria,
                                 desired: product_maria,
                                 status: :pending,
                                 negotiation: :sale,
                                 date: '2018-12-10')
    login_as(user_maria)
    visit root_path
    click_on 'Propostas'

    expect(page).to have_css('h1', text: 'Propostas recebidas')
    expect(page).to have_link(proposal.date)
    expect(page).to have_content(product_maria.title)
    expect(page).to have_content(proposal.status)
  end

  scenario 'and view more than one received proposal' do
    user_maria = create(:user, name: 'Maria', email: 'maria@email.com')
    product_maria = create(:product, title: 'HQ', user: user_maria)
    user_carlos = create(:user, name: 'Carlos', email: 'carlos@email.com')
    user_jose = create(:user, name: 'Carlos', email: 'jose@email.com')
    user_lucas = create(:user, name: 'Carlos', email: 'lucas@email.com')
    carlos_proposal = create(:proposal, sender: user_carlos,
                                        receiver: user_maria,
                                        desired: product_maria,
                                        status: :pending,
                                        negotiation: :sale,
                                        date: '2018-12-10')

    jose_proposal = create(:proposal, sender: user_jose,
                                      receiver: user_maria,
                                      desired: product_maria,
                                      status: :pending,
                                      negotiation: :sale,
                                      date: '2018-12-10')

    lucas_proposal = create(:proposal, sender: user_lucas,
                                       receiver: user_maria,
                                       desired: product_maria,
                                       status: :pending,
                                       negotiation: :sale,
                                       date: '2018-10-10')
    login_as(user_maria)
    visit root_path
    click_on 'Propostas'

    expect(page).to have_content(carlos_proposal.id)
    expect(page).to have_content(jose_proposal.id)
    expect(page).to have_content(lucas_proposal.id)
  end

  scenario 'and is not signed in' do
    visit proposals_path
    expect(current_path).to eq(new_user_session_path)
  end
end

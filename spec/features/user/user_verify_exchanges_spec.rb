require 'rails_helper'

feature 'User verify exchanges' do
  scenario 'successfully' do
    user_joao = create(:user, name: 'joao', email: 'joao@email.com',
                         password: '123456', city: 'Sao Paulo',
                         state: 'Sao Paulo', phone: '123456')

    user_maria = create(:user, name: 'Maria', email: 'maria@email.com',
                          password: '123456', city: 'Sao Paulo',
                          state: 'Sao Paulo', phone: '123456')                 
    product_joao = create(:product, title:'HQs do batman muito legal',
                                    user_id: user_joao)
    product_maria = create(:product,title:'Batman' , user_id: user_maria)
    
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
end  
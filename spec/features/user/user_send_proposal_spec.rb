require 'rails_helper'

feature 'user send proposal' do
  scenario 'successfully' do
    product = create(:product, title: 'Superman')
    user = create(:user)
    user_product = create(:product, user: user)

    sign_in user
    visit root_path
    click_on product.title
    click_on 'Negociar'
    select user_product.title, from: 'Produto a negociar'
    fill_in 'Valor a negociar', with: '300'
    fill_in 'Comentários', with: 'Que legal!'
    click_on 'Enviar proposta'

    expect(page).to have_content(product.title)
  end

  scenario 'and should notify the receiver' do
    product = create(:product, title: 'Superman')
    user = create(:user)
    user_product = create(:product, user: user)
    mailer_spy = instance_spy(ProposalMailer)
    stub_const('ProposalMailer', mailer_spy)

    sign_in user
    visit root_path
    click_on product.title
    click_on 'Negociar'
    select user_product.title, from: 'Produto a negociar'
    fill_in 'Valor a negociar', with: '300'
    fill_in 'Comentários', with: 'Que legal!'
    click_on 'Enviar proposta'

    proposal= Proposal.last
    expect(mailer_spy).to have_received(:notify_receiver).with(product,
                                                               proposal)
  end
end

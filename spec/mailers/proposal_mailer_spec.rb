require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  describe '.notify_receiver' do
    it 'renders the headers' do
      user = create(:user, email: 'joao@email.com')
      product = create(:product, user: user)
      sender_user = create(:user, email: 'sender@email.com')
      proposal = create(:proposal, desired: product, sender: sender_user,
                                   receiver: user)

      mail = ProposalMailer.notify_receiver(product, proposal)

      expect(mail.subject).to eq('Seu produto recebeu uma proposta!')
      expect(mail.to).to eq(['joao@email.com'])
    end

    it 'renders the body' do
      user = create(:user, email: 'joao@email.com')
      product = create(:product, user: user, title: 'Superman')
      sender_user = create(:user, email: 'sender@email.com')
      proposal = create(:proposal, desired: product, sender: sender_user,
                                   receiver: user)

      mail = ProposalMailer.notify_receiver(product, proposal)
      expect(mail.body).to include('Seu produto Superman recebeu uma nova '\
                                   'proposta')
    end
  end
end

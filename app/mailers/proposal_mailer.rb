class ProposalMailer < ApplicationMailer
  def notify_receiver(product, proposal)
    @product = product
    @proposal = proposal
    mail(to: product.user.email, subject: 'Seu produto recebeu uma proposta!')
  end
end

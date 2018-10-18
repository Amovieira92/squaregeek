class ProposalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_proposals = Proposal.where(receiver: current_user)
    @sent_proposals = Proposal.where(sender: current_user)
  end
end

class ProposalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_proposals = Proposal.where(receiver: current_user)
    @sent_proposals = Proposal.where(sender: current_user)
  end

  def show
    @proposal = Proposal.find(params[:id])
    redirect_to root_path unless @proposal.user_related?(current_user)
  end

  def accept
    @proposal = Proposal.find(params[:proposal_id])
    redirect_to root_path unless @proposal.user_related?(current_user)
    @proposal.accepted!
    redirect_to @proposal
  end
end

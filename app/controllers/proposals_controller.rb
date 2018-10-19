class ProposalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_proposals = Proposal.where(receiver: current_user)
    @sent_proposals = Proposal.where(sender: current_user)
  end

  def new
    @proposal = Proposal.new
    @product = Product.find(params[:product_id])
  end

  def create
    @proposal = current_user.proposals.new(proposal_params)
    @proposal.date = Time.zone.today
    @proposal.desired = Product.find(params[:product_id])
    @proposal.receiver = @proposal.desired.user
    @proposal.save
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:offered_id, :price, :comment)
  end
end

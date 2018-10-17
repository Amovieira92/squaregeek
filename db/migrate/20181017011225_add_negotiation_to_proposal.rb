class AddNegotiationToProposal < ActiveRecord::Migration[5.2]
  def change
    add_column :proposals, :negotiation, :integer, default: 0
  end
end

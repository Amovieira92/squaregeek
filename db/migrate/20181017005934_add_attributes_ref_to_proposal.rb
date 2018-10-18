class AddAttributesRefToProposal < ActiveRecord::Migration[5.2]
  def change
    add_reference :proposals, :sender, foreign_key: true
    add_reference :proposals, :receiver, foreign_key: true
    add_reference :proposals, :offered, foreign_key: true
    add_reference :proposals, :desired, foreign_key: true
  end
end

class AddPriceAndCommentToProposal < ActiveRecord::Migration[5.2]
  def change
    add_column :proposals, :price, :decimal
    add_column :proposals, :comment, :text
  end
end

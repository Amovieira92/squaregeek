class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.date :date 
      t.integer :status, default: 0
      t.timestamps
    end
  end
end

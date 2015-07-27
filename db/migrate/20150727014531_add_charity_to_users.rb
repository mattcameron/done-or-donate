class AddCharityToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :charity_id, :integer, default: 1
  	add_column :charges, :charity_id, :integer

  	create_table :charities do |t|
      t.string :name
    end

  end
end

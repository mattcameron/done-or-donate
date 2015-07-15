class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
    	t.integer :task_id, null: false
    	t.integer :total_cents, null: false
    	t.boolean :successful, default: false

    	t.timestamps null: false
    end
  end
end

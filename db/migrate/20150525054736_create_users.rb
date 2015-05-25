class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

     create_table :tasks do |t|
      t.integer :user_id
      t.string :title, null: false
      t.text :description
      t.datetime :due_date, null: false
      t.decimal :bounty, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end

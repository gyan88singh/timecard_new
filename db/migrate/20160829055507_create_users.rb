class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :domain_name
      t.string :email,null: false, default: ""
      t.string :password_hash
      t.string :password_salt
      t.boolean :is_admin
      t.string :status
      t.integer :created_by
      t.integer :updated_by
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end

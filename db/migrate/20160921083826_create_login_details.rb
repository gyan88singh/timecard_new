class CreateLoginDetails < ActiveRecord::Migration
  def change
    create_table :login_details do |t|
           t.integer :user_id
           t.timestamp :login_time
           
           t.string :remarks
          
           t.timestamps null: false
    end
  end
end

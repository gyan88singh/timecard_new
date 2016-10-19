class CreateDepartmentsUsers < ActiveRecord::Migration
  def change
    create_table :departments_users do |t|
        t.integer :user_id
        t.integer :department_id
        t.integer :created_by
        t.integer :updated_by
     
        t.timestamps
      
    end
  end
end

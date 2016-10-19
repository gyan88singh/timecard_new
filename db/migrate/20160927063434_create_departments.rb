class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
          t.string :department_name
          t.string :status
          t.integer :created_by
          t.integer :updated_by
          t.timestamps
    end
  end
end

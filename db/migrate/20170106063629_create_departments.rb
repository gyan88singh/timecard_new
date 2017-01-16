class CreateDepartments < ActiveRecord::Migration
  def change
      create_table :departments do |t|
            t.string :department_code
            t.string :department_desc
            
            t.boolean :status
            t.integer :created_by
            t.integer :updated_by
            t.timestamps
      end
    end
    
    def self.down
         drop_table :departments
    end
end

class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :pay_code
      t.string :pay_code_desc
                            
      t.boolean :status
      t.integer :created_by
      t.integer :updated_by
      t.timestamps 
      
    end
  end
  def self.down
      drop_table :companies
  end
  
end

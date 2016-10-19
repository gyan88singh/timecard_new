class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
            t.string :first_name
            t.string :middle_name
            t.string :last_name
            t.integer :badge
            t.string :pin
            t.string :gender
            t.string :marital
            t.string :social_ins
            t.date :hire_date
            t.date :birth_date
            t.date :senor_date
            t.date :term_date
            t.string :emergency_name
            t.string :floater
            t.integer :home_address_id
            t.integer :work_address_id
            t.string :time_zone
            t.integer :common_id
            
      t.timestamps null: false
    end
  end
end

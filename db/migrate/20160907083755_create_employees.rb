class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
           
            t.integer :PAYROLL, limit: 8

            t.string :LAST_NAME

            t.string :FIRST_NAME

            t.string :MIDDLE_NAME

            t.integer :BADGE, limit: 8

            t.string :PIN
            t.string :GENDER
            t.string :MARITAL

            t.string :SOCIAL_INS

            t.date :HIRE_DATE

            t.date :BIRTH_DATE

            t.date :SENOR_DATE

            t.date :TERM_DATE

            t.string :EMERGENCY_NAME

            t.string :FLOATER

            t.integer :HOME_ADDRESS_ID

            t.integer :WORK_ADDRESS_ID

            t.string :TIME_ZONE

            t.string :COMMON_ID
           
            
      t.timestamps null: false
    end
  end
end

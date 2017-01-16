class CreateJobTitles < ActiveRecord::Migration
  def change
    create_table :job_titles do |t|
      t.string :job_title_code
      t.string :job_title_desc
                
      t.boolean :status
      t.integer :created_by
      t.integer :updated_by
      t.timestamps 
    end
  end
  
  def self.down
         drop_table :job_titles
  end
  
end

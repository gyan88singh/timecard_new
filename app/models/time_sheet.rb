class TimeSheet < ActiveRecord::Base
  
  require 'CSV' 
   require 'roo'           
   require 'rubygems'
   
   
   def self.import(file)
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
       timesheet = find_by(id: row["id"]) || new
       timesheet.attributes = row.to_hash
       timesheet.save!
      end
    end  
    
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |timesheet|
        e timesheet
        csv << timesheet.attributes.values
      end
    end
  end
  
end

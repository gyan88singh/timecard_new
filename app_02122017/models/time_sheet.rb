class TimeSheet < ActiveRecord::Base
  
#  require 'CSV' 
   require 'roo'           
   require 'rubygems'
#   require 'iconv'   
   
   def self.import(file)
       spreadsheet = Roo::Spreadsheet.open(file.path, file_warning: :ignore)

      header = spreadsheet.row(5)
   # raise header.inspect
       if header == ["WORKED_ID", "ID", "PAYROLL", "PDATE", "SHIFT", "ON_TIME", "OFF_T
         IME", "CODE", "CODE_TYPE", "LINE_NO", "PAY_TYPE", "DEPT_GROUP", "DEPARTMENT", "C
         ENTRE", "POS", "DOCKET", "QUANTITY", "STD_RATE", "HOURS", "HOUR_TYPE", "NO_OT_RE
         C", "JOB_PREM", "AM_PREM_HR", "PM_PREM_HR", "CALC_FLAG", "STATUS", "WAS_LL", "OT
         _TYPE", "NOERASE", "CLK_ON", "CLK_OFF", "UDF1", "UDF2", "NOTE", "CENTRE1", "POS1
         ", "RDOCKET", "TDEFAULT", "FLAG1", "FLAG2", "FLAG3", "FLAG4", "FLAG5", "RATE", "
         AM_PREM_RATE", "PM_PREM_RATE", "JOB_ID", "UDF_KEY", "OPERATION", "UDF3", "UDF4",
          "PIECE_RATE", "WORK_ORDER_ID", "WORK_ITEM_ID", "WOI_CONTROL", "APPROVED_STATUS",
         "APPROVED_BY", "APPROVED_TIME", "EXT_ATTR_1", "EXT_ATTR_2", "EXT_ATTR_3", "EXT
         _ATTR_4", "EXT_ATTR_5", "EXT_ATTR_6", "EWA_1", "EWA_2", "EWA_3", "EWA_4", "EWA_5
         ", "EWA_6", "EWA_7", "EWA_8", "EWA_9", "EWA_10", "EWA_11", "EWA_12", "EWA_13", "
         EWA_14", "EWA_15", "EWA_16", "EWA_17", "EWA_18", "EWA_19", "EWA_20"]

         (6..spreadsheet.last_row).each do |i|
              row = Hash[[header, spreadsheet.row(i)].transpose]
              timesheet = find_by(id: row["id"]) || new
              timesheet.attributes = row.to_hash
              timesheet.save!
         end
            return true
       else
            return false

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

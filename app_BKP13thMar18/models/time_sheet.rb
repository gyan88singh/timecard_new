class TimeSheet < ActiveRecord::Base
  
 # require 'CSV' 
   require 'roo'  
   require 'roo-xls'         
   require 'rubygems'
   require 'uri'  # Needed to prevent a NameError on URI
   require 'fileutils'
   
  require 'net/ftp'
 
  def self.import_excel_sheet_ftp
  
     puts "list of files on ftp server"
  
   directory = '/To TIS/ARS/times_excel/'
   localfile = 'public/times_excel/'
   
  # begin
  
   ftp=Net::FTP.new
   ftp.connect(host = FTP_HOST , port = FTP_PORT)
   ftp.login(user = FTP_USERNAME , passwd = FTP_PASSWORD)
   
  # rescue  SocketError, Net::ReadTimeout => e
     # server can't be reached or doesn't send any respones
   #  puts "error: #{e}"
      # puts e.message
      # puts e.backtrace.inspect
       
  # end
  
   ftp.chdir(directory)
   ftp.binary = true
   ftp.passive = true
  
   filenames = ftp.nlst('*.xls')
  
   filenames.each {|filename|
    puts filename.inspect
    ftp.getbinaryfile(filename,localfile + filename)
    ftp.delete(filename)
  }
  
  ftp.close
  
    # filenames.each_index{|i| #Loop through each index
     # localfile = "public/times_excel" + i.to_s + ".xls"
     # ftp.getbinaryfile(filenames[i],localfile)
   # }
  
  end

  
  def self.import_excel_sheet
    
    puts "file to be opened from application directory"
   
    # RuntimeError: "[\"public/times_excel/Book1.xls\",\"public/times_excel/Book2.xls\ "]"
    #file = File.join(RAILS_ROOT, 'public', 'Book1.xls')
    
    files_list = Dir['public/times_excel/*']  
     if !files_list.nil? 
        files_list.each do |files| 
           # spreadsheet = Roo::Spreadsheet.open('public/times_excel/Book1.xls')
            spreadsheet = Roo::Spreadsheet.open(files)                                                                                   
            puts "file opened"    
           spreadno = spreadsheet.first_row
            
          if (spreadno == 5)
             
            header = spreadsheet.row(5)
            puts "file read 5"
               if header == ["WORKED_ID", "ID", "PAYROLL", "PDATE", "SHIFT", "ON_TIME", "OFF_TIME", "CODE", "CODE_TYPE", "LINE_NO", "PAY_TYPE", "DEPT_GROUP", "DEPARTMENT", "CENTRE", "POS", "DOCKET", "QUANTITY", "STD_RATE", "HOURS", "HOUR_TYPE", "NO_OT_REC", "JOB_PREM", "AM_PREM_HR", "PM_PREM_HR", "CALC_FLAG", "STATUS", "WAS_LL", "OT_TYPE", "NOERASE", "CLK_ON", "CLK_OFF", "UDF1", "UDF2", "NOTE", "CENTRE1", "POS1", "RDOCKET", "TDEFAULT", "FLAG1", "FLAG2", "FLAG3", "FLAG4", "FLAG5", "RATE", "AM_PREM_RATE", "PM_PREM_RATE", "JOB_ID", "UDF_KEY", "OPERATION", "UDF3", "UDF4", "PIECE_RATE", "WORK_ORDER_ID", "WORK_ITEM_ID", "WOI_CONTROL", "APPROVED_STATUS", "APPROVED_BY", "APPROVED_TIME", "EXT_ATTR_1", "EXT_ATTR_2", "EXT_ATTR_3", "EXT_ATTR_4", "EXT_ATTR_5", "EXT_ATTR_6", "EWA_1", "EWA_2", "EWA_3", "EWA_4", "EWA_5", "EWA_6", "EWA_7", "EWA_8", "EWA_9", "EWA_10", "EWA_11", "EWA_12", "EWA_13", "EWA_14", "EWA_15", "EWA_16", "EWA_17", "EWA_18", "EWA_19", "EWA_20"]
              
               
             (6..spreadsheet.last_row).each do |i|
        
              puts i.inspect
                      row = Hash[[header, spreadsheet.row(i)].transpose]
                      timesheet = find_by(WORKED_ID: row["WORKED_ID"]) || new
                      timesheet.attributes = row.to_hash
                      timesheet.save!
                 end
                
               end
             puts "file read complete5"
             
              FileUtils.cp files, 'public/times_completed_excel'
   
              File.delete(files) if File.exist?(files)
              
        elsif (spreadno == 1)
              header = spreadsheet.row(1)
              puts "file read 1"
                if header == ["WORKED_ID", "ID", "PAYROLL", "PDATE", "SHIFT", "ON_TIME", "OFF_TIME", "CODE", "CODE_TYPE", "LINE_NO", "PAY_TYPE", "DEPT_GROUP", "DEPARTMENT", "CENTRE", "POS", "DOCKET", "QUANTITY", "STD_RATE", "HOURS", "HOUR_TYPE", "NO_OT_REC", "JOB_PREM", "AM_PREM_HR", "PM_PREM_HR", "CALC_FLAG", "STATUS", "WAS_LL", "OT_TYPE", "NOERASE", "CLK_ON", "CLK_OFF", "UDF1", "UDF2", "NOTE", "CENTRE1", "POS1", "RDOCKET", "TDEFAULT", "FLAG1", "FLAG2", "FLAG3", "FLAG4", "FLAG5", "RATE", "AM_PREM_RATE", "PM_PREM_RATE", "JOB_ID", "UDF_KEY", "OPERATION", "UDF3", "UDF4", "PIECE_RATE", "WORK_ORDER_ID", "WORK_ITEM_ID", "WOI_CONTROL", "APPROVED_STATUS", "APPROVED_BY", "APPROVED_TIME", "EXT_ATTR_1", "EXT_ATTR_2", "EXT_ATTR_3", "EXT_ATTR_4", "EXT_ATTR_5", "EXT_ATTR_6", "EWA_1", "EWA_2", "EWA_3", "EWA_4", "EWA_5", "EWA_6", "EWA_7", "EWA_8", "EWA_9", "EWA_10", "EWA_11", "EWA_12", "EWA_13", "EWA_14", "EWA_15", "EWA_16", "EWA_17", "EWA_18", "EWA_19", "EWA_20"]
                       
                       (2..spreadsheet.last_row).each do |i|
                  
                        puts i.inspect
                                row = Hash[[header, spreadsheet.row(i)].transpose]
                                timesheet = find_by(WORKED_ID: row["WORKED_ID"]) || new
                                timesheet.attributes = row.to_hash
                                timesheet.save!
                        end
                          
                 end
                       puts "file read complete1"
                       
                        FileUtils.cp files, 'public/times_completed_excel'
             
                        File.delete(files) if File.exist?(files)
                        
          else 
                      puts "file read complete not done"
                            
                      FileUtils.cp files, 'public/times_completed_excel_not_done'
                  
                     File.delete(files) if File.exist?(files)

          
        end
               
      end
      
        #FileUtils.rm_rf(Dir['public/times_excel/Book1.xls', 'public/times_excel/Book2.xls']) 
 
        #FileUtils.rm_r files.glob('/tmp/*')

      
      #FileUtils.rm_rf(Dir.glob('dir/*'))
     # FileUtils.rm_rf('dir/to/remove')
  
      
        #FileUtils.rm_rf Dir['public/times_excel/*']

        end
  end
   
def self.download_file_from_ftp_import_to_db
   
   puts "file to be opened"
  
  #ftp = Net::FTP.new('ftp.infinxinc.com',user = "Cycloshare", password = 'Cyclo@123')
   
  # files_list = ftp.nlst('/To TIS/ARS/times_excel/*.xls')
   
 url = 'ftp.infinxinc.com'
 username = 'Cycloshare'
 passwd = "Cyclo@123"
 #filename = "file1"
 
 directory = '/To TIS/ARS/times_excel/'
 localfile = 'public/times_excel/'
 completedfile = '/To TIS/ARS/completed_time_excel/'
 
 ftp=Net::FTP.new
 ftp.connect(:host => url,:port => 21)
 ftp.login(:user => username, :passwd => passwd)
 ftp.chdir(directory)
 ftp.binary = true
 ftp.passive = true
 
 filenames = ftp.nlst('*.xls') #This is an array of all Excel files in the ftp directory
 
 filenames.each {|filename| #Loop through each element of the array
  puts filename.inspect
  ftp.getbinaryfile(filename,localfile + filename) #if Dir.exists?('localfile')   #Get the file
   ftp.delete(filename)
  #ftp.rename(filename, completedfile + filename)
}

  ftp.close
  
 # filenames.each_index{|i| #Loop through each index
  # localfile = "public/times_excel" + i.to_s + ".xls"
  # ftp.getbinaryfile(filenames[i],localfile)
# }
  
  files_list = Dir['public/times_excel/*']
 
    if !files_list.nil? 
       files_list.each do |files| 
         puts files
           spreadsheet = Roo::Spreadsheet.open(files)                                                                                   
           puts "file opened"     
           
             header = spreadsheet.row(5)
           puts "file read"
              if header == ["WORKED_ID", "ID", "PAYROLL", "PDATE", "SHIFT", "ON_TIME", "OFF_TIME", "CODE", "CODE_TYPE", "LINE_NO", "PAY_TYPE", "DEPT_GROUP", "DEPARTMENT", "CENTRE", "POS", "DOCKET", "QUANTITY", "STD_RATE", "HOURS", "HOUR_TYPE", "NO_OT_REC", "JOB_PREM", "AM_PREM_HR", "PM_PREM_HR", "CALC_FLAG", "STATUS", "WAS_LL", "OT_TYPE", "NOERASE", "CLK_ON", "CLK_OFF", "UDF1", "UDF2", "NOTE", "CENTRE1", "POS1", "RDOCKET", "TDEFAULT", "FLAG1", "FLAG2", "FLAG3", "FLAG4", "FLAG5", "RATE", "AM_PREM_RATE", "PM_PREM_RATE", "JOB_ID", "UDF_KEY", "OPERATION", "UDF3", "UDF4", "PIECE_RATE", "WORK_ORDER_ID", "WORK_ITEM_ID", "WOI_CONTROL", "APPROVED_STATUS", "APPROVED_BY", "APPROVED_TIME", "EXT_ATTR_1", "EXT_ATTR_2", "EXT_ATTR_3", "EXT_ATTR_4", "EXT_ATTR_5", "EXT_ATTR_6", "EWA_1", "EWA_2", "EWA_3", "EWA_4", "EWA_5", "EWA_6", "EWA_7", "EWA_8", "EWA_9", "EWA_10", "EWA_11", "EWA_12", "EWA_13", "EWA_14", "EWA_15", "EWA_16", "EWA_17", "EWA_18", "EWA_19", "EWA_20"]
             
              
            (6..spreadsheet.last_row).each do |i|
       
             puts i.inspect
                     row = Hash[[header, spreadsheet.row(i)].transpose]
                     timesheet = find_by(WORKED_ID: row["WORKED_ID"]) || new
                     timesheet.attributes = row.to_hash
                     timesheet.save!
                end
               
              end
                  puts "file read complete"
                  
                   FileUtils.cp files, 'public/times_completed_excel'
        
                   File.delete(files) if File.exist?(files)
               
     end
     
       end
 end
  
   def self.import(file)
     
   #  spreadsheet = Roo::Spreadsheet.open(file.path, file_warning: :ignore,                                                                                     
    #                          extension: File.extname(file.original_filename),                                                                      
    #                          csv_options: { col_sep: ';', converters: :all }) 
     
     puts "file to be opened"
         
         spreadsheet = Roo::Spreadsheet.open(file.path, file_warning: :ignore)                                                                                    
         puts "file opened"                        
         
           header = spreadsheet.row(5)
         puts "file read"
            if header == ["WORKED_ID", "ID", "PAYROLL", "PDATE", "SHIFT", "ON_TIME", "OFF_TIME", "CODE", "CODE_TYPE", "LINE_NO", "PAY_TYPE", "DEPT_GROUP", "DEPARTMENT", "CENTRE", "POS", "DOCKET", "QUANTITY", "STD_RATE", "HOURS", "HOUR_TYPE", "NO_OT_REC", "JOB_PREM", "AM_PREM_HR", "PM_PREM_HR", "CALC_FLAG", "STATUS", "WAS_LL", "OT_TYPE", "NOERASE", "CLK_ON", "CLK_OFF", "UDF1", "UDF2", "NOTE", "CENTRE1", "POS1", "RDOCKET", "TDEFAULT", "FLAG1", "FLAG2", "FLAG3", "FLAG4", "FLAG5", "RATE", "AM_PREM_RATE", "PM_PREM_RATE", "JOB_ID", "UDF_KEY", "OPERATION", "UDF3", "UDF4", "PIECE_RATE", "WORK_ORDER_ID", "WORK_ITEM_ID", "WOI_CONTROL", "APPROVED_STATUS", "APPROVED_BY", "APPROVED_TIME", "EXT_ATTR_1", "EXT_ATTR_2", "EXT_ATTR_3", "EXT_ATTR_4", "EXT_ATTR_5", "EXT_ATTR_6", "EWA_1", "EWA_2", "EWA_3", "EWA_4", "EWA_5", "EWA_6", "EWA_7", "EWA_8", "EWA_9", "EWA_10", "EWA_11", "EWA_12", "EWA_13", "EWA_14", "EWA_15", "EWA_16", "EWA_17", "EWA_18", "EWA_19", "EWA_20"]
           
            
              (6..spreadsheet.last_row).each do |i|
     
                  puts i.inspect
                   row = Hash[[header, spreadsheet.row(i)].transpose]
                   timesheet = find_by(WORKED_ID: row["WORKED_ID"]) || new
                   timesheet.attributes = row.to_hash
                   timesheet.save!
              end
                 return true
            else
                 return false
           
            end
          puts "file read complete"
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
  
  
  def self.search_datewise_time_report(payroll,from_date,to_date)
     #raise payroll.inspect

         if payroll == ""
          # a = "SELECT date(\"CLK_ON\"),date(\"CLK_ON\"),concat_ws(''''-'''', \"time\"(\"CLK_ON\")::text, \"time\"(\"CLK_OFF\")::text,(\"HOURS\")::text) FROM time_sheets 
          #   WHERE ( date(\"CLK_ON\") >=''''" + from_date + "'''' and date(\"CLK_OFF\") <=''''" + to_date + "'''' and (\"CODE\") = ''''" + code + "'''') ORDER BY 2,3"
           a = "SELECT concat_ws(''''|'''', date(\"CLK_ON\")::text, \"PAYROLL\"::text, \"DEPT_GROUP\"::text, \"CENTRE\"::text), \"PAYROLL\",concat_ws(''''-'''', \"time\"(\"CLK_ON\")::text,\"time\"(\"CLK_OFF\")::text,(\"HOURS\")::text,(\"DOCKET\")::text)
                FROM   time_sheets WHERE (date(\"CLK_ON\") >=''''" + from_date + "'''' and date(\"CLK_OFF\") <=''''" + to_date + "''''and (\"CODE\") in (''''(W)'''' , ''''(X)'''')) 
               group by \"PAYROLL\", \"CLK_ON\",\"CLK_OFF\",\"HOURS\", \"DEPT_GROUP\", \"CENTRE\",\"DOCKET\" ORDER  BY \"PAYROLL\", \"CLK_ON\""
         
         else
         #  a = "SELECT date(\"CLK_ON\"),date(\"CLK_ON\"),concat_ws(''''-'''', \"time\"(\"CLK_ON\")::text, \"time\"(\"CLK_OFF\")::text,(\"HOURS\")::text) FROM time_sheets 
          #              WHERE ((\"PAYROLL\") = ''''" + payroll.to_s + "'''' and date(\"CLK_ON\") >=''''" + from_date + "'''' and date(\"CLK_OFF\") <=''''" + to_date + "'''' and (\"CODE\") = ''''" + code + "'''') ORDER BY 2,3"
         
         a = "SELECT concat_ws(''''|'''', date(\"CLK_ON\")::text, \"PAYROLL\"::text), \"PAYROLL\",concat_ws(''''-'''', \"time\"(\"CLK_ON\")::text,\"time\"(\"CLK_OFF\")::text,(\"HOURS\")::text,(\"DOCKET\")::text)
            FROM   time_sheets WHERE ((\"PAYROLL\") in (''''" + payroll.to_s + "'''') and date(\"CLK_ON\") >=''''" + from_date + "'''' and date(\"CLK_OFF\") <=''''" + to_date + "''''and (\"CODE\") in (''''(W)'''' , ''''(X)'''')) 
            group by \"PAYROLL\", \"CLK_ON\",\"CLK_OFF\",\"HOURS\",\"DOCKET\" ORDER  BY \"PAYROLL\", \"CLK_ON\""
         
         end
                
         puts "SUHAS-START = " + a + "SUHAS-END"
           
          if payroll == ""
            b = ActiveRecord::Base.connection.select_all("SELECT  employeeattendance('" + from_date + "','" + to_date + "');").map{|e| e["employeeattendance"]}
           #  b = []
          else
          
            b = ActiveRecord::Base.connection.select_all("SELECT  employeeattendance('" + payroll + "','" + from_date + "','" + to_date + "');").map{|e| e["employeeattendance"]}
          end 
               puts b[0]
          if b[0] != nil
            
              c = "text"
              d = "attendancedate text" 
              
                times = ActiveRecord::Base.connection.select_all("select crosstab_dynamic_sql_gen_fn('" + a + "'," + b[0] + ",'" + c + "','" + d + "');")
           
           
              times.each do |row|
                  time1 = ActiveRecord::Base.connection.select_all(row['crosstab_dynamic_sql_gen_fn'])
             
                @arrfinaltime =  time1.to_hash
              end
          
              #@timessecond = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and (("CODE") = ? or ("CODE") = ? or ("CODE") = ?)',payroll,from_date,to_date,'SIC','VAC','PH')
         
     #### Megha Code ###############       
             # @payrollids = []
             # @payrollwiseattendancearray = [] 
             # @previouspayroll = "";
             # @currentpayroll = "";
             # @attendance = [];
                
            #  puts " original array: "
            #  puts @arrfinaltime
  
             # @arrfinaltime.each do |finaltime|
             #     @currentpayroll = finaltime["attendancedate"].split('|')[1]
             #     puts "current " + @currentpayroll
              #    puts "previous " + @previouspayroll
                    
              #    if @payrollids.blank? 
               #       @payrollids.push(@currentpayroll)
               #       @previouspayroll = @currentpayroll
               #       @attendance.push(finaltime)
                      #puts "if: Payrollids "
                      #puts @payrollids 
                      #puts " previous payroll: " + @previouspayroll
                      #puts " current payroll: " + @currentpayroll
                      #puts " current local array: "
                      #puts @attendance
                      #puts " final array: "
                      #puts @payrollwiseattendancearray
                #  elsif !@payrollids.blank? && (@currentpayroll == @previouspayroll)
                   #   @attendance.push(finaltime)
                      #puts "first elsif: Payrollids "
                      #puts @payrollids 
                      #puts " previous payroll: " + @previouspayroll
                      #puts " current payroll: " + @currentpayroll
                      #puts " current local array: "
                      #puts @attendance
                      #puts " final array: "
                      #puts @payrollwiseattendancearray
                #  elsif !@payrollids.blank? && (@currentpayroll != @previouspayroll)
                 #     @previouspayroll = @currentpayroll 
                 #     @payrollids.push(@currentpayroll)
                      #@payrollwiseattendancearray.push(@attendance)
                  #  @payrollwiseattendancearray << @attendance
                  #    @attendance = []
                   #   @attendance.push(finaltime)
                      
                      #puts "second elsif: Payrollids "
                      #puts @payrollids 
                      #puts " previous payroll: " + @previouspayroll
                      #puts " current payroll: " + @currentpayroll
                      #puts " current local array: "
                      #puts @attendance
                      #puts " final array: "
                      #puts @payrollwiseattendancearray
                 # end
             # end #loop
             
            # if @payrollwiseattendancearray.blank?
              #  @payrollwiseattendancearray << @attendance 
            # end
             
           #  puts "start array"
             #puts @attendance
           #  puts @payrollwiseattendancearray
           #  puts "end array"
   #### Code End by Megha########## 
                  
           return b[0],@arrfinaltime,payroll;
           
      else
        
      end
    
  end
  
  
end

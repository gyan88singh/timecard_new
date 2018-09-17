class TimeReportsController < ApplicationController
  #before_filter :authorize
  protect_from_forgery except: :index   # ActionController::InvalidAuthenticityToken
  
  require 'date'
  
  def time_home
   # @time_sheet = TimeSheet.ransack(params[:q])
   
  end

  def search_time_report
    
     if (!params[:emp_id].blank? &&  params[:emp_lastname].blank? && params[:department_code].blank?)
    
      @finaltimesarray = []
    
      empid = params[:emp_id].split(',')
     
    empid.each do |payroll|
      puts payroll.inspect
   
    
        @times = TimeSheet.search_datewise_time_report(payroll,params[:from_date],params[:to_date])
        @finaltimesarray << @times
    
    end 
        puts @finaltimesarray.inspect
        
   
   elsif (!params[:emp_lastname].blank? && params[:emp_id].blank? && params[:department_code].blank?)
     
      
     @ArrEmpPayroll = Employee.where('("LAST_NAME") ILIKE ? ', "#{params[:emp_lastname]}%").pluck(:PAYROLL)
     if @ArrEmpPayroll == []
       @finaltimesarray = []
     else
     
      @finaltimesarray = []
         
           @ArrEmpPayroll.each do |payroll|
                     @times = TimeSheet.search_datewise_time_report(payroll.to_s,params[:from_date],params[:to_date])
             @finaltimesarray << @times
           
         end 
             puts @finaltimesarray.inspect
     end
     
     elsif (!params[:department_code].blank? && params[:emp_id].blank? && params[:emp_lastname].blank?)
       
     @ArrCentrePayroll = TimeSheet.where('("CENTRE") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=?',params[:department_code],params[:from_date],params[:to_date]).distinct.pluck(:"PAYROLL") 
     if @ArrCentrePayroll == []
  
       @finaltimesarray = []
     else
       @finaltimesarray = []
              
                  @ArrCentrePayroll.each do |payroll|
                          @times = TimeSheet.search_datewise_time_report(payroll.to_s,params[:from_date],params[:to_date])
                  @finaltimesarray << @times
                
              end 
                  puts @finaltimesarray.inspect
      
     end
             
     else
            @finaltimesarray = []
     
           
    end     
  end
  
  def timecard_report
      @finaltimesarray = []
      
      empid = params[:emp_id].split(',')
        # puts empid.inspect
     
      empid.each do |payroll|
          @times = TimeSheet.search_datewise_time_report(payroll,params[:from_date],params[:to_date])
          @finaltimesarray << @times
        
      end
      
     # @Arrdepartment = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=?',params[:emp_id],params[:from_date],params[:to_date]).distinct.pluck(:"DEPT_GROUP",:"CENTRE") if params[:emp_id] != ""
   
     # @Arrdocket = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and "DOCKET" != ? and "DOCKET" != ? ',params[:emp_id],params[:from_date],params[:to_date],'null','').distinct.pluck(:"DOCKET") if params[:emp_id] != ""  

    
      respond_to do |format|
           
          format.html 
          format.xlsx {
            #response.headers["Content-Type"] = "application/vnd.ms-excel"
              response.headers['Content-Disposition'] = 'attachment; filename="timesheet.xlsx"'
            } 
      end
  end
  
 def sumtotal_timecard_report
    
    @sumTotalTimecard = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=?',params[:emp_id],params[:from_date],params[:to_date]).order('"CLK_ON"')
      
    respond_to do |format|
          
             format.xlsx {
                   response.headers['Content-Disposition'] = 'attachment; filename="sumtotalTimesheet.xlsx"'
                 }
     end
    
  end

end

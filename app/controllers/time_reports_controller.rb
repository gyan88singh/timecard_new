class TimeReportsController < ApplicationController
  #before_filter :authorize
  protect_from_forgery except: :index   # ActionController::InvalidAuthenticityToken
  
  require 'date'
  
  def time_home
   # @time_sheet = TimeSheet.ransack(params[:q])
   
  end

  def search_time_report
 
      
    #@times = TimeSheet.where(PAYROLL: params[:emp_id] ,CLK_ON: @from_date , CLK_OFF: @to_date)
     
    # @times = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and ("CODE") = ?',params[:emp_id],@from_date,@to_date,'(W)')
  
  # @times = Employee.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL, :FIRST_NAME, :LAST_NAME).first.push(TimeSheet.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL,:PDATE, :ON_TIME, :OFF_TIME))
    
    
     @times = TimeSheet.search_datewise_time_report(params[:emp_id],params[:from_date],params[:to_date])
       
     @Arrdepartment = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=?',params[:emp_id],params[:from_date],params[:to_date]).distinct.pluck(:"DEPT_GROUP",:"CENTRE") if params[:emp_id] != "" 
       puts @Arrdepartment.inspect
       
     
       
       
       
       
       # puts @times.inspect
       
       #@payrollids #variable for payroll ids
       
       #@payrollwiseattendancearray #variable for array containing payroll wise attendance array
        
       #start loop through crosstab output (@times at index 1)
        
           #fetch payrollid from current index
           
           #@previouspayroll
           #@currentpayroll = payrollid from current index
           #@attendance single payroll wise array
           
           #if @payrollids = ""
              #@payrollids = @currentpayroll + ", "
              #@previouspayroll = @payrollids
              #@attendance.append (current row)
           #else if @payrollids <> "" and @currentpayroll = @previouspayroll
              #@attendance.append (current row)
           #else if @payrollids <> "" and @currentpayroll <> @previouspayroll
              #@previouspayroll = @currentpayroll 
              #@payrollids = @currentpayroll + ", "
              #@payrollwiseattendancearray.append (@attendance) OR Display @attendance to UI
              #@attendance = new array
              #@attendance.append (current row)
       
       #end loop
 
 
  end
  
  def timecard_report
  
    @times = TimeSheet.search_datewise_time_report(params[:emp_id],params[:from_date],params[:to_date])
    @Arrdepartment = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=?',params[:emp_id],params[:from_date],params[:to_date]).distinct.pluck(:"DEPT_GROUP",:"CENTRE") if params[:emp_id] != "" 

    
      respond_to do |format|
           
          format.html 
          format.xls 
      end
  end
  

end

class TimeReportsController < ApplicationController
  #before_filter :authorize
  protect_from_forgery except: :index   # ActionController::InvalidAuthenticityToken
  
  require 'date'
  
  def time_home
   # @time_sheet = TimeSheet.ransack(params[:q])
   
  end

  def search_time_report
    
    @finaltimesarray = []
    
    empid = params[:emp_id].split(',')
      # puts empid.inspect
   
    empid.each do |payroll|
     
    #@times = TimeSheet.where(PAYROLL: params[:emp_id] ,CLK_ON: @from_date , CLK_OFF: @to_date)
     
    # @times = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and ("CODE") = ?',params[:emp_id],@from_date,@to_date,'(W)')
  
  # @times = Employee.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL, :FIRST_NAME, :LAST_NAME).first.push(TimeSheet.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL,:PDATE, :ON_TIME, :OFF_TIME))
    
    
     @times = TimeSheet.search_datewise_time_report(payroll,params[:from_date],params[:to_date])
       @finaltimesarray << @times
       
   #  @ArrNonworktime = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and (("CODE") != ? and ("CODE") != ? )',payroll,params[:from_date],params[:to_date],'(W)','(X)')

   #  @Arrdepartment = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and "DEPT_GROUP" is not null and "CENTRE" is not null',payroll,params[:from_date],params[:to_date]).distinct.pluck(:"DEPT_GROUP",:"CENTRE") if payroll != "" 
     
   #  @Arrdocket = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and "DOCKET" != ? and "DOCKET" != ? ',payroll,params[:from_date],params[:to_date],'null','').distinct.pluck(:"DOCKET") if payroll != ""  
   
    end 
     puts @finaltimesarray.inspect
     
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
          format.xls 
      end
  end
  

end

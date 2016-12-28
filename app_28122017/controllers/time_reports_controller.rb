class TimeReportsController < ApplicationController
  #before_filter :authorize
  protect_from_forgery except: :index   # ActionController::InvalidAuthenticityToken
  
  require 'date'
  
  def time_home
   # @time_sheet = TimeSheet.ransack(params[:q])
   
  end

  def search_time_report
   # raise params[:from_date].inspect
  #  RuntimeError ({"from_date"=>"10/17/2016", "to_date"=>"11/17/2016", "emp_name"=>"", "emp_id"=>"", "department"=>"", "controller"=>"time_reports", 
  #  "action"=>"search_time_report"}):
    
    @from_date = params[:from_date]
    
    @to_date = params[:to_date]
      
 #@times = TimeSheet.where(PAYROLL: params[:emp_id] ,CLK_ON: @from_date , CLK_OFF: @to_date)
     
  @times = TimeSheet.where('("PAYROLL") = ? and date("CLK_ON") >=? and date("CLK_OFF") <=? and ("CODE") = ?',params[:emp_id],@from_date,@to_date,'(W)')
 
      
  # @times = Employee.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL, :FIRST_NAME, :LAST_NAME).first.push(TimeSheet.where(PAYROLL: params[:emp_id]).pluck(:PAYROLL,:PDATE, :ON_TIME, :OFF_TIME))
 
    
  end
  

end

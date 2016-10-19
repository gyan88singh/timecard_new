class EmployeesController < ApplicationController
  before_filter :authorize
  
  def import
    if params[:file]
   
    #begin
       Employee.import(params[:file])
       flash[:notice] = 'employees imported.'
       redirect_to employees_path
   # rescue
     # flash[:notice] = 'Invalid  file format.'
     #        redirect_to employees_path
   # end
       
    else
      redirect_to employees_path
    end
  end
  
  def create
        @employees = Employee.all
        @employee = Employee.create(employee_params)
  end
  
  private
     def employee_params
       raise params.inspect
       params.require(:employee).permit(:first_name, 
         :middle_name,
         :last_name,
         :badge,
         :pin,
         :gender,
         :marital,
         :social_ins,
         :hire_date,
         :birth_date,
         :senor_date,
         :term_date,
         :emergency_name,
         :floater,
         :home_address_id,
         :work_address_id,
         :time_zone,
         :common_id)
     end
  
end

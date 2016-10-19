class DepartmentsUsersController < ApplicationController
  before_filter :authorize
  
  
  def new
    
    @userdep = DepartmentsUser.new
    
  end
  
  def edit
    @departments = Department.all
       
    @userdep = User.find(params[:id])
   # raise @userdep.inspect  
  end
  
  def update
    ssss
    @userdep = User.find(params[:id])
     
       
       @user.update_attributes(user_params)
  end
  
  private
    def user_params
      fddgfg
      #raise params.inspect
    #  params.require(:user).permit(:first_name, :last_name,:domain_name,:email,:password,:password_confirmation,:is_admin,:status,:created_by,:updated_by)
      params.require(:user).permit!
    end
    
end

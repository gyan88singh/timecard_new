class UsersController < ApplicationController
  before_filter :authorize
  
  def index
#raise params.inspect
    #raise params[:page].inspect
         @q = User.ransack(params[:q])
         @users = @q.result.where("domain_name !=?",'').paginate(page: params[:page], per_page: 5).order(id: :desc)
           
    @userexport = User.order(:id)
       respond_to do |format|
       
          format.html 
          format.csv { send_data @userexport.to_csv }
          format.xlsx {
			response.headers['Content-Disposition'] = 'attachment; filename="all_users.xlsx"'
		} 
       end
      
  
   end
 
   def show
     @user = User.find(params[:id])
   end
 
   def new
     @user = User.new
   end
 
   def create
     @users = User.where("domain_name !=?",'').paginate(page: params[:page], per_page: 5).order(id: :desc)
     @user = User.create(user_params)
     #if @user
      #  redirect_to :action => 'index'
     #end
   end
 
   def edit
     @user = User.find(params[:id])
   end
 
   def update
    
     @users = User.where("domain_name !=?",'').paginate(page: params[:page], per_page: 5).order(id: :desc)
     @user = User.find(params[:id])
     @user.update_attributes(user_params)
     redirect_to :back
   end
 
   def delete
     @user = User.find(params[:user_id])
   end
 
   def destroy
   #  @users = User.where("domain_name !=?",'').paginate(page: params[:page], per_page: 5).order(id: :desc)
     @user = User.find(params[:id])
     if @user.destroy 
       redirect_to :back
     end
      
   end
   
  def new_export
    
  end
  
  
  def search_user_list
    defdfffre
    #raise params[:name].inspect
        @users = User.where("first_name ilike ? ","%#params[:name]")
  end
  
  def my_account
      @user = User.find(session[:user_id])
      @user.password = ''
     end
 
   def change_password
     @user = User.find(session[:user_id])
   end
   
   
  def save_user_info
    raise params.inspect
      @user = User.find(session[:user_id])
      if params[:old][:password] != @user.password
        @user.errors.add('',"Please Enter Old Password Correctly")
      else  
        status = @user.update_attributes(params[:user])
        flash[:notice] = 'User Details Updated Successfully' if status 
      end
      render :action => 'my_account'
    end
   
   def edit_department
     @userdep = User.find(params[:user_id])
   end
   
   def update_department
     fffff
    # params[:user][:department_ids] ||=[]
#raise params.inspect
    # @users = User.all
     @userdep = User.find(params[:user_id])
   
      @userdep.update_attributes(user_params1)
   end
  
  
 private
   def user_params
    # raise params.inspect
     params.require(:user).permit(:first_name, :last_name,:domain_name,:email,:password,:password_confirmation,:is_admin,:status,:created_by,:updated_by,:department_ids,{department_ids: []})
   # params.require(:user).permit!
   end
  
  def user_params1
       #raise params.inspect
  params.require(:user).permit(:first_name, :last_name,:domain_name,:email,:password,:password_confirmation,:is_admin,:status,:created_by,:updated_by,:department_ids)
     #  params.require(:user).permit!
     end
  
end

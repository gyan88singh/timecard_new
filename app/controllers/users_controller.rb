class UsersController < ApplicationController
  before_filter :authorize
  
  def index
    #raise params.inspect
   # if params[:q] 
          @q = User.ransack(params[:q])
          #  raise @q.result.where("domain_name !=?",'').inspect
          @users = @q.result.where("domain_name !=?",'').paginate(page: params[:page], per_page: 5).order(id: :asc)
 # else     
        #  @userss = User.order(:id)
        #  @users1 = User.all.paginate(page: params[:page], per_page: 4)
 #  end
     
      respond_to do |format|
          format.html
          format.csv { send_data @users.to_csv }
          format.xls { send_data @users.to_csv(col_sep: "\t") }
       end
      
  
   end
 
   def show
     @user = User.find(params[:id])
   end
 
   def new
     @user = User.new
   end
 
   def create
     @users = User.where("domain_name !=?",'').paginate(page: params[:page], per_page: 4).order(id: :asc)
        @user = User.create(user_params)
        
   end
 
   def edit
     @user = User.find(params[:id])
   end
 
   def update
     @users = User.where("domain_name !=?",'').paginate(page: params[:page], per_page: 4).order(id: :asc)
     @user = User.find(params[:id])
     
      @user.update_attributes(user_params)
     
   end
 
   def delete
     @user = User.find(params[:user_id])
   end
 
   def destroy
     @users = User.all
     @user = User.find(params[:id])
      if @user.destroy
         redirect_to :action=>'index'
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
     
      # session[:patient_id] = nil
      @user = User.find(session[:user_id])
      @user.password = ''
     end
 
   def change_password
   end
   
   def edit_department
     @userdep = User.find(params[:user_id])
   end
   
   def update_department
    # params[:user][:department_ids] ||=[]
#raise params.inspect
    # @users = User.all
     @userdep = User.find(params[:user_id])
   
      @userdep.update_attributes(user_params1)
   end
  
  
 private
   def user_params
     #raise params.inspect
     params.require(:user).permit(:first_name, :last_name,:domain_name,:email,:password,:password_confirmation,:is_admin,:status,:created_by,:updated_by,:department_ids,{department_ids: []})
 #    params.require(:user).permit!
   end
  
  def user_params1
       #raise params.inspect
  params.require(:user).permit(:first_name, :last_name,:domain_name,:email,:password,:password_confirmation,:is_admin,:status,:created_by,:updated_by,:department_ids)
     #  params.require(:user).permit!
     end
  
end

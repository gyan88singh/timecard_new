class LoginsController < ApplicationController
  
  def login
     render :action => new,:layout=>false
  end
  
  def new
    render :layout=> false
  end
 
 def create
 
   user = User.authenticate(params[:User][:user_name], params[:User][:password])
   if user
     session[:user_id] = user.id
     logged_in_user = User.find_by_id(user.id)
     
     new_login_details = LoginDetail.new(:user_id => logged_in_user.id  , :login_time => Time.now , :remarks => "Active")
   
     new_login_details.save!
     session[:login] = new_login_details.id
      
    
     redirect_to :action => 'index', :controller=>"users",:notice => "Logged in!"
 
       
   else
    
     flash[:notice] = "Invalid User/Password Combination."
     redirect_to root_url
 
   end
 end
 
 def destroy
  
   session[:user_id] = nil
     
   redirect_to root_url  #, :notice => "Logged out!"
 end
 
 
 def show
  render :action => 'new',:layout=> false
 end
  
end

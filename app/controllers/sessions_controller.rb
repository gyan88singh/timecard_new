class SessionsController < ApplicationController
 
  # include active_directory_user
 
   
   def new
  
     render :layout=> false
   end
 
 def create
     # username1 = ENV['USERNAME']
       # raise user.inspect    "gyanprakash.singh"
          username = params[:User][:domain_name]
          
         domain = '@tandon.local' 
        
        user = username + domain 
       # user =  'suhas.dabhade@tandon.local'
       # raise user.inspect
          
     user = User.domain_authenticates(user,params[:User][:password])
      
       userdb = User.db_authenticates(username)
    
       if user && userdb
        # session[:user_id] = userdb.id
           #raise  session[:user_id].inspect
         redirect_to :action => 'time_home', :controller=>"time_reports",:notice => "Logged in!"
         
       elsif user && !userdb
    
          #   flash[:error] = "You are not authorized user For ARS"
             
               render :action => "index", :layout => false
       elsif !user 
            render :action => "index_AD", :layout => false  
            
         # redirect_to :action => 'login',:controller => 'logins' 
         
       end
        
 end
 
 def destroy
  # raise session[:user_id].inspect
   session[:user_id] = nil
     
   redirect_to root_url  #, :notice => "Logged out!"
 end

end

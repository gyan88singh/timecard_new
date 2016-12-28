class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
 # before_filter :authorize, :except => [:new, :create]

private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

  
  
   # def authorize
   #   redirect_to '/login' unless current_user
   # end
    
  def showdate(my_date)
      if my_date
        str_date=my_date.to_date.strftime("%d-%m-%Y")
      else
        str_date=""
      end
      return str_date
    end
    
  def current_user?
       if session[:user_id].nil?
         false
       else
         true
       end
     end  

  def authorize
        unless current_user?
          flash[:error] = "Please Login to access this page !";
          session.destroy
          redirect_to root_url
          false
        end
      end  
      
  def authorize_for_reports
    if session[:user_id] == nil   
         flash[:notice] = "Please log in "
         redirect_to root_url
    else 
      
      redirect_to :action => 'time_home', :controller=>"time_reports"
         
    end
  end    
  
    
end

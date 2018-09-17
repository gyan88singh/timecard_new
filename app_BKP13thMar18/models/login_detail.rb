class LoginDetail < ActiveRecord::Base
  
  belongs_to :user
    
    validates :login_time, :presence => true
    
    def self.get_last_login_time( user)
      LoginDetail.where(["user_id = ?",user]).order('login_time desc').take(2).last 
      end
      
      
end

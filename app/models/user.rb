class User < ActiveRecord::Base
  
  has_and_belongs_to_many :departments
  
  has_many :login_details
  has_many :user_departments
   
   attr_accessor :password
   before_save :encrypt_password
  
    validates_presence_of :first_name 
    validates_presence_of :last_name
    validates_presence_of :email
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates_uniqueness_of :email
    #validates_presence_of :domain_name
    validates_uniqueness_of :domain_name
    
 # validates_uniqueness_of :user_name
    
   # validates_presence_of :is_admin, :message => "/User Type? should be selected"
  require 'rubygems'
  
  require 'net/ldap' # gem install ruby-net-ldap
  require 'csv'
  
  SERVER = '172.28.48.51'
  PORT = 389
  BASE = 'tandon.local'
  DOMAIN = 'tandon.local'
  credentials = {
    :method => :simple,
    :username =>'suhas.dabhade@tandon.local',
    :password => 'Infinx@10'
  }
  
  
  def self.domain_authenticates(username,password)
    
      ldap = Net::LDAP.new :host => SERVER,:port => PORT, :base => BASE, :domain => DOMAIN,:auth => {
                                                                                           :method => :simple,
                                                                                           :username => username,
                                                                                           :password => password
                                                                                           }
          
                            
      if ldap.bind 
        
       # and user = ldap.search(:filter => "sAMAccountName=#{username}")
       
              # Redundant? Sure - the code will be 0 and the message will be "Success".
        puts "Connection successful!  Code:  #{ldap.get_operation_result.code}, message: #{ldap.get_operation_result.message}"
       
        # GET THE DISPLAY NAME AND E-MAIL ADDRESS FOR A SINGLE USER
       # search_param = username
       # result_attrs = ["displayName"]
        
        # Build filter
       # search_filter = Net::LDAP::Filter.eq("sAMAccountName", search_param)
        
        # Execute search
       # if ldap.search(:filter => search_filter, :attributes => result_attrs, :return_result => false)
        #  puts "SUHAS DABHADE"
          return true
      #  else
       #   puts "DABHADE SUHAS"
       #   return false
      #  end
      #  puts 'i am outside'
        
      else
        
        puts "Connection failed!  Code:  #{ldap.get_operation_result.code}, message: #{ldap.get_operation_result.message}"
        return false
      end
      
     
      
    end
    
    def self.domain_search(user1)
     
      ldap = Net::LDAP.new :host => SERVER,
           :port => 389,
           :auth => {
                       :method => :simple,
                       :username => 'suhas.dabhade@tandon.local',
                       :password => 'Infinx@10'
                    }
                    
      filter = Net::LDAP::Filter.eq( "sAMAccountName", user1 )
    # raise filter.inspect
      treebase = "tandon.local"
      
      ldap.search( :base => treebase, :filter => filter ) do |entry|
      raise entry.inspect
        puts "DN: #{entry.dn}"
        entry.each do |attribute, values|
          puts "   #{attribute}:"
          values.each do |value|
            puts "      --->#{value}"
          end
        end
      end
                   
                    
    end
     
     
  def self.db_authenticates(user)
    # raise user.inspect
       user = find_by_domain_name_and_status(user,'Active')
      # raise user.inspect
       if user
         user
       else
         nil
       end
     end
  
  
  def self.authenticate(username, password)
    
     user = find_by_user_name(username)
     if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
       user
     else
       nil
     end
   end
   
   def encrypt_password
     if password.present?
       self.password_salt = BCrypt::Engine.generate_salt
       self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
     end
   end

  
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        
        csv << user.attributes.values
      end
    end
  end
 
    
  def self.search(search)
    @users = User.where("first_name ilike ? ","%#{search}%")
   # raise @users.inspect
   # where("first_name ILIKE ?", "%#{search}%") 
   # where("content LIKE ?", "%#{search}%")
  end
  
    
end

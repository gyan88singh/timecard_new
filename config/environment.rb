# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


Timecard::Application.configure do 
  config.domain_authentication = false
  
  SERVER = '172.28.48.51'
  PORT = 389
  BASE = 'tandon.local'
  DOMAIN = 'tandon.local'
  credentials = {
      :method => :simple,
      :username =>'gyanprakash.singh@tandon.local',
      :password => 'gy@ni766'
    }
    
  FTP_HOST = 'ftp.infinxincs.com'
  FTP_PORT = 21
  FTP_USERNAME = 'Cycloshare'
  FTP_PASSWORD = 'Cyclo@123'
  
end
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Timecard::Application.configure do 
  config.domain_authentication = true
 
end



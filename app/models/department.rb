class Department < ActiveRecord::Base
  has_many :users
  
  has_and_belongs_to_many :users

 def name_with_initial
     "#{department_code} | #{department_desc}"
  end
  
end

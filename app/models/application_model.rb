class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  # custom ActiveRecord methods should go here, and all application models should inherit from
  #   this instead of ActiveRecord::Base
   GENDER = ["Female", "Male"]
   
  def full_name
    "#{first_name} #{last_name}"
  end
end
class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  # custom ActiveRecord methods should go here, and all application models should inherit from
  #   this instead of ActiveRecord::Base
end
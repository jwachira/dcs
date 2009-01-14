# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include Userstamp
  include AuthenticationUtils
  include AuthorizationUtils
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2d3c5d404e8a73e3edb34c8d09be8abe'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  before_filter :require_login
  extend CustomResourceController

  def set_stamper
    User.stamper ||= current_user
  end
end

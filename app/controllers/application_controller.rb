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

  def set_stamper
    User.stamper ||= current_user
  end
  
  protected

    # Define how declarative authentication responds to permission denied.
    def permission_denied
      raise Authorization::NotAuthorized
    end
  
  private

    rescue_from Authorization::NotAuthorized, :with => :not_authorized
    def not_authorized
      render :template => "errors/403", :status => 403
    end

    rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, :with => :record_not_found
    def record_not_found
      render :template => "errors/404", :status => 404
    end
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2d3c5d404e8a73e3edb34c8d09be8abe'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation
  
  # Integration of authentication
  include AuthenticationUtils
  
  # Integration of authorization
  include AuthorizationUtils
  helper_method :current_user_session, :current_user
  # before_filter :require_login
  
  # Userstamp configuration
  include Userstamp
  def set_stamper
    User.stamper ||= current_user
  end
  
  before_filter :cancel_message
  
  protected
    def cancel_message
      if params[:_cancel]
        flash[:notice] = 'Action cancelled.'
        redirect_to url_for(params.except("_cancel"))
        false
      else
        true
      end
    end
  
    # Define how declarative authentication responds to permission denied.
    def permission_denied
      raise Authorization::NotAuthorized
    end
  
  private
    rescue_from Exception, :with => :server_error if RAILS_ENV != 'development'
    def server_error(exception)
      notify_hoptoad(exception) if respond_to?(:notify_hoptoad)
    
      request.format = :html
      render :template => "errors/500", :status => 500
    end
  
    rescue_from Authorization::NotAuthorized, :with => :not_authorized
    def not_authorized
      request.format = :html
      render :template => "errors/403", :status => 403
    end

    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::RoutingError, :with => :record_not_found if RAILS_ENV != 'development' # Authlogic & cache_classes don't play well in this context
    def record_not_found
      request.format = :html
      render :template => "errors/404", :status => 404
    end
end

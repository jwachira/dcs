module ActionControllerExtensions
  # BACKPORT OF CHANGE FROM 3.0 EDGE: http://github.com/rails/rails/commit/256b0ee8e3c1610967dfc89f864e24b98ed3c236
  # Returns true or false if a request is verified.  Checks:
  #
  # * is the format restricted?  By default, only HTML requests are checked.
  # * is it a GET request?  Gets should be safe and idempotent
  # * Does the form_authenticity_token match the given token value from the params?
  def verified_request?
    !protect_against_forgery?     ||
      request.method == :get      ||
      request.xhr?                ||
      !verifiable_request_format? ||
      form_authenticity_token == params[request_forgery_protection_token]
  end
end

ActionController::Base.send(:include, ActionControllerExtensions)
# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = true

# Don't care if the mailer can't send

ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.raise_delivery_errors = true

hostname = Socket.gethostname
# Determine our project name and iteration from our directory.                                                              
if RAILS_ROOT =~ /\/var\/www\/apps\/([^\/]+)\/([^\/]+)\/releases/
  project = $1
  iteration = $2
  @staging_host = "#{iteration}.#{project}.#{hostname}"
else
  raise "Failed to parse hostname and iteration from RAILS_ROOT(#{RAILS_ROOT}).  Please configure config/staging.rb"
end

ActionMailer::Base.smtp_settings = {
  :address => "localhost",
  :port    => 25,
  :domain  => @staging_host
}

ActionMailer::Base.default_url_options = {
  :host => @staging_host
}

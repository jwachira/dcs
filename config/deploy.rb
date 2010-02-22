#############################################################
# Set Basics
#############################################################

set :application, ""
set :user, ""


# this require needs to be run after the above variable sets as they are required by the files we load
require File.join(File.dirname(__FILE__), "../vendor/plugins/wested_cap/lib/wested/wested_cap")

#############################################################
# Set Up for Production Environment
#############################################################

task :production do
  prep_production
  set :domain, ""

  role :web, ""
  role :app, ""
  role :db , "", :primary => true
end

#############################################################
# Set Up for Development Environment
#############################################################

task :dev do
  set :staging_type, "dedicated"
  set(:rails_env ) { "development" }
  prep_staging
  set :domain, "calipers.virtual"
  role :web, "10.211.55.13"
  role :app, "10.211.55.13"
  role :db , "10.211.55.13", :primary => true
end

#############################################################
# Set Up for Staging Environment
#############################################################

task :staging do
  prep_staging
  # We use a single server for all projects for staging.
  # You can set your default staging ipaddresses and url in
  # defaults/staging_defaults in the plugin
  #
  # Or you can override them here.
end


#############################################################
# Project Specific Symlinks
#############################################################

# these are project specific but still reside in shared
# eg 'foo/bar' => 'bar'
# creates the command "rm -rf #{release_path}/bar && ln -s #{shared_path}/foo/bar #{release_path}/bar"

#set :custom_symlinks, {}

# these are project specific but are the strange guys - they need full from paths
# eg '/var/www/apps/project/foo' => 'foo'
# creates the command "rm -rf #{release_path}/foo && ln -s /var/www/apps/project/foo #{release_path}/foo"

#set :other_symlinks, {}

#############################################################
# Project Specific Tasks
#############################################################

# place other tasks here and link in via
#after "passenger:restart", "project_namespace:new_task_name"


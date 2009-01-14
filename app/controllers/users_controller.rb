class UsersController < ApplicationController
  before_filter :require_object_is_current_user
  customized_resource_controller
  actions :all
end

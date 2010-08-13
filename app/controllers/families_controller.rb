class FamiliesController < ApplicationController
 resource_controller
 
 def new
  @family = Family.new
  2.times {@family.guardians.build}
  @family.children.build
 end

 create.wants.html {
   redirect_to provider_url(current_user.provider)
 }
 
end

class EmergencyContactsController < ApplicationController
 before_filter :require_login
 
 resource_controller
 
 create.wants.html { 
   flash[:notice] = "Emergency Contact Successfully created."
   redirect_to family_url(@emergency_contact.family)
  }
 
 update.wants.html {
   flash[:notice] = "Emergency Contact Successfully updated."
   redirect_to family_url(@emergency_contact.family)
 }
 
 edit.before do
   @family = Family.find(params[:family_id])
 end
 
end

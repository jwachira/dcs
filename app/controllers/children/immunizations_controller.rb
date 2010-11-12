class Children::ImmunizationsController < ApplicationController
  resource_controller

  def index
    @immunizations = Immunization.all
    @child = Child.find(params[:child_id])
  end

  def update_all
    @child = Child.find(params[:child_id])
    if params && params[:immunization]
      params[:immunization].each_pair do |id, values|
        child_immunization = @child.child_immunizations.find(id)
        child_immunization.exempted       = values[:exempted]
        child_immunization.administered   = values[:administered]
        child_immunization.last_dose_date = values[:last_dose_date]
        child_immunization.next_dose_date = values[:next_dose_date]
        child_immunization.save!
      end
      flash[:notice] = "#{@child.full_name} immunization history has been successfully updated"
      redirect_to child_url(@child)
    else
      flash[:error] = "We could not update #{@child.full_name}, Please try again."
      redirect_to child_immunizations_url(@child)
    end

  end
end

class TeachersController < ApplicationController
 resource_controller
 
 def create
  @teacher = Teacher.new(params[:teacher])
  @teacher.provider = current_user.provider
  if @teacher.save
    flash[:notice] = "Teacher record has been successfully created"
    redirect_to provider_teachers_url(current_user.provider)
  else
    render 'new'
  end
 end
 
 def update
  @teacher = Teacher.find(params[:id])
  @teacher.attributes = params[:teacher]
  @teacher.provider   = current_user.provider
  if @teacher.save
    flash[:notice] = "Teacher record has been successfully updated"
    redirect_to provider_teacher_url(current_user.provider, @teacher)
  else
    render 'edit'
  end
 end

end

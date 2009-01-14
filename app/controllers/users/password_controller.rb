class Users::PasswordController < ApplicationController
  before_filter :require_object_is_current_user
  skip_before_filter :require_manager
  
  def edit
    @user = object
  end

  def update
    @user = object
    if @user.valid_password?(params[:user][:current_password])
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if params[:user][:password].blank?
        flash[:notice] = "You must enter a new password."
        render :action => :edit
      else
        if @user.save
          flash[:notice] = "Password successfully changed."
          redirect_to user_url(@user)
        else
          flash[:notice] = "There was a problem changing your password."
          render :action => :edit
        end
      end
    else
      flash[:notice] = "The current password you entered is incorrect."
      render :action => :edit
    end
  end

  private

  def object
    @object ||= User.find(params[:user_id])
  end
  
end

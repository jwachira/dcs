class Users::PasswordController < ApplicationController
  filter_access_to :all
  filter_access_to :edit, :update, :attribute_check => true, :load_method => :object
  
  def edit
    @user = object
  end

  def update
    @user = object
    if @user.valid_password?(params[:user][:current_password])
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if params[:user][:password].blank?
        flash.now[:error] = "You must enter a new password."
        render :action => :edit
      else
        if @user.save
          flash[:notice] = "Password successfully changed."
          redirect_to user_url(@user)
        else
          flash.now[:error] = "There was a problem changing your password."
          render :action => :edit
        end
      end
    else
      flash.now[:error] = "The current password you entered is incorrect."
      render :action => :edit
    end
  end

  private

  def object
    @object ||= User.find(params[:user_id])
  end
  
end

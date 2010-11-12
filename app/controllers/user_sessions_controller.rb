class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :require_not_logged_in, :only => [:new,:create]

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful"
      redirect_back_or_default user_url(@user_session.user)
    else
      flash[:error] = "Login unsuccessful"
      redirect_to login_url
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end

end

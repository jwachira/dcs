module AuthorizationUtils
  private

  def require_login
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access that page"
      redirect_to login_url
      return false
    end
  end

  def require_not_logged_in
    if current_user
      redirect_back_or_default root_url
      return false
    end
  end
end

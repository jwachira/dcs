ActionController::Routing::Routes.draw do |map|
  map.resources :password_resets
  map.resource :account, :controller => "users"
  
  map.resource :user_session
  map.root :controller => "special", :action => "home"
  map.login  'login',  :controller => "user_sessions", :action => "new"
  map.logout 'logout', :controller => "user_sessions", :action => "destroy"
  map.resources :users, :member => {:delete => :get} do |user|
    user.resource :activation, :controller => "users/activation", :member => {:delete => :get}
    user.resource :password, :controller => "users/password"
  end
  
  map.resources :emergency_contacts
  map.resources :teachers
  map.resources :families
  map.resources :providers
end

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
  
  map.resources :immunizations
  map.resources :waiting_lists
  map.resources :children, :member => {:child_family => :get}

  map.resources :families do |family|
    family.resources :guardians
    family.resources :emergency_contacts
    family.resources :children
  end
  
  map.resources :providers do |provider|
    provider.resources :provider_contacts
    provider.resources :teachers do |teacher|
      teacher.resources :certifications
    end
  end
  
end

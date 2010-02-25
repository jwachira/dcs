authorization do

  role :guest do
    # add permissions for guests here, e.g.
    #has_permission_on :conferences, :to => :read
  end

  role :user do
    includes :guest
    has_permission_on [:users, :users_password], :to => [:read,:update] do
      if_attribute :id => is {user.id}
    end
  end

  role :admin do
    includes :user
    has_permission_on :users, :to => [:manage, :set_role]
  end
end
 
privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :destroy]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :destroy, :includes => :delete
  
  # Misc, non-RESTful privileges
  privilege :set_role # used on User
end
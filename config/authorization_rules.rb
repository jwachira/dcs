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
    has_permission_on :users, :to => :manage
  end
end
 
privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
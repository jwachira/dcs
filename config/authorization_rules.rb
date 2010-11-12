authorization do
  role :general do
    has_permission_on [:users, :users_password], :to => [:read,:update] do
      if_attribute :id => is {user.id}
    end
  end
  
  role :parent do
    includes :general
  end
  
  role :guardian do
    includes :general
  end
  
  role :parent do
    includes :general
  end
  
  role :teacher do
    includes :general
  end
  
  role :admin do
    includes :general
    has_permission_on :users, :to => [:manage, :set_role]
  end
end
 
privileges do
  privilege :manage, :includes => [:create, :read, :update, :destroy]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :destroy, :includes => :delete
  privilege :set_role # used on User
end
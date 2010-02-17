authorization do  
  role :admin do  
    has_permission_on [:bills, :customers, :product_batches, :purchase_bills, :sale_bills, :products, :users, :franchises, :suppliers], :to => [:index, :show, :new, :create, :edit, :update, :destroy]  
    has_permission_on [:products, :product_batches], :to => [:autocomplete]

    has_permission_on :user_sessions, :to => [:destroy]
  end

  role :operator do
    has_permission_on [:product_batches, :products], :to => [:index, :show, :new, :create, :edit, :update]  
    has_permission_on [:purchase_bills, :sale_bills], :to => [:index, :show, :new, :create, :edit, :update]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
    has_permission_on :users do
      to :update
      if_attribute :id => is {user.id}
    end

    has_permission_on :user_sessions, :to => [:destroy]
  end
  
  role :franchise do
    has_permission_on :customers, :to => [:index, :show, :new, :create, :edit, :update] 
    has_permission_on :bills, :to => [:index, :new, :create] 
    has_permission_on :bills do
      to :show
      if_attribute :franchise => is_in {user.franchises}
    end
    has_permission_on :sale_bills do
      to :show
      if_attribute :franchise => is {user.franchise}
    end
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
    has_permission_on :users do
      to :update
      if_attribute :id => is {user.id}
    end

    has_permission_on :user_sessions, :to => [:destroy]
  end
  role :guest do
    has_permission_on :user_sessions, :to => [:new, :create]
  end
end  
privileges do
  privilege :update do
    includes :edit
  end
end


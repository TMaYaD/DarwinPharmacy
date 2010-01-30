authorization do  
  role :admin do  
    has_permission_on [:bills, :customers, :product_batches, :purchase_bills, :sale_bills, :products, :users, :franchises, :suppliers], :to => [:index, :show, :new, :create, :edit, :update, :destroy]  
    has_permission_on :user_sessions, :to => [:destroy]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
  end

  role :operator do
    has_permission_on [:product_batches, :products], :to => [:index, :show, :new, :create, :edit, :update]  
    has_permission_on :user_sessions, :to => [:destroy]
    has_permission_on [:purchase_bills, :sale_bills], :to => [:index, :show, :new, :create, :edit, :update]
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
  end
  
  role :franchise do
    has_permission_on :customers, :to => [:index, :show, :new, :create, :edit, :update] 
    has_permission_on :bills do
      to :show
      if_attribute :created_by => is {user}
    end
    has_permission_on :sale_bills do
      to :show
      if_attribute :franchise => is {Franchise.find_by_franchisee_id(user.id)}
    end
    has_permission_on [:products, :product_batches], :to => [:autocomplete]
    has_permission_on :user_sessions, :to => [:destroy]
  end
  role :guest do
    has_permission_on :user_sessions, :to => [:new, :create]
  end
end  

